using System;
using System.Threading;
using System.Threading.Tasks;

namespace DbParallel.Dispatcher
{
	internal class PumpSynchronizer : IDisposable
	{
		private volatile bool _KeepPumping;
		private ManualResetEvent _EndingEvent;
		private int _ExecutingCount;

		public PumpSynchronizer()
		{
			_KeepPumping = false;
			_EndingEvent = new ManualResetEvent(false);
			_ExecutingCount = 0;
		}

		public bool KeepPumping
		{
			get { return _KeepPumping; }
		}

		private void EnterTask()
		{
			Interlocked.Increment(ref _ExecutingCount);
		}

		private void ExitTask()
		{
			if (Interlocked.Decrement(ref _ExecutingCount) == 0)
				if (_KeepPumping == false)
					_EndingEvent.Set();
		}

		public Task StartNewTask(Action action)
		{
			EnterTask();

			return Task.Factory.StartNew(() =>
			{
				try
				{
					action();
				}
				finally
				{
					ExitTask();
				}
			});
		}

		public Task StartPump(Action action)
		{
			if (_KeepPumping)
				return null;

			_KeepPumping = true;

			return StartNewTask(action);
		}

		public void StopPump()
		{
			_KeepPumping = false;

			if (_ExecutingCount > 0)
				_EndingEvent.WaitOne();
		}

		public void Dispose()
		{
			if (_EndingEvent != null)
			{
				_EndingEvent.Close();
				_EndingEvent = null;
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
