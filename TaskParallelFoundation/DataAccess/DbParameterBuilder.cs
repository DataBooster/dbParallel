using System;
using System.Data.Common;

namespace TaskParallelWorkflow.DataAccess
{
	public partial class DbParameterBuilder
	{
		private readonly DbCommand _DbCommand;

		public DbParameterBuilder(DbCommand dbCommand)
		{
			_DbCommand = dbCommand;
		}

		public DbParameter Add()
		{
			DbParameter parameter = _DbCommand.CreateParameter();
			_DbCommand.Parameters.Add(parameter);

			return parameter;
		}

		public DbParameter Add(string parameterName, object oValue)
		{
			DbParameter parameter = _DbCommand.CreateParameter();
			parameter.ParameterName = parameterName;
			parameter.Value = (oValue == null) ? DBNull.Value : oValue;
			_DbCommand.Parameters.Add(parameter);

			return parameter;
		}
	}
}
