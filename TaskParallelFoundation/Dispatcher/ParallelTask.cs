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

////////////////////////////////////////////////////////////////////////////////////////////////////
//
//	Copyright 2012 Abel Cheng
//	This source code is subject to terms and conditions of the Apache License, Version 2.0.
//	See http://www.apache.org/licenses/LICENSE-2.0.
//	All other rights reserved.
//	You must not remove this notice, or any other, from this software.
//
//	Original Author:	Abel Cheng <abelcys@gmail.com>
//	Created Date:		2012-03-23
//	Primary Host:		http://dbParallel.codeplex.com
//	Change Log:
//	Author				Date			Comment
//
//
//
//
//	(Keep clean code rather than complicated code plus long comments.)
//
////////////////////////////////////////////////////////////////////////////////////////////////////
