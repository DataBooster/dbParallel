using System;
using System.Threading;
using System.Threading.Tasks;
using DbParallel.Dispatcher;
using DbParallel.DataAccess;
using DbParallel.Dispatcher.Configs;

namespace DbParallel.ConsoleTest
{
	class Program
	{
		static void Main(string[] args)
		{
			int msTest = 10 * 60 * 1000;	// 10 minutes

			PumpMain pump = new PumpMain();

			pump.Start();

			Task.Factory.StartNew(() =>
				{
					DateTime dtStart = DateTime.Now;
					DateTime dtUntil = dtStart.AddMilliseconds(msTest);

					using (DbAccess db = new DbAccess(PumpConfig.DbProviderFactory, PumpConfig.ConnectionString))
					{
						do
						{
							Thread.Sleep(1000);

							db.ExecuteReader(PumpConfig.DatabasePackage + "RECENT_WK_LOG",
								param =>
								{
									param.Add("inLast_Time", dtStart);
								},
								rd =>
								{
									dtStart = rd.Field<DateTime>("LOG_TIME");
									Console.WriteLine("[{0:HH:mm:ss.fff}] PJob#{1:d} (Old State: {2}) <Event: {3}> (New State: {4}) Message: {5}",
										dtStart,
										rd.Field<int>("REFER_ID"),
										rd.Field<string>("OLD_STATE"),
										rd.Field<string>("EVENT_"),
										rd.Field<string>("NEW_STATE"),
										rd.Field<string>("MESSAGE_"));
								});
						} while (DateTime.Now < dtUntil);
					}
				});

			Thread.Sleep(msTest);

			pump.Stop();
		}
	}
}
