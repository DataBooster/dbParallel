using System;
using System.Threading;
using System.Threading.Tasks;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using DbParallel.DataAccess;

namespace DbParallel.Dispatcher
{
	using DbInterface;
	using Configs;

	public class PumpMain : IDisposable
	{
		public enum ServiceMode
		{
			Standby,		// The Pump Service run in Standby Mode.
			Primary			// The Pump Service run in Primary Mode.
		}

		private static int _ServiceModeMaxLen = 0;
		public static int ServiceModeMaxLen
		{
			get
			{
				if (_ServiceModeMaxLen == 0)
					_ServiceModeMaxLen = Enum.GetNames(typeof(ServiceMode)).Max(e => e.Length);
				return _ServiceModeMaxLen;
			}
		}

		private ServiceMode _ServiceMode;
		private readonly DbAccess _MainDbAccess;
		private readonly List<ParallelJob> _ParallelJobs;
		private readonly PumpSynchronizer _Synchronizer;
		private readonly EventLog _ServiceEventLog;

		public PumpMain(EventLog serviceEventLog = null)
		{
			_ServiceMode = ServiceMode.Standby;
			_MainDbAccess = DbPackage.CreateConnection();

			PumpConfig.AppSettingsInDb = _MainDbAccess.GetServiceConfig();

			_ParallelJobs = new List<ParallelJob>();
			_Synchronizer = new PumpSynchronizer();
			_ServiceEventLog = serviceEventLog;
		}

		private void SetServiceMode(string switchToMode)
		{
			ServiceMode newMode;

			if (Enum.TryParse<ServiceMode>(switchToMode, out newMode))
				if (newMode != _ServiceMode)
				{
					if (_ServiceEventLog != null)
						_ServiceEventLog.WriteEntry("ServiceMode switch from " + _ServiceMode.ToString() + " Mode to " + newMode.ToString() + " Mode.");

					_ServiceMode = newMode;
				}
		}

		public Task Start()
		{
			return _Synchronizer.StartPump(() =>
				{
					while (_Synchronizer.KeepPumping)
					{
						try
						{
							SetServiceMode((_ServiceMode == ServiceMode.Primary) ? _MainDbAccess.PumpParallelJob(pJob =>
								{
									_ParallelJobs.Add(new ParallelJob(pJob.Field<int>("PJOB_ID")));
								}) : _MainDbAccess.StandbyPing());

							if (_ParallelJobs.Count > 0)
							{
								foreach (ParallelJob pj in _ParallelJobs)
									pj.Run(_MainDbAccess, _Synchronizer);

								_ParallelJobs.Clear();
							}
						}
						catch (Exception e)
						{
							if (_ServiceEventLog != null)
								_ServiceEventLog.WriteEntry(e.Message, EventLogEntryType.Error);

							_MainDbAccess.LogSysError(e.Source, e.Message);
						}

						Thread.Sleep((_ServiceMode == ServiceMode.Primary) ? PumpConfig.PrimaryInterval : PumpConfig.StandbyInterval);
					}
				});
		}

		public void Stop()
		{
			_Synchronizer.StopPump();
		}

		public void Dispose()
		{
			_MainDbAccess.Dispose();
			_Synchronizer.Dispose();
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
