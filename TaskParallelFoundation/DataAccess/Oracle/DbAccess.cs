#if ORACLE
using System;
using DDTek.Oracle;

namespace TaskParallelWorkflow.DataAccess
{
	public partial class DbAccess
	{
		partial void OnConnectionLoss(Exception dbException, ref bool canRetry)
		{
			if (_Connection is OracleConnection)
			{
				OracleException e = dbException as OracleException;

				if (e == null)
					canRetry = false;
				else
					switch (e.Number)
					{
						case 4068: canRetry = true; break;
						// To add other cases
						default: canRetry = false; break;
					}
			}
		}
	}
}
#endif
