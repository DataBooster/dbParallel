﻿using System;
using System.Data;
using System.Data.Common;

namespace TaskParallelWorkflow.DataAccess
{
	public static partial class DbExtensions
	{
		private static bool IsNullable(this Type type)
		{
			return (type.IsGenericType && type.GetGenericTypeDefinition() == typeof(Nullable<>));
		}

		private static T TryConvert<T>(object dbValue)
		{
			if (dbValue == null || Convert.IsDBNull(dbValue))
				return default(T);
			else
			{
				try
				{
					return (T)dbValue;
				}
				catch (InvalidCastException)
				{
					Type t = typeof(T);

					return (T)Convert.ChangeType(dbValue, t.IsNullable() ? Nullable.GetUnderlyingType(t) : t);
				}
			}
		}

		public static T Field<T>(this DbDataReader reader, string columnName)
		{
			return TryConvert<T>(reader[columnName]);
		}

		public static T Field<T>(this DbDataReader reader, int ordinal)
		{
			return TryConvert<T>(reader[ordinal]);
		}

		public static T Parameter<T>(this DbCommand cmd, string parameterName)
		{
			return TryConvert<T>(cmd.Parameters[parameterName].Value);
		}

		public static T Parameter<T>(this DbParameter parameter)
		{
			return TryConvert<T>(parameter.Value);
		}


		public static DbParameter SetDbType(this DbParameter dbParameter, DbType dbType)
		{
			dbParameter.DbType = dbType;
			return dbParameter;
		}

		public static DbParameter SetDirection(this DbParameter dbParameter, ParameterDirection parameterDirection)
		{
			dbParameter.Direction = parameterDirection;
			return dbParameter;
		}

		public static DbParameter SetIsNullable(this DbParameter dbParameter, bool isNullable)
		{
			dbParameter.IsNullable = isNullable;
			return dbParameter;
		}

		public static DbParameter SetName(this DbParameter dbParameter, string parameterName)
		{
			dbParameter.ParameterName = parameterName;
			return dbParameter;
		}

		public static DbParameter SetSize(this DbParameter dbParameter, int nSize)
		{
			dbParameter.Size = nSize;
			return dbParameter;
		}

		public static DbParameter SetValue(this DbParameter dbParameter, object oValue)
		{
			dbParameter.Value = (oValue == null) ? DBNull.Value : oValue;
			return dbParameter;
		}
	}
}
