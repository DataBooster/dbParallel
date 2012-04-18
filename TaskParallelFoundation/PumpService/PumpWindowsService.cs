using System.ServiceProcess;
using TaskParallelWorkflow.Dispatcher;

namespace TaskParallelWorkflow.PumpService
{
	public partial class PumpWindowsService : ServiceBase
	{
		private PumpMain _PumpMain;

		public PumpWindowsService()
		{
			InitializeComponent();
		}

		static void Main()
		{
			ServiceBase.Run(new PumpWindowsService());
		}

		protected override void OnStart(string[] args)
		{
			_PumpMain = new PumpMain(this.EventLog);
			_PumpMain.Start();
		}

		protected override void OnStop()
		{
			_PumpMain.Stop();
			_PumpMain.Dispose();
		}

		protected override void OnShutdown()
		{
			OnStop();
		}
	}
}
