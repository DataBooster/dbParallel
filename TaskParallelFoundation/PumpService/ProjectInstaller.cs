using System.ComponentModel;
using System.ServiceProcess;

namespace DbParallel.PumpService
{
	[RunInstaller(true)]
	public partial class ProjectInstaller : System.Configuration.Install.Installer
	{
		public ProjectInstaller()
		{
			InitializeComponent();
		}

		private void pumpServiceInstaller_AfterInstall(object sender, System.Configuration.Install.InstallEventArgs e)
		{
		//	new ServiceController(pumpServiceInstaller.ServiceName).Start();
		}
	}
}
