using System;
using TaskParallelWorkflow.DataAccess;

namespace TaskParallelWorkflow.Dispatcher
{
	using Models;

	internal class ParallelTask
	{
		private int _PJobID;
		public int PJobID
		{
			get { return _PJobID; }
		}

		private short _TaskID;
		public short TaskID
		{
			get { return _TaskID; }
		}

		private int _CommandTimeout;
		public int CommandTimeout
		{
			get { return _CommandTimeout; }
		}

		public ParallelTask(int pJobID, short taskID, int commandTimeout)
		{
			_PJobID = pJobID;
			_TaskID = taskID;
			_CommandTimeout = commandTimeout;
		}

		public bool Execute()
		{
			using (DbAccess dbAccess = DbPackage.CreateConnection())
			{
				return Execute(dbAccess);
			}
		}

		public bool Execute(DbAccess dbAccess)
		{
			try
			{
				dbAccess.RunParallelTask(_PJobID, _TaskID, _CommandTimeout);
				return true;
			}
			catch (Exception e)
			{
				dbAccess.FaultParallelTask(_PJobID, _TaskID, e.Message);
				return false;
			}
		}
	}
}
