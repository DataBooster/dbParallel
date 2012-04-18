﻿using System;
using System.Data;
using System.Data.Common;
using TaskParallelWorkflow.DataAccess;
using TaskParallelWorkflow.Dispatcher.Configs;

namespace TaskParallelWorkflow.Dispatcher.Models
{
	internal static class DbPackage
	{
		public static DbAccess CreateConnection()
		{
			return new DbAccess(PumpConfig.DbProviderFactory, PumpConfig.ConnectionString);
		}

		private static string GetProcedure(string sp)
		{
			return PumpConfig.DatabasePackage + sp;
		}

		public static DbAppSettings GetServiceConfig(this DbAccess dbAccess)
		{
			const string sp = "GET_SERVICE_CONFIG";
			DbParameter outPrimaryInterval = null, outStandbyInterval = null, outMaxThreadsInPool = null, outDegreeOfTaskParallelism = null;

			dbAccess.ExecuteNonQuery(GetProcedure(sp), parameters =>
				{
					outPrimaryInterval = parameters.Add().SetName("outPrimary_Interval").SetDirection(ParameterDirection.Output).SetDbType(DbType.Int32);
					outStandbyInterval = parameters.Add().SetName("outStandby_Interval").SetDirection(ParameterDirection.Output).SetDbType(DbType.Int32);
					outDegreeOfTaskParallelism = parameters.Add().SetName("outDegree_Task_Parallelism").SetDirection(ParameterDirection.Output).SetDbType(DbType.Int32);
					outMaxThreadsInPool = parameters.Add().SetName("outMax_Threads_In_Pool").SetDirection(ParameterDirection.Output).SetDbType(DbType.Int32);
				});

			return new DbAppSettings(
				outPrimaryInterval.Parameter<int>(),
				outStandbyInterval.Parameter<int>() * 1000,
				outDegreeOfTaskParallelism.Parameter<int>(),
				outMaxThreadsInPool.Parameter<int>()
				 );
		}

		public static string StandbyPing(this DbAccess dbAccess)
		{
			const string sp = "STANDBY_PING";
			DbParameter outParameter = null;

			dbAccess.ExecuteNonQuery(GetProcedure(sp), parameters =>
				{
					outParameter = parameters.Add().SetName("outSwitch_To_Mode").SetDirection(ParameterDirection.Output).SetSize(PumpMain.ServiceModeMaxLen);
				});

			return outParameter.Value as string;
		}

		public static string PumpParallelJob(this DbAccess dbAccess, Action<DbDataReader> jobsReader)
		{
			const string sp = "PUMP_PJOB";
			DbParameter outParameter = null;

			dbAccess.ExecuteReader(GetProcedure(sp), parameters =>
				{
					outParameter = parameters.Add().SetName("outSwitch_To_Mode").SetDirection(ParameterDirection.Output).SetSize(PumpMain.ServiceModeMaxLen);
				}, jobsReader);

			return outParameter.Value as string;
		}

		public static void RunParallelJob(this DbAccess dbAccess, int nPJob_ID, Action<DbDataReader> tasksReader)
		{
			const string sp = "RUN_PJOB";

			dbAccess.ExecuteReader(GetProcedure(sp), parameters =>
				{
					parameters.Add("inPJob_ID", nPJob_ID);
				}, tasksReader);
		}

		public static void RunParallelTask(this DbAccess dbAccess, int nPJob_ID, short nTask_ID, int nCommandTimeout)
		{
			const string sp = "RUN_TASK";

			dbAccess.ExecuteNonQuery(GetProcedure(sp), nCommandTimeout, CommandType.StoredProcedure, parameters =>
				{
					parameters.Add("inPJob_ID", nPJob_ID);
					parameters.Add("inTask_ID", nTask_ID);
				});
		}

		public static void FaultParallelTask(this DbAccess dbAccess, int nPJob_ID, short nTask_ID, string errorMessage)
		{
			const string sp = "FAULT_TASK";

			dbAccess.ExecuteNonQuery(GetProcedure(sp), parameters =>
			{
				parameters.Add("inPJob_ID", nPJob_ID);
				parameters.Add("inTask_ID", nTask_ID);
				parameters.Add("inError_Message", errorMessage);
			});
		}

		public static void CompleteParallelJob(this DbAccess dbAccess, int nPJob_ID)
		{
			const string sp = "COMPLETE_PJOB";

			dbAccess.ExecuteNonQuery(GetProcedure(sp), parameters =>
			{
				parameters.Add("inPJob_ID", nPJob_ID);
			});
		}

		public static void LogSysError(this DbAccess dbAccess, string strReference, string strMessage)
		{
			const string sp = "LOG_SYS_ERROR";

			dbAccess.ExecuteNonQuery(GetProcedure(sp), parameters =>
			{
				parameters.Add("inReference", strReference);
				parameters.Add("inMessage", strMessage);
			});
		}
	}
}
