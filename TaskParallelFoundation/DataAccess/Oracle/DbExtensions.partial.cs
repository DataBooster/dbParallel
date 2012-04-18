#if ORACLE
using DDTek.Oracle;

namespace TaskParallelWorkflow.DataAccess
{
	public static partial class DbExtensions
	{
		public static OracleParameter SetOracleType(this OracleParameter oracleParameter, OracleDbType oraType)
		{
			oracleParameter.OracleDbType = oraType;
			return oracleParameter;
		}

		public static OracleParameter SetScale(this OracleParameter oracleParameter, byte nScale)
		{
			oracleParameter.Scale = nScale;
			return oracleParameter;
		}

		public static OracleParameter SetPrecision(this OracleParameter oracleParameter, byte nPrecision)
		{
			oracleParameter.Precision = nPrecision;
			return oracleParameter;
		}
	}
}
#endif
