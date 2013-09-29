using System.Threading;
using System.Threading.Tasks;
using System.Data.Common;
using DbParallel.Dispatcher.DbInterface;
using DbParallel.Dispatcher.DataAccess;

namespace DbParallel.Dispatcher
{
	public static class PumpConfig
	{
		public static DbProviderFactory DbProviderFactory
		{
			get { return ConfigHelper.DbProviderFactory; }
		}

		public static string ConnectionString
		{
			get { return ConfigHelper.ConnectionString; }
		}

		public static string DatabasePackage
		{
			get { return ConfigHelper.DatabasePackage; }
		}

		private static DbAppSettings _DbAppSettings;
		private static ParallelOptions _ParallelOption;

		internal static DbAppSettings AppSettingsInDb
		{
			set
			{
				_DbAppSettings = value;

				if (_DbAppSettings.DegreeOfTaskParallelism > 1)
					_ParallelOption.MaxDegreeOfParallelism = _DbAppSettings.DegreeOfTaskParallelism;

				if (_DbAppSettings.MaxThreadsInPool >= 64)
					SetMaxThreads(_DbAppSettings.MaxThreadsInPool);
			}
		}

		private static void SetMaxThreads(int workerThreads)
		{
			int maxWorker, maxIOC;

			ThreadPool.GetMaxThreads(out maxWorker, out maxIOC);

			if (workerThreads != maxWorker)
				ThreadPool.SetMaxThreads(workerThreads, maxIOC);
		}

		internal static int PrimaryInterval
		{
			get { return _DbAppSettings.PrimaryInterval; }
		}

		internal static int StandbyInterval
		{
			get { return _DbAppSettings.StandbyInterval; }
		}

		internal static ParallelOptions ParallelOption
		{
			get { return PumpConfig._ParallelOption; }
		}

		static PumpConfig()
		{
			_ParallelOption = new ParallelOptions();
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
