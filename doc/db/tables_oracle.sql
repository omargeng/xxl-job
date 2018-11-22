CREATE TABLE OMAR_QRTZ_JOB_DETAILS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    JOB_NAME  VARCHAR(200) NOT NULL,
    JOB_GROUP VARCHAR(200) NOT NULL,
    DESCRIPTION VARCHAR(250) NULL,
    JOB_CLASS_NAME   VARCHAR(250) NOT NULL,
    IS_DURABLE VARCHAR(1) NOT NULL,
    IS_NONCONCURRENT VARCHAR(1) NOT NULL,
    IS_UPDATE_DATA VARCHAR(1) NOT NULL,
    REQUESTS_RECOVERY VARCHAR(1) NOT NULL,
    JOB_DATA BLOB NULL,
    PRIMARY KEY (SCHED_NAME,JOB_NAME,JOB_GROUP)
);
-- add  comments
comment on table OMAR_QRTZ_JOB_DETAILS
is '工作联系方式表';
comment on column OMAR_QRTZ_JOB_DETAILS.SCHED_NAME
is 'Quartz实例名';
comment on column OMAR_QRTZ_JOB_DETAILS.JOB_NAME
is '工作名称';
comment on column OMAR_QRTZ_JOB_DETAILS.JOB_GROUP
is '工作组';
comment on column OMAR_QRTZ_JOB_DETAILS.DESCRIPTION
is '说明';
comment on column OMAR_QRTZ_JOB_DETAILS.JOB_CLASS_NAME
is '工作类名';
comment on column OMAR_QRTZ_JOB_DETAILS.REQUESTS_RECOVERY
is '请求恢复';
comment on column OMAR_QRTZ_JOB_DETAILS.JOB_DATA
is '工作记录';
comment on column OMAR_QRTZ_JOB_DETAILS.IS_DURABLE
is '是否持久化，0不持久化，1持久化';
-- comment on column T_qrtz_job_details.is_stateful
--is '是否有状态';
comment on column OMAR_QRTZ_JOB_DETAILS.IS_NONCONCURRENT
is ' 并发JOB@DisallowConcurrentExecution';
comment on column OMAR_QRTZ_JOB_DETAILS.IS_UPDATE_DATA
is ' 持久jobDataMap@PersistJobDataAfterExecution';

--表2
CREATE TABLE OMAR_QRTZ_TRIGGERS
(
SCHED_NAME VARCHAR(120) NOT NULL,
TRIGGER_NAME VARCHAR(200) NOT NULL,
TRIGGER_GROUP VARCHAR(200) NOT NULL,
JOB_NAME  VARCHAR(200) NOT NULL,
JOB_GROUP VARCHAR(200) NOT NULL,
DESCRIPTION VARCHAR(250) NULL,
NEXT_FIRE_TIME NUMBER(13) NULL,
PREV_FIRE_TIME NUMBER(13) NULL,
PRIORITY INTEGER NULL,
TRIGGER_STATE VARCHAR(16) NOT NULL,
TRIGGER_TYPE VARCHAR(8) NOT NULL,
START_TIME NUMBER(13) NOT NULL,
END_TIME NUMBER(13) NULL,
CALENDAR_NAME VARCHAR(200) NULL,
MISFIRE_INSTR NUMBER(5,0) NULL,
JOB_DATA BLOB NULL,
PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
FOREIGN KEY (SCHED_NAME,JOB_NAME,JOB_GROUP)
REFERENCES OMAR_QRTZ_JOB_DETAILS(SCHED_NAME,JOB_NAME,JOB_GROUP)
);
-- add  comments
comment on table OMAR_QRTZ_TRIGGERS
is '触发表';
comment on column OMAR_QRTZ_TRIGGERS.SCHED_NAME
is 'Quartz实例名';
comment on column OMAR_QRTZ_TRIGGERS.TRIGGER_GROUP
is '触发组';
comment on column OMAR_QRTZ_TRIGGERS.job_name
is '任务名称';
comment on column OMAR_QRTZ_TRIGGERS.job_group
is '任务组';
comment on column OMAR_QRTZ_TRIGGERS.description
is '任务描述';
comment on column OMAR_QRTZ_TRIGGERS.trigger_state
is '任务状态';
comment on column OMAR_QRTZ_TRIGGERS.trigger_type
is '触发类型CRON表达式';
comment on column OMAR_QRTZ_TRIGGERS.priority
is '优先级';
comment on column OMAR_QRTZ_TRIGGERS.prev_fire_time
is '上次执行时间';
comment on column OMAR_QRTZ_TRIGGERS.next_fire_time
is '下次执行时间';
comment on column OMAR_QRTZ_TRIGGERS.start_time
is '开始时间';
--表3
CREATE TABLE OMAR_QRTZ_SIMPLE_TRIGGERS
(
SCHED_NAME VARCHAR(120) NOT NULL,
TRIGGER_NAME VARCHAR(200) NOT NULL,
TRIGGER_GROUP VARCHAR(200) NOT NULL,
REPEAT_COUNT NUMBER(7) NOT NULL,
REPEAT_INTERVAL NUMBER(12) NOT NULL,
TIMES_TRIGGERED NUMBER(10) NOT NULL,
PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
REFERENCES OMAR_QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
);

comment on table OMAR_QRTZ_SIMPLE_TRIGGERS
is 'simple触发表';
comment on column OMAR_QRTZ_SIMPLE_TRIGGERS.SCHED_NAME
is 'Quartz实例名';
comment on column OMAR_QRTZ_SIMPLE_TRIGGERS.trigger_name
is '触发器名称';
comment on column OMAR_QRTZ_SIMPLE_TRIGGERS.TRIGGER_GROUP
is '触发器组';
comment on column OMAR_QRTZ_SIMPLE_TRIGGERS.REPEAT_COUNT
is '重复执行次数';
comment on column OMAR_QRTZ_SIMPLE_TRIGGERS.REPEAT_INTERVAL
is '执行时间间隔';
comment on column OMAR_QRTZ_SIMPLE_TRIGGERS.TIMES_TRIGGERED
is '作业运行的次数';
--表4
CREATE TABLE OMAR_QRTZ_CRON_TRIGGERS
(
SCHED_NAME VARCHAR(120) NOT NULL,
TRIGGER_NAME VARCHAR(200) NOT NULL,
TRIGGER_GROUP VARCHAR(200) NOT NULL,
CRON_EXPRESSION VARCHAR(200) NOT NULL,
TIME_ZONE_ID VARCHAR(80),
PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
REFERENCES OMAR_QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
);
comment on table OMAR_QRTZ_CRON_TRIGGERS
is '触发器执行计划表';
comment on column OMAR_QRTZ_CRON_TRIGGERS.SCHED_NAME
is 'Quartz实例名';
comment on column OMAR_QRTZ_CRON_TRIGGERS.trigger_name
is '触发器名称';
comment on column OMAR_QRTZ_CRON_TRIGGERS.TRIGGER_GROUP
is '触发器组';
comment on column OMAR_QRTZ_CRON_TRIGGERS.CRON_EXPRESSION
is '执行计划表达式';
comment on column OMAR_QRTZ_CRON_TRIGGERS.TIME_ZONE_ID
is '时区';
--表5
CREATE TABLE OMAR_QRTZ_SIMPROP_TRIGGERS
(
SCHED_NAME VARCHAR(120) NOT NULL,
TRIGGER_NAME VARCHAR(200) NOT NULL,
TRIGGER_GROUP VARCHAR(200) NOT NULL,
STR_PROP_1 VARCHAR(512) NULL,
STR_PROP_2 VARCHAR(512) NULL,
STR_PROP_3 VARCHAR(512) NULL,
INT_PROP_1 INT NULL,
INT_PROP_2 INT NULL,
LONG_PROP_1 NUMBER NULL,
LONG_PROP_2 NUMBER NULL,
DEC_PROP_1 NUMERIC(13,4) NULL,
DEC_PROP_2 NUMERIC(13,4) NULL,
BOOL_PROP_1 VARCHAR(1) NULL,
BOOL_PROP_2 VARCHAR(1) NULL,
PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
REFERENCES OMAR_QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
);
--表6
CREATE TABLE OMAR_QRTZ_BLOB_TRIGGERS
(
SCHED_NAME VARCHAR(120) NOT NULL,
TRIGGER_NAME VARCHAR(200) NOT NULL,
TRIGGER_GROUP VARCHAR(200) NOT NULL,
BLOB_DATA BLOB NULL,
PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
REFERENCES OMAR_QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
);
comment on table OMAR_QRTZ_BLOB_TRIGGERS
is '触发器记录表';
comment on column OMAR_QRTZ_BLOB_TRIGGERS.SCHED_NAME
is 'Quartz实例名';
comment on column OMAR_QRTZ_BLOB_TRIGGERS.trigger_name
is '触发器名称';
comment on column OMAR_QRTZ_BLOB_TRIGGERS.TRIGGER_GROUP
is '触发器组';
comment on column OMAR_QRTZ_BLOB_TRIGGERS.BLOB_DATA
is '触发内容';
--表7
CREATE TABLE OMAR_QRTZ_CALENDARS
(
SCHED_NAME VARCHAR(120) NOT NULL,
CALENDAR_NAME  VARCHAR(200) NOT NULL,
CALENDAR BLOB NOT NULL,
PRIMARY KEY (SCHED_NAME,CALENDAR_NAME)
);
comment on table OMAR_QRTZ_CALENDARS
is '触发日历表';
comment on column OMAR_QRTZ_CALENDARS.SCHED_NAME
is 'Quartz实例名';
comment on column OMAR_QRTZ_CALENDARS.CALENDAR_NAME
is '日历名称';
comment on column OMAR_QRTZ_CALENDARS.CALENDAR
is '日历内容';
--表8OMAR_QRTZ_PAUSED_TRIGGER_GRPS
CREATE TABLE OMAR_QRTZ_PAUSED_TRIGGER_GRPS
(
SCHED_NAME VARCHAR(120) NOT NULL,
TRIGGER_GROUP  VARCHAR(200) NOT NULL,
PRIMARY KEY (SCHED_NAME,TRIGGER_GROUP)
);
comment on table OMAR_QRTZ_PAUSED_TRIGGER_GRPS
is '暂停的触发主表';
comment on column OMAR_QRTZ_PAUSED_TRIGGER_GRPS.SCHED_NAME
is 'Quartz实例名';
comment on column OMAR_QRTZ_PAUSED_TRIGGER_GRPS.TRIGGER_GROUP
is '触发器组';
--表9
CREATE TABLE OMAR_QRTZ_FIRED_TRIGGERS
(
SCHED_NAME VARCHAR(120) NOT NULL,
ENTRY_ID VARCHAR(95) NOT NULL,
TRIGGER_NAME VARCHAR(200) NOT NULL,
TRIGGER_GROUP VARCHAR(200) NOT NULL,
INSTANCE_NAME VARCHAR(200) NOT NULL,
FIRED_TIME NUMBER(13) NOT NULL,
SCHED_TIME NUMBER(13) NOT NULL,
PRIORITY INTEGER NOT NULL,
STATE VARCHAR(16) NOT NULL,
JOB_NAME VARCHAR(200) NULL,
JOB_GROUP VARCHAR(200) NULL,
IS_NONCONCURRENT VARCHAR(1) NULL,
REQUESTS_RECOVERY VARCHAR(1) NULL,
PRIMARY KEY (SCHED_NAME,ENTRY_ID)
);
comment on table OMAR_QRTZ_FIRED_TRIGGERS
is '在执行触发表';
comment on column OMAR_QRTZ_FIRED_TRIGGERS.SCHED_NAME
is 'Quartz实例名';
comment on column OMAR_QRTZ_FIRED_TRIGGERS.ENTRY_ID
is '执行ID';
comment on column OMAR_QRTZ_FIRED_TRIGGERS.trigger_name
is '触发器名称';
comment on column OMAR_QRTZ_FIRED_TRIGGERS.TRIGGER_GROUP
is '触发器组';
comment on column OMAR_QRTZ_FIRED_TRIGGERS.INSTANCE_NAME
is '列名';
comment on column OMAR_QRTZ_FIRED_TRIGGERS.FIRED_TIME
is '触发时间';
comment on column OMAR_QRTZ_FIRED_TRIGGERS.STATE
is '执行状态';
comment on column OMAR_QRTZ_FIRED_TRIGGERS.JOB_NAME
is '工作名';
comment on column OMAR_QRTZ_FIRED_TRIGGERS.JOB_GROUP
is '工作组';
comment on column OMAR_QRTZ_FIRED_TRIGGERS.REQUESTS_RECOVERY
is '请求恢复';
comment on column OMAR_QRTZ_FIRED_TRIGGERS.PRIORITY
is '权重';
--表10
CREATE TABLE OMAR_QRTZ_SCHEDULER_STATE
(
SCHED_NAME VARCHAR(120) NOT NULL,
INSTANCE_NAME VARCHAR(200) NOT NULL,
LAST_CHECKIN_TIME NUMBER(13) NOT NULL,
CHECKIN_INTERVAL NUMBER(13) NOT NULL,
PRIMARY KEY (SCHED_NAME,INSTANCE_NAME)
);

comment on table OMAR_QRTZ_SCHEDULER_STATE
is '调度状态表';
comment on column OMAR_QRTZ_SCHEDULER_STATE.SCHED_NAME
is 'Quartz实例名';
comment on column OMAR_QRTZ_SCHEDULER_STATE.INSTANCE_NAME
is '列名';
comment on column OMAR_QRTZ_SCHEDULER_STATE.LAST_CHECKIN_TIME
is '最后调度检查时间';
comment on column OMAR_QRTZ_SCHEDULER_STATE.CHECKIN_INTERVAL
is '调度检查间隔';
--表11
CREATE TABLE OMAR_QRTZ_LOCKS
(
SCHED_NAME VARCHAR(120) NOT NULL,
LOCK_NAME  VARCHAR(40) NOT NULL,
PRIMARY KEY (SCHED_NAME,LOCK_NAME)
);
comment on table OMAR_QRTZ_LOCKS
is '执行计划锁表';
comment on column OMAR_QRTZ_LOCKS.SCHED_NAME
is 'Quartz实例名';
comment on column OMAR_QRTZ_LOCKS.LOCK_NAME
is '锁名称';
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

--create  sequence seq_atable minvalue 1 maxvalue 9999999 start with 1 increment by 1 nocache;
--表12
create table OMAR_QRTZ_TRIGGER_INFO
(
id                        NUMBER(11) not null,
job_group                 NUMBER(11) not null,
job_cron                  VARCHAR2(128) not null,
job_desc                  VARCHAR2(255) not null,
add_time                  DATE,
update_time               DATE,
author                    VARCHAR2(64),
alarm_email               VARCHAR2(255),
executor_route_strategy   VARCHAR2(50),
executor_handler          VARCHAR2(255),
executor_param            VARCHAR2(512),
executor_block_strategy   VARCHAR2(50),
executor_timeout          NUMBER(11) default 0,
glue_type                 VARCHAR2(50) not null,
glue_source               CLOB,
glue_remark               VARCHAR2(128),
glue_updatetime           DATE,
child_jobid               VARCHAR2(255),
executor_fail_retry_count NUMBER(11) default 0
);



create sequence SEQ_T_QRTZ_TRIGGER_INFO
minvalue 1
maxvalue 99999999
start with 1000000
increment by 1
cache 20
cycle;

comment on table OMAR_QRTZ_TRIGGER_INFO
is '调度扩展信息表';
-- Add comments to the columns
comment on column OMAR_QRTZ_TRIGGER_INFO.id
is '执行器主键ID';
comment on column OMAR_QRTZ_TRIGGER_INFO.job_group
is '工作组';
comment on column OMAR_QRTZ_TRIGGER_INFO.job_cron
is '任务执行CRON';
comment on column OMAR_QRTZ_TRIGGER_INFO.author
is '作者';
comment on column OMAR_QRTZ_TRIGGER_INFO.alarm_email
is '报警邮件';
comment on column OMAR_QRTZ_TRIGGER_INFO.executor_route_strategy
is '执行器路由策略';
comment on column OMAR_QRTZ_TRIGGER_INFO.executor_handler
is '执行器任务handler';
comment on column OMAR_QRTZ_TRIGGER_INFO.executor_param
is '执行器任务参数';
comment on column OMAR_QRTZ_TRIGGER_INFO.executor_block_strategy
is '阻塞处理策略';
comment on column OMAR_QRTZ_TRIGGER_INFO.executor_timeout
is '任务执行超时时间，单位秒';
comment on column OMAR_QRTZ_TRIGGER_INFO.glue_type
is 'GLUE类型';
comment on column OMAR_QRTZ_TRIGGER_INFO.glue_source
is 'GLUE源代码';
comment on column OMAR_QRTZ_TRIGGER_INFO.glue_remark
is 'GLUE备注';
comment on column OMAR_QRTZ_TRIGGER_INFO.glue_updatetime
is 'GLUE更新时间';
comment on column OMAR_QRTZ_TRIGGER_INFO.child_jobid
is '子任务ID，多个逗号分隔';
comment on column OMAR_QRTZ_TRIGGER_INFO.executor_fail_retry_count
is '失败重试次数';


--表13
create table OMAR_QRTZ_TRIGGER_LOG
(
id                        NUMBER(11) not null,
job_group                 NUMBER(11) not null,
job_id                    NUMBER(11) not null,
executor_address          VARCHAR2(255),
executor_handler          VARCHAR2(255),
executor_param            VARCHAR2(512),
trigger_time              DATE,
trigger_code              VARCHAR2(255) default '0',
trigger_msg               VARCHAR2(2048),
handle_time               DATE,
handle_code               VARCHAR2(255) default '0',
handle_msg                VARCHAR2(2048),
alarm_status              NUMBER(4) default 0,
executor_sharding_param   VARCHAR2(20),
executor_fail_retry_count NUMBER(11) default 0
);

create sequence SEQ_T_QRTZ_TRIGGER_LOG
minvalue 1
maxvalue 99999999
start with 1000000
increment by 1
cache 20
cycle;

-- Add comments to the table
comment on table OMAR_QRTZ_TRIGGER_LOG
is '调度日志表';
-- Add comments to the columns
comment on column OMAR_QRTZ_TRIGGER_LOG.id
is '执行器主键ID';
comment on column OMAR_QRTZ_TRIGGER_LOG.job_group
is '工作组';
comment on column OMAR_QRTZ_TRIGGER_LOG.job_id
is '任务，主键ID';
comment on column OMAR_QRTZ_TRIGGER_LOG.executor_address
is '执行器地址，本次执行的地址';
comment on column OMAR_QRTZ_TRIGGER_LOG.executor_handler
is '执行器任务handler';
comment on column OMAR_QRTZ_TRIGGER_LOG.executor_param
is '执行器任务参数';
comment on column OMAR_QRTZ_TRIGGER_LOG.trigger_time
is '调度-时间';
comment on column OMAR_QRTZ_TRIGGER_LOG.trigger_code
is '调度-结果';
comment on column OMAR_QRTZ_TRIGGER_LOG.trigger_msg
is '调度-日志';
comment on column OMAR_QRTZ_TRIGGER_LOG.handle_time
is '执行-时间';
comment on column OMAR_QRTZ_TRIGGER_LOG.handle_code
is '执行-状态';
comment on column OMAR_QRTZ_TRIGGER_LOG.handle_msg
is '执行-日志';
comment on column OMAR_QRTZ_TRIGGER_LOG.alarm_status
is '告警状态：0-默认、1-无需告警、2-告警成功、3-告警失败';
comment on column OMAR_QRTZ_TRIGGER_LOG.executor_sharding_param
is '执行器任务分片参数，格式如 1/2';
comment on column OMAR_QRTZ_TRIGGER_LOG.executor_fail_retry_count
is '失败重试次数';
--- OMAR_QRTZ_TRIGGER_INFO：调度扩展信息表： 用于保存XXL-JOB调度任务的扩展信息，如任务分组、任务名、机器地址、执行器、执行入参和报警邮件等等；
-- OMAR_QRTZ_TRIGGER_LOG：调度日志表： 用于保存XXL-JOB任务调度的历史信息，如调度结果、执行结果、调度入参、调度机器和执行器等等；
-- OMAR_QRTZ_TRIGGER_LOGGLUE：任务GLUE日志：用于保存GLUE更新历史，用于支持GLUE的版本回溯功能；
--表14
CREATE TABLE  OMAR_QRTZ_TRIGGER_LOGGLUE  (
id  NUMBER(11) NOT NULL ,
job_id  NUMBER(11) NOT NULL,
glue_type  varchar(50) DEFAULT NULL,
glue_source  clob,
glue_remark  varchar(128) NOT NULL,
add_time  timestamp  ,
update_time  timestamp  ,
PRIMARY KEY ( id )
);

create sequence SEQ_T_QRTZ_TRIGGER_LOGGLUE
minvalue 1
maxvalue 99999999
start with 1000000
increment by 1
cache 20
cycle;

comment on table OMAR_QRTZ_TRIGGER_LOGGLUE
is '任务GLUE日志支持GLUE的版本回溯功能';
comment on column OMAR_QRTZ_TRIGGER_LOGGLUE.id
is '执行器主键ID';
comment on column OMAR_QRTZ_TRIGGER_LOGGLUE.glue_type
is 'GLUE类型';
comment on column OMAR_QRTZ_TRIGGER_LOGGLUE.job_id
is '任务，主键ID';
comment on column OMAR_QRTZ_TRIGGER_LOGGLUE.glue_source
is 'GLUE源代码';
comment on column OMAR_QRTZ_TRIGGER_LOGGLUE.glue_remark
is 'GLUE备注';

--表15
CREATE TABLE OMAR_QRTZ_TRIGGER_REGISTRY (
id  NUMBER(11) NOT NULL ,
registry_group  varchar(255) NOT NULL,
registry_key  varchar(255) NOT NULL,
registry_value  varchar(255) NOT NULL,
update_time  date   DEFAULT sysdate,
PRIMARY KEY ( id )
);

create sequence SEQ_T_QRTZ_TRIGGER_REGISTRY
minvalue 1
maxvalue 99999999
start with 1000000
increment by 1
cache 20
cycle;
comment on table OMAR_QRTZ_TRIGGER_REGISTRY
is '执行器注册表';
comment on column OMAR_QRTZ_TRIGGER_REGISTRY.id
is '主键ID';
comment on column OMAR_QRTZ_TRIGGER_REGISTRY.registry_group
is '注册组';
comment on column OMAR_QRTZ_TRIGGER_REGISTRY.registry_key
is '注册key';
comment on column OMAR_QRTZ_TRIGGER_REGISTRY.registry_value
is '注册value';
comment on column OMAR_QRTZ_TRIGGER_REGISTRY.update_time
is '修改时间';
--表16
CREATE TABLE  OMAR_QRTZ_TRIGGER_GROUP  (
id  NUMBER(11) NOT NULL,
app_name  varchar(64) NOT NULL,
title  varchar2(22) NOT NULL,
orders  NUMBER(4) DEFAULT '0' ,
address_type  NUMBER(4) DEFAULT '0',
address_list  varchar(512) DEFAULT NULL,
PRIMARY KEY ( id )
);


create sequence SEQ_T_QRTZ_TRIGGER_GROUP
minvalue 1
maxvalue 99999999
start with 1000000
increment by 1
cache 20
cycle;

comment on table OMAR_QRTZ_TRIGGER_GROUP
is '执行器信息表，维护任务执行器信息';
comment on column OMAR_QRTZ_TRIGGER_GROUP.id
is '主键ID';
comment on column OMAR_QRTZ_TRIGGER_GROUP.app_name
is '执行器AppName';
comment on column OMAR_QRTZ_TRIGGER_GROUP.title
is '执行器名称';
comment on column OMAR_QRTZ_TRIGGER_GROUP.orders
is '排序';
comment on column OMAR_QRTZ_TRIGGER_GROUP.address_type
is '执行器地址类型：0=自动注册、1=手动录入';
comment on column OMAR_QRTZ_TRIGGER_GROUP.address_list
is '执行器地址列表，多地址逗号分隔';



INSERT INTO  OMAR_QRTZ_TRIGGER_GROUP  (id,  app_name ,  title ,  orders ,  address_type ,  address_list ) values ('1', 'xxl-job-executor-sample', '执行器', '1', '0', null);

INSERT INTO OMAR_QRTZ_TRIGGER_INFO
(id,
job_group,
job_cron,
job_desc,
add_time,
update_time,
author,
alarm_email,
executor_route_strategy,
executor_handler,
executor_param,
executor_block_strategy,
executor_timeout,
executor_fail_retry_count,
glue_type,
glue_source,
glue_remark,
glue_updatetime,
child_jobid)
VALUES
(1,
1,
'0 0 0 * * ? *',
'测试任务1',
systimestamp,
systimestamp,
'XXL',
'',
'FIRST',
'demoJobHandler',
'',
'SERIAL_EXECUTION',
0,
0,
'BEAN',
'',
'GLUE代码初始化',
systimestamp,
'');

commit;
