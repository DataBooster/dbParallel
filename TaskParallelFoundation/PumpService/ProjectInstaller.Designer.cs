namespace DbParallel.PumpService
{
	partial class ProjectInstaller
	{
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.IContainer components = null;

		/// <summary> 
		/// Clean up any resources being used.
		/// </summary>
		/// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
		protected override void Dispose(bool disposing)
		{
			if (disposing && (components != null))
			{
				components.Dispose();
			}
			base.Dispose(disposing);
		}

		#region Component Designer generated code

		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.pumpServiceProcessInstaller = new System.ServiceProcess.ServiceProcessInstaller();
			this.pumpServiceInstaller = new System.ServiceProcess.ServiceInstaller();
			// 
			// pumpServiceProcessInstaller
			// 
			this.pumpServiceProcessInstaller.Password = null;
			this.pumpServiceProcessInstaller.Username = null;
			// 
			// pumpServiceInstaller
			// 
			this.pumpServiceInstaller.Description = "Database Task Parallel Foundation for Oracle";
			this.pumpServiceInstaller.DisplayName = "dbParallel Pump Service";
			this.pumpServiceInstaller.ServiceName = "dbParallel.PumpService";
			this.pumpServiceInstaller.StartType = System.ServiceProcess.ServiceStartMode.Automatic;
			// 
			// ProjectInstaller
			// 
			this.Installers.AddRange(new System.Configuration.Install.Installer[] {
            this.pumpServiceProcessInstaller,
            this.pumpServiceInstaller});

		}

		#endregion

		private System.ServiceProcess.ServiceProcessInstaller pumpServiceProcessInstaller;
		private System.ServiceProcess.ServiceInstaller pumpServiceInstaller;
	}
}