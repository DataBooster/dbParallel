using System;
using System.Threading;
using DbParallel.Dispatcher;

namespace DbParallel.ConsoleTest
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
