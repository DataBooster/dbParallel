using System;
using System.Collections.Generic;
using System.Reflection;
using System.Data.Common;
using System.Linq.Expressions;

namespace DbParallel.DataAccess
{
	public class DbFieldMap
	{
		class PropertyOrField
		{
			public string ColumnName { get; set; }
			public int ColumnOrdinal { get; set; }
			private PropertyInfo _PropertyInfo;
			private FieldInfo _FieldInfo;
			private Type _ValueType;

			public MemberInfo MemberInfo
			{
				get
				{
					if (_PropertyInfo != null)
						return _PropertyInfo;
					else
						return _FieldInfo;
				}
				set
				{
					_PropertyInfo = value as PropertyInfo;

					if (_PropertyInfo != null)
						_ValueType = _PropertyInfo.PropertyType;
					else
					{
						_FieldInfo = value as FieldInfo;

						if (_FieldInfo != null)
							_ValueType = _FieldInfo.FieldType;
					}

					if (_ValueType.IsNullable())
						_ValueType = Nullable.GetUnderlyingType(_ValueType);
				}
			}

			public void SetValue(object objEntity, object dbValue)
			{
				if (Convert.IsDBNull(dbValue))
					return;

				if (_PropertyInfo != null)
					_PropertyInfo.SetValue(objEntity, Convert.ChangeType(dbValue, _ValueType), null);
				else if (_FieldInfo != null)
					_FieldInfo.SetValue(objEntity, Convert.ChangeType(dbValue, _ValueType));
			}
		}

		private List<PropertyOrField> _FieldList;
		private ulong _RowCount;

		public DbFieldMap()
		{
			_FieldList = new List<PropertyOrField>();
			_RowCount = 0;
		}

		private void MapColumns(DbDataReader dataReader)
		{
			PropertyOrField field;

			for (int i = _FieldList.Count - 1; i >= 0; i--)
			{
				field = _FieldList[i];

				try
				{
					field.ColumnOrdinal = dataReader.GetOrdinal(field.ColumnName);
				}
				catch (IndexOutOfRangeException)
				{
					_FieldList.RemoveAt(i);
				}
			}
		}

		public DbFieldMap Add<T>(string columnName, Expression<Func<T, object>> fieldExpr)
		{
			MemberExpression memberExpression = fieldExpr.Body as MemberExpression;

			if (memberExpression == null)
			{
				UnaryExpression unaryExpression = fieldExpr.Body as UnaryExpression;

				if (unaryExpression != null)
					memberExpression = unaryExpression.Operand as MemberExpression;
			}

			if (memberExpression == null)
				throw new ApplicationException("Expression must be a Property or a Field.");

			_FieldList.Add(new PropertyOrField() { ColumnName = columnName, MemberInfo = memberExpression.Member });

			return this;
		}

		internal T Read<T>(DbDataReader dataReader) where T : new()
		{
			T entity = new T();

			if (_RowCount == 0)
				MapColumns(dataReader);

			foreach (PropertyOrField field in _FieldList)
				field.SetValue(entity, dataReader[field.ColumnOrdinal]);

			_RowCount++;
			return entity;
		}
	}
}
