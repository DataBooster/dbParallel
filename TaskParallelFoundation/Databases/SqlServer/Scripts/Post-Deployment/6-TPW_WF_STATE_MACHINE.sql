﻿insert into TPW_WF_STATE_MACHINE (STATE_ID_OLD, EVENT_ID, STATE_ID_NEW, ACTIVITY, STATE_NAME_OLD, EVENT_NAME, STATE_NAME_NEW, DESCRIPTION_)
values (1, 1, 2, 'TPW_PJOB', 'CREATED', 'ADD_TASK', 'WAITING_FOR_START', '');

insert into TPW_WF_STATE_MACHINE (STATE_ID_OLD, EVENT_ID, STATE_ID_NEW, ACTIVITY, STATE_NAME_OLD, EVENT_NAME, STATE_NAME_NEW, DESCRIPTION_)
values (1, 3, 9, 'TPW_PJOB', 'CREATED', 'CANCEL', 'CANCELED', '');

insert into TPW_WF_STATE_MACHINE (STATE_ID_OLD, EVENT_ID, STATE_ID_NEW, ACTIVITY, STATE_NAME_OLD, EVENT_NAME, STATE_NAME_NEW, DESCRIPTION_)
values (1, 8, 10, 'TPW_PJOB', 'CREATED', 'EXPIRE', 'EXPIRED', '');

insert into TPW_WF_STATE_MACHINE (STATE_ID_OLD, EVENT_ID, STATE_ID_NEW, ACTIVITY, STATE_NAME_OLD, EVENT_NAME, STATE_NAME_NEW, DESCRIPTION_)
values (2, 1, 2, 'TPW_PJOB', 'WAITING_FOR_START', 'ADD_TASK', 'WAITING_FOR_START', '');

insert into TPW_WF_STATE_MACHINE (STATE_ID_OLD, EVENT_ID, STATE_ID_NEW, ACTIVITY, STATE_NAME_OLD, EVENT_NAME, STATE_NAME_NEW, DESCRIPTION_)
values (2, 2, 3, 'TPW_PJOB', 'WAITING_FOR_START', 'START', 'WAITING_TO_RUN', '');

insert into TPW_WF_STATE_MACHINE (STATE_ID_OLD, EVENT_ID, STATE_ID_NEW, ACTIVITY, STATE_NAME_OLD, EVENT_NAME, STATE_NAME_NEW, DESCRIPTION_)
values (2, 3, 9, 'TPW_PJOB', 'WAITING_FOR_START', 'CANCEL', 'CANCELED', '');

insert into TPW_WF_STATE_MACHINE (STATE_ID_OLD, EVENT_ID, STATE_ID_NEW, ACTIVITY, STATE_NAME_OLD, EVENT_NAME, STATE_NAME_NEW, DESCRIPTION_)
values (2, 8, 10, 'TPW_PJOB', 'WAITING_FOR_START', 'EXPIRE', 'EXPIRED', '');

insert into TPW_WF_STATE_MACHINE (STATE_ID_OLD, EVENT_ID, STATE_ID_NEW, ACTIVITY, STATE_NAME_OLD, EVENT_NAME, STATE_NAME_NEW, DESCRIPTION_)
values (3, 3, 9, 'TPW_PJOB', 'WAITING_TO_RUN', 'CANCEL', 'CANCELED', '');

insert into TPW_WF_STATE_MACHINE (STATE_ID_OLD, EVENT_ID, STATE_ID_NEW, ACTIVITY, STATE_NAME_OLD, EVENT_NAME, STATE_NAME_NEW, DESCRIPTION_)
values (3, 4, 4, 'TPW_PJOB', 'WAITING_TO_RUN', 'RUN', 'RUNNING', '');

insert into TPW_WF_STATE_MACHINE (STATE_ID_OLD, EVENT_ID, STATE_ID_NEW, ACTIVITY, STATE_NAME_OLD, EVENT_NAME, STATE_NAME_NEW, DESCRIPTION_)
values (3, 8, 10, 'TPW_PJOB', 'WAITING_TO_RUN', 'EXPIRE', 'EXPIRED', '');

insert into TPW_WF_STATE_MACHINE (STATE_ID_OLD, EVENT_ID, STATE_ID_NEW, ACTIVITY, STATE_NAME_OLD, EVENT_NAME, STATE_NAME_NEW, DESCRIPTION_)
values (4, 5, 6, 'TPW_PJOB', 'RUNNING', 'CALLBACK', 'WAITING_FOR_CALLBACK_COMPLETE', '');

insert into TPW_WF_STATE_MACHINE (STATE_ID_OLD, EVENT_ID, STATE_ID_NEW, ACTIVITY, STATE_NAME_OLD, EVENT_NAME, STATE_NAME_NEW, DESCRIPTION_)
values (4, 6, 8, 'TPW_PJOB', 'RUNNING', 'COMPLETE', 'RAN_TO_COMPLETION', '');

insert into TPW_WF_STATE_MACHINE (STATE_ID_OLD, EVENT_ID, STATE_ID_NEW, ACTIVITY, STATE_NAME_OLD, EVENT_NAME, STATE_NAME_NEW, DESCRIPTION_)
values (4, 7, 5, 'TPW_PJOB', 'RUNNING', 'FAULT', 'TASK_FAULTED', '');

insert into TPW_WF_STATE_MACHINE (STATE_ID_OLD, EVENT_ID, STATE_ID_NEW, ACTIVITY, STATE_NAME_OLD, EVENT_NAME, STATE_NAME_NEW, DESCRIPTION_)
values (4, 8, 10, 'TPW_PJOB', 'RUNNING', 'EXPIRE', 'EXPIRED', '');

insert into TPW_WF_STATE_MACHINE (STATE_ID_OLD, EVENT_ID, STATE_ID_NEW, ACTIVITY, STATE_NAME_OLD, EVENT_NAME, STATE_NAME_NEW, DESCRIPTION_)
values (5, 5, 5, 'TPW_PJOB', 'TASK_FAULTED', 'CALLBACK', 'TASK_FAULTED', '');

insert into TPW_WF_STATE_MACHINE (STATE_ID_OLD, EVENT_ID, STATE_ID_NEW, ACTIVITY, STATE_NAME_OLD, EVENT_NAME, STATE_NAME_NEW, DESCRIPTION_)
values (5, 6, 7, 'TPW_PJOB', 'TASK_FAULTED', 'COMPLETE', 'FAULTED_COMPLETION', '');

insert into TPW_WF_STATE_MACHINE (STATE_ID_OLD, EVENT_ID, STATE_ID_NEW, ACTIVITY, STATE_NAME_OLD, EVENT_NAME, STATE_NAME_NEW, DESCRIPTION_)
values (5, 7, 5, 'TPW_PJOB', 'TASK_FAULTED', 'FAULT', 'TASK_FAULTED', '');

insert into TPW_WF_STATE_MACHINE (STATE_ID_OLD, EVENT_ID, STATE_ID_NEW, ACTIVITY, STATE_NAME_OLD, EVENT_NAME, STATE_NAME_NEW, DESCRIPTION_)
values (5, 8, 10, 'TPW_PJOB', 'TASK_FAULTED', 'EXPIRE', 'EXPIRED', '');

insert into TPW_WF_STATE_MACHINE (STATE_ID_OLD, EVENT_ID, STATE_ID_NEW, ACTIVITY, STATE_NAME_OLD, EVENT_NAME, STATE_NAME_NEW, DESCRIPTION_)
values (6, 6, 8, 'TPW_PJOB', 'WAITING_FOR_CALLBACK_COMPLETE', 'COMPLETE', 'RAN_TO_COMPLETION', '');

insert into TPW_WF_STATE_MACHINE (STATE_ID_OLD, EVENT_ID, STATE_ID_NEW, ACTIVITY, STATE_NAME_OLD, EVENT_NAME, STATE_NAME_NEW, DESCRIPTION_)
values (6, 7, 7, 'TPW_PJOB', 'WAITING_FOR_CALLBACK_COMPLETE', 'FAULT', 'FAULTED_COMPLETION', '');

insert into TPW_WF_STATE_MACHINE (STATE_ID_OLD, EVENT_ID, STATE_ID_NEW, ACTIVITY, STATE_NAME_OLD, EVENT_NAME, STATE_NAME_NEW, DESCRIPTION_)
values (6, 8, 10, 'TPW_PJOB', 'WAITING_FOR_CALLBACK_COMPLETE', 'EXPIRE', 'EXPIRED', '');

insert into TPW_WF_STATE_MACHINE (STATE_ID_OLD, EVENT_ID, STATE_ID_NEW, ACTIVITY, STATE_NAME_OLD, EVENT_NAME, STATE_NAME_NEW, DESCRIPTION_)
values (7, 9, 11, 'TPW_PJOB', 'FAULTED_COMPLETION', 'ARCHIVE', 'ARCHIVED', '');

insert into TPW_WF_STATE_MACHINE (STATE_ID_OLD, EVENT_ID, STATE_ID_NEW, ACTIVITY, STATE_NAME_OLD, EVENT_NAME, STATE_NAME_NEW, DESCRIPTION_)
values (8, 9, 11, 'TPW_PJOB', 'RAN_TO_COMPLETION', 'ARCHIVE', 'ARCHIVED', '');

insert into TPW_WF_STATE_MACHINE (STATE_ID_OLD, EVENT_ID, STATE_ID_NEW, ACTIVITY, STATE_NAME_OLD, EVENT_NAME, STATE_NAME_NEW, DESCRIPTION_)
values (9, 9, 11, 'TPW_PJOB', 'CANCELED', 'ARCHIVE', 'ARCHIVED', '');

insert into TPW_WF_STATE_MACHINE (STATE_ID_OLD, EVENT_ID, STATE_ID_NEW, ACTIVITY, STATE_NAME_OLD, EVENT_NAME, STATE_NAME_NEW, DESCRIPTION_)
values (10, 9, 11, 'TPW_PJOB', 'EXPIRED', 'ARCHIVE', 'ARCHIVED', '');
