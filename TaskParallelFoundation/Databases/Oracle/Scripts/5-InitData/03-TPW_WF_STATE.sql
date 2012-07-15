insert into TPW_WF_STATE (STATE_ID, ACTIVITY, STATE_NAME, IS_DONE, DESCRIPTION_)
values (1, 'TPW_PJOB', 'CREATED', 0, 'The PJob has been initialized but has not yet been scheduled.');

insert into TPW_WF_STATE (STATE_ID, ACTIVITY, STATE_NAME, IS_DONE, DESCRIPTION_)
values (2, 'TPW_PJOB', 'WAITING_FOR_START', 0, 'The PJob is waiting to be started (activated and scheduled) internally by adding tasks.');

insert into TPW_WF_STATE (STATE_ID, ACTIVITY, STATE_NAME, IS_DONE, DESCRIPTION_)
values (3, 'TPW_PJOB', 'WAITING_TO_RUN', 0, 'The PJob has been scheduled for execution but has not yet begun executing.');

insert into TPW_WF_STATE (STATE_ID, ACTIVITY, STATE_NAME, IS_DONE, DESCRIPTION_)
values (4, 'TPW_PJOB', 'RUNNING', 0, 'The PJob is running but has not yet completed.');

insert into TPW_WF_STATE (STATE_ID, ACTIVITY, STATE_NAME, IS_DONE, DESCRIPTION_)
values (5, 'TPW_PJOB', 'TASK_FAULTED', 0, 'Any task(s) of the PJob faulted before callback.');

insert into TPW_WF_STATE (STATE_ID, ACTIVITY, STATE_NAME, IS_DONE, DESCRIPTION_)
values (6, 'TPW_PJOB', 'WAITING_FOR_CALLBACK_COMPLETE', 0, 'All tasks of the PJob has finished executing and is implicitly waiting for attached sucess-callback task to complete.');

insert into TPW_WF_STATE (STATE_ID, ACTIVITY, STATE_NAME, IS_DONE, DESCRIPTION_)
values (7, 'TPW_PJOB', 'FAULTED_COMPLETION', 1, 'The PJob completed with an unhandled exception.');

insert into TPW_WF_STATE (STATE_ID, ACTIVITY, STATE_NAME, IS_DONE, DESCRIPTION_)
values (8, 'TPW_PJOB', 'RAN_TO_COMPLETION', 1, 'The PJob completed execution (include callback task) successfully.');

insert into TPW_WF_STATE (STATE_ID, ACTIVITY, STATE_NAME, IS_DONE, DESCRIPTION_)
values (9, 'TPW_PJOB', 'CANCELED', 1, 'The PJob has been canceled before the PJob started executing.');

insert into TPW_WF_STATE (STATE_ID, ACTIVITY, STATE_NAME, IS_DONE, DESCRIPTION_)
values (10, 'TPW_PJOB', 'EXPIRED', 1, 'The PJob expired (be inactive too long).');

insert into TPW_WF_STATE (STATE_ID, ACTIVITY, STATE_NAME, IS_DONE, DESCRIPTION_)
values (11, 'TPW_PJOB', 'ARCHIVED', 1, 'The PJob life cycle has been ended.');
