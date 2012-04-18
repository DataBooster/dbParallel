using System;
using System.Data;
using System.Data.Common;

namespace TaskParallelWorkflow.DataAccess
{
	public partial class DbAccess : IDisposable
	{
		private DbConnection _Connection;
		private const int _MaxRetryCount = 2;

		public DbAccess(DbProviderFactory dbProviderFactory, string connectionString)
		{
			_Connection = dbProviderFactory.CreateConnection();
			_Connection.ConnectionString = connectionString;
			_Connection.Open();
		}

		public DbAccess(string providerName, string connectionString)
			: this(DbProviderFactories.GetFactory(providerName), connectionString)
		{
		}

		private DbCommand CreateCommand(string commandText, int commandTimeout, CommandType commandType, Action<DbParameterBuilder> parametersBuilder)
		{
			DbCommand dbCommand = _Connection.CreateCommand();
			dbCommand.CommandType = commandType;
			dbCommand.CommandText = commandText;

			if (commandTimeout > 0)
				dbCommand.CommandTimeout = commandTimeout;

			if (parametersBuilder != null)
				parametersBuilder(new DbParameterBuilder(dbCommand));

			return dbCommand;
		}

		partial void OnConnectionLoss(Exception dbException, ref bool canRetry);
		private bool OnConnectionLoss(Exception dbException)
		{
			bool canRetry = false;
			OnConnectionLoss(dbException, ref canRetry);
			return canRetry;
		}

		public void ExecuteReader(string commandText, int commandTimeout, CommandType commandType, Action<DbParameterBuilder> parametersBuilder, Action<DbDataReader> dataReader)
		{
			DbDataReader reader = null;

			for (int retry = 0; ; retry++)
			{
				try
				{
					reader = CreateCommand(commandText, commandTimeout, commandType, parametersBuilder).ExecuteReader();
					break;
				}
				catch (Exception e)
				{
					if (retry < _MaxRetryCount && OnConnectionLoss(e))
						ReConnect();
					else
						throw;
				}
			}

			if (reader != null)
			{
				try
				{
					if (dataReader != null)
						while (reader.Read())
							dataReader(reader);
				}
				finally
				{
					reader.Close();
				}
			}
		}

		public void ExecuteReader(string commandText, Action<DbParameterBuilder> parametersBuilder, Action<DbDataReader> dataReader)
		{
			ExecuteReader(commandText, 0, CommandType.StoredProcedure, parametersBuilder, dataReader);
		}

		public int ExecuteNonQuery(string commandText, int commandTimeout, CommandType commandType, Action<DbParameterBuilder> parametersBuilder)
		{
			int nAffectedRows = 0;

			for (int retry = 0; ; retry++)
			{
				try
				{
					nAffectedRows = CreateCommand(commandText, commandTimeout, commandType, parametersBuilder).ExecuteNonQuery();
					break;
				}
				catch (Exception e)
				{
					if (retry < _MaxRetryCount && OnConnectionLoss(e))
						ReConnect();
					else
						throw;
				}
			}

			return nAffectedRows;
		}

		public int ExecuteNonQuery(string commandText, Action<DbParameterBuilder> parametersBuilder = null)
		{
			return ExecuteNonQuery(commandText, 0, CommandType.StoredProcedure, parametersBuilder);
		}

		private void ReConnect()
		{
			if (_Connection != null)
				if (_Connection.State != ConnectionState.Closed)
				{
					_Connection.Close();
					_Connection.Open();
				}
		}

		#region IDisposable Members
		public void Dispose()
		{
			if (_Connection != null)
			{
				if (_Connection.State != ConnectionState.Closed)
					_Connection.Close();
				_Connection = null;
			}
		}
		#endregion
	}
}
