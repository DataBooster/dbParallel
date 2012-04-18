insert into XYZ.TPW_WF_EVENT (EVENT_ID, ACTIVITY, EVENT_NAME, DESCRIPTION_)
values (1, 'TPW_PJOB', 'ADD_TASK', 'Add a parallel task.');

insert into XYZ.TPW_WF_EVENT (EVENT_ID, ACTIVITY, EVENT_NAME, DESCRIPTION_)
values (2, 'TPW_PJOB', 'START', 'Start a pjob.');

insert into XYZ.TPW_WF_EVENT (EVENT_ID, ACTIVITY, EVENT_NAME, DESCRIPTION_)
values (3, 'TPW_PJOB', 'CANCEL', 'Try to cancel a pjob before executing.');

insert into XYZ.TPW_WF_EVENT (EVENT_ID, ACTIVITY, EVENT_NAME, DESCRIPTION_)
values (4, 'TPW_PJOB', 'RUN', 'Run a PJob.');

insert into XYZ.TPW_WF_EVENT (EVENT_ID, ACTIVITY, EVENT_NAME, DESCRIPTION_)
values (5, 'TPW_PJOB', 'CALLBACK', 'Callback task (either sucess-callback or fail-callback)');

insert into XYZ.TPW_WF_EVENT (EVENT_ID, ACTIVITY, EVENT_NAME, DESCRIPTION_)
values (6, 'TPW_PJOB', 'COMPLETE', 'Complete all tasks include callback task.');

insert into XYZ.TPW_WF_EVENT (EVENT_ID, ACTIVITY, EVENT_NAME, DESCRIPTION_)
values (7, 'TPW_PJOB', 'FAULT', 'Handle exception.');

insert into XYZ.TPW_WF_EVENT (EVENT_ID, ACTIVITY, EVENT_NAME, DESCRIPTION_)
values (8, 'TPW_PJOB', 'EXPIRE', 'Expire a PJob.');

insert into XYZ.TPW_WF_EVENT (EVENT_ID, ACTIVITY, EVENT_NAME, DESCRIPTION_)
values (9, 'TPW_PJOB', 'ARCHIVE', 'Archive the whole PJob.');

commit;
