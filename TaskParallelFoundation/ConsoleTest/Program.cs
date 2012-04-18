using System;
using System.Threading;
using TaskParallelWorkflow.Dispatcher;

namespace TaskParallelWorkflow.ConsoleTest
{
	class Program
	{
		static void Main(string[] args)
		{
			PumpMain pump = new PumpMain();

			pump.Start();

			Thread.Sleep(1000 * 60 * 10);

			pump.Stop();
		}
	}
}
