using System;

namespace TaskParallelWorkflow.Dispatcher.Models
{
	internal struct DbAppSettings
	{
		public readonly int PrimaryInterval;
		public readonly int StandbyInterval;
		public readonly int DegreeOfTaskParallelism;
		public readonly int MaxThreadsInPool;

		public DbAppSettings(int nPrimaryInterval, int nStandbyInterval, int nDegreeOfTaskParallelism, int nMaxThreadsInPool)
		{
			PrimaryInterval = Math.Max(nPrimaryInterval, 50);
			StandbyInterval = Math.Max(nStandbyInterval, 10000);
			DegreeOfTaskParallelism = nDegreeOfTaskParallelism;
			MaxThreadsInPool = nMaxThreadsInPool;
		}
	}
}
