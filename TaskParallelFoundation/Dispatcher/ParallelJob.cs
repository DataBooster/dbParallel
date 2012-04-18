using System;
using System.Threading;
using System.Threading.Tasks;
using System.Collections.Generic;
using TaskParallelWorkflow.DataAccess;

namespace TaskParallelWorkflow.Dispatcher
{
	using Models;
	using Configs;

	internal class ParallelJob : IDisposable
	{
		private int _PJobID;
		private List<ParallelTask> _ParallelTasks;
		private ParallelTask _SuccessCallbackTask;
		private ParallelTask _FailCallbackTask;

		public int PJob_ID
		{
			get { return _PJobID; }
		}

		public ParallelJob(int pJob_ID)
		{
			_PJobID = pJob_ID;
			_ParallelTasks = new List<ParallelTask>();
		}

		public void Run(DbAccess dbAccess, PumpSynchronizer synchronizer)
		{
			dbAccess.RunParallelJob(_PJobID, task =>
				{
					ParallelTask parallelTask = new ParallelTask(
						task.Field<int>("PJOB_ID"),
						task.Field<short>("TASK_ID"),
						(task.Field<byte>("COMMAND_TIMEOUT") * 60)
					);

					switch (parallelTask.TaskID)
					{
						case 0:
							_SuccessCallbackTask = parallelTask;
							break;
						case -1:
							_FailCallbackTask = parallelTask;
							break;
						default:
							_ParallelTasks.Add(parallelTask);
							break;
					}
				});

			if (_ParallelTasks.Count > 0)
				synchronizer.StartNewTask(() => { ExecuteTasks(); });
		}

		private void ExecuteTasks()
		{
			int errorTasks = 0;

			Parallel.ForEach(_ParallelTasks, PumpConfig.ParallelOption, task =>
				{
					if (task.Execute() == false)
						Interlocked.Increment(ref errorTasks);
				});

			using (DbAccess dbAccess = DbPackage.CreateConnection())
			{
				ParallelTask callbackTask = (errorTasks > 0) ? _FailCallbackTask : _SuccessCallbackTask;

				if (callbackTask != null)
					callbackTask.Execute(dbAccess);

				dbAccess.CompleteParallelJob(_PJobID);
			}

			Dispose();
		}

		public void Dispose()
		{
			_ParallelTasks.Clear();
			_SuccessCallbackTask = null;
			_FailCallbackTask = null;
		}
	}
}
