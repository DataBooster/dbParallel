insert into TPW_PUMP_CONFIG (ELEMENT_NAME, NUMBER_VALUE, DATE_VALUE, STRING_VALUE, DESCRIPTION_)
values ('ARCHIVE_INTERVAL', 1, null, '', 'Archive Interval (Minutes).');

insert into TPW_PUMP_CONFIG (ELEMENT_NAME, NUMBER_VALUE, DATE_VALUE, STRING_VALUE, DESCRIPTION_)
values ('DEGREE_OF_TASK_PARALLELISM', 16, null, '', 'Degree of Task Parallelism for each PJob.');

insert into TPW_PUMP_CONFIG (ELEMENT_NAME, NUMBER_VALUE, DATE_VALUE, STRING_VALUE, DESCRIPTION_)
values ('EXPIRE_INTERVAL', 1, null, '', 'Check Expire Interval (Hours).');

insert into TPW_PUMP_CONFIG (ELEMENT_NAME, NUMBER_VALUE, DATE_VALUE, STRING_VALUE, DESCRIPTION_)
values ('EXPIRY_DAY', 1, null, '', 'A PJob will be treated as invalid after the EXPIRY_DAY days.');

insert into TPW_PUMP_CONFIG (ELEMENT_NAME, NUMBER_VALUE, DATE_VALUE, STRING_VALUE, DESCRIPTION_)
values ('LAST_ARCHIVED', null, '2012-01-01', '', 'The last time when archived all ended PJobs.');

insert into TPW_PUMP_CONFIG (ELEMENT_NAME, NUMBER_VALUE, DATE_VALUE, STRING_VALUE, DESCRIPTION_)
values ('LAST_EXPIRED', null, '2012-01-01', '', 'The last time when expired all dead PJobs.');

insert into TPW_PUMP_CONFIG (ELEMENT_NAME, NUMBER_VALUE, DATE_VALUE, STRING_VALUE, DESCRIPTION_)
values ('MAX_THREADS_IN_POOL', 108, null, '', 'Max total threads in service threading pool.');

insert into TPW_PUMP_CONFIG (ELEMENT_NAME, NUMBER_VALUE, DATE_VALUE, STRING_VALUE, DESCRIPTION_)
values ('PJOB_ID_RECORD', 1, null, '', 'Parallel Job ID Generator.');

insert into TPW_PUMP_CONFIG (ELEMENT_NAME, NUMBER_VALUE, DATE_VALUE, STRING_VALUE, DESCRIPTION_)
values ('PRIMARY_BEAT', null, '2012-01-01', '', 'Heartbeat of Primary Pump Service.');

insert into TPW_PUMP_CONFIG (ELEMENT_NAME, NUMBER_VALUE, DATE_VALUE, STRING_VALUE, DESCRIPTION_)
values ('PRIMARY_INTERVAL', 200, null, '', 'The Primary Pump Interval (Milliseconds).');

insert into TPW_PUMP_CONFIG (ELEMENT_NAME, NUMBER_VALUE, DATE_VALUE, STRING_VALUE, DESCRIPTION_)
values ('STANDBY_BEAT', null, '2012-01-01', '', 'Heartbeat of Standby Pump Service.');

insert into TPW_PUMP_CONFIG (ELEMENT_NAME, NUMBER_VALUE, DATE_VALUE, STRING_VALUE, DESCRIPTION_)
values ('STANDBY_INTERVAL', 30, null, '', 'Standby Services Ping Interval (Seconds).');
