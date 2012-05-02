using System.ServiceProcess;
using DbParallel.Dispatcher;

namespace DbParallel.PumpService
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

////////////////////////////////////////////////////////////////////////////////////////////////////
//
//	Copyright 2012 Abel Cheng
//	This source code is subject to terms and conditions of the Apache License, Version 2.0.
//	See http://www.apache.org/licenses/LICENSE-2.0.
//	All other rights reserved.
//	You must not remove this notice, or any other, from this software.
//
//	Original Author:	Abel Cheng <abelcys@gmail.com>
//	Created Date:		2012-03-23
//	Primary Host:		http://dbParallel.codeplex.com
//	Change Log:
//	Author				Date			Comment
//
//
//
//
//	(Keep clean code rather than complicated code plus long comments.)
//
////////////////////////////////////////////////////////////////////////////////////////////////////
