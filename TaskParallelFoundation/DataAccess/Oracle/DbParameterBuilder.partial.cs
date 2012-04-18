#if ORACLE
using DDTek.Oracle;

namespace TaskParallelWorkflow.DataAccess
{
	public partial class DbParameterBuilder
	{
		public OracleParameter AddAssociativeArray(string parameterName, OracleDbType oraType)
		{
			OracleCommand oraCommand = _DbCommand as OracleCommand;
			OracleParameter parameter = oraCommand.CreateParameter();

			parameter.ParameterName = parameterName;
			parameter.OracleDbType = oraType;
			parameter.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
			oraCommand.Parameters.Add(parameter);

			return parameter;
		}
	}
}
#endif
