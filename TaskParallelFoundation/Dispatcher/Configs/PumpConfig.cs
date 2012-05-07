using System.Threading;
using System.Threading.Tasks;
using System.Data.Common;
using System.Configuration;
using DbParallel.Dispatcher.Models;

namespace DbParallel.Dispatcher.Configs
{
	public static class PumpConfig
	{
		private static DbProviderFactory _DbProviderFactory;
		public static DbProviderFactory DbProviderFactory
		{
			get { return _DbProviderFactory; }
		}

		private static string _ConnectionString;
		public static string ConnectionString
		{
			get { return _ConnectionString; }
		}

		private static string _DatabasePackage;
		public static string DatabasePackage
		{
			get { return _DatabasePackage; }
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
			const string connectionSettingKey = "TPW_Database";
			const string packageSettingKey = "TPW_Package";

			ConnectionStringSettings connSetting = ConfigurationManager.ConnectionStrings[connectionSettingKey];
			_DbProviderFactory = DbProviderFactories.GetFactory(connSetting.ProviderName);
			_ConnectionString = connSetting.ConnectionString;

			_DatabasePackage = ConfigurationManager.AppSettings[packageSettingKey];
			if (_DatabasePackage == null)
				_DatabasePackage = string.Empty;

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
