
namespace DbParallel.Dispatcher.DataAccess
{
	public static partial class ConfigHelper
	{
		static partial void OnInitializing()
		{
			_ConnectionSettingKey = "TPW_Database";
			_PackageSettingKey = "TPW_Package";
			_AuxConnectionSettingKey = string.Empty;
		}
	}
}
