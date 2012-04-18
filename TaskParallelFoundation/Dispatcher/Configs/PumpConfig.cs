using System.Threading;
using System.Threading.Tasks;
using System.Data.Common;
using System.Configuration;
using TaskParallelWorkflow.Dispatcher.Models;

namespace TaskParallelWorkflow.Dispatcher.Configs
{
	internal static class PumpConfig
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

		public static DbAppSettings AppSettingsInDb
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

		public static int PrimaryInterval
		{
			get { return _DbAppSettings.PrimaryInterval; }
		}

		public static int StandbyInterval
		{
			get { return _DbAppSettings.StandbyInterval; }
		}

		public static ParallelOptions ParallelOption
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
