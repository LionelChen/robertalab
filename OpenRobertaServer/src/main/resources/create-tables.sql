create table USER (
  ID INTEGER not null generated by default as identity (start with 1),
  ACCOUNT varchar(255) not null,
  PASSWORD  varchar(255) not null,
  USER_NAME varchar(255),
  EMAIL varchar(255),
  ROLE varchar(32) not null,
  CREATED timestamp not null,
  LAST_LOGIN timestamp not null,
  TAGS varchar(16M), -- e.g. HERDER-GYMNASIUM KÖLN Q1 ED_SHEERAN
  
  primary key (ID)
);

create unique index accountIdx on USER(ACCOUNT);

create table LOST_PASSWORD (
	ID INTEGER not null generated by default as identity (start with 1),
	USER_ID INTEGER not null,
	URL_POSTFIX varchar(255),
	CREATED timestamp not null,
	
	primary key (ID),
	foreign key (USER_ID) references USER(ID) ON DELETE CASCADE
);

create table ROBOT (
  ID INTEGER not null generated by default as identity (start with 42),
  NAME varchar(255) not null,
  CREATED timestamp not null,
  TAGS varchar(16M), 
  ICON_NUMBER integer not null,
  
  primary key (ID),
);

create unique index typeIdx on ROBOT(NAME);

create table PROGRAM (
  ID INTEGER not null generated by default as identity (start with 1),
  NAME varchar(255) not null,
  OWNER_ID INTEGER not null,
  ROBOT_ID INTEGER not null,
  PROGRAM_TEXT varchar(16M),
  CREATED timestamp not null,
  LAST_CHANGED timestamp not null,
  LAST_CHECKED timestamp,
  LAST_ERRORFREE timestamp,
  NUMBER_OF_BLOCKS INTEGER,
  TAGS varchar(16M), -- e.g. CAR AUTONOMOUS COOL 3WHEELS
  ICON_NUMBER integer not null,
  
  primary key (ID),
  foreign key (OWNER_ID) references USER(ID) ON DELETE CASCADE,
  foreign key (ROBOT_ID) references ROBOT(ID)
);

create unique index progNameOwnerRobotIdx on PROGRAM(NAME, OWNER_ID, ROBOT_ID);

create table USER_PROGRAM (
  ID INTEGER not null generated by default as identity (start with 42),
  USER_ID INTEGER not null,
  PROGRAM_ID INTEGER not null,
  RELATION varchar(32) not null, -- 1 READ access, 2 WRITE access, 4 DELETE right, (really? not yet used) 8 PROMOTE_READ right, 16 PROMOTE_WRITE right
 
  foreign key (USER_ID) references USER(ID) ON DELETE CASCADE,
  foreign key (PROGRAM_ID) references PROGRAM(ID) ON DELETE CASCADE
);

create table TOOLBOX (
  ID INTEGER not null generated by default as identity (start with 42),
  NAME varchar(255) not null,
  OWNER_ID INTEGER,
  ROBOT_ID INTEGER not null,
  TOOLBOX_TEXT varchar(16M),
  CREATED timestamp not null,
  LAST_CHANGED timestamp not null,
  LAST_CHECKED timestamp,
  LAST_ERRORFREE timestamp,
  TAGS varchar(16M), -- e.g. CAR AUTONOMOUS COOL 3WHEELS
  ICON_NUMBER integer not null,
  
  primary key (ID),
  foreign key (OWNER_ID) references USER(ID) ON DELETE CASCADE,
  foreign key (ROBOT_ID) references ROBOT(ID)
);

create unique index toolNameOwnerIdx on TOOLBOX(NAME, OWNER_ID, ROBOT_ID);

create table CONFIGURATION (
  ID INTEGER not null generated by default as identity (start with 42),
  NAME varchar(255) not null,
  OWNER_ID INTEGER,
  ROBOT_ID INTEGER not null,
  CONFIGURATION_TEXT varchar(16M),
  CREATED timestamp not null,
  LAST_CHANGED timestamp not null,
  LAST_CHECKED timestamp,
  LAST_ERRORFREE timestamp,
  TAGS varchar(16M), -- e.g. CAR AUTONOMOUS COOL 3WHEELS
  ICON_NUMBER integer not null,
  
  primary key (ID),
  foreign key (OWNER_ID) references USER(ID) ON DELETE CASCADE,
  foreign key (ROBOT_ID) references ROBOT(ID)
);

insert into ROBOT
( NAME, CREATED, TAGS, ICON_NUMBER )
values('ev3',
now,
 '', 0
 );
commit;

insert into ROBOT
( NAME, CREATED, TAGS, ICON_NUMBER )
values('oraSim',
now,
 '', 0
 );
commit;

insert into USER
(ACCOUNT, PASSWORD, EMAIL, ROLE, CREATED, LAST_LOGIN, TAGS)
values ('Roberta','d4ab787ab667fef4:a5bf6037bd904f05b76ee431ae285f443229e3a3','','TEACHER',now ,now ,''
);
commit;

insert into CONFIGURATION
( NAME, OWNER_ID, ROBOT_ID, CONFIGURATION_TEXT, CREATED, LAST_CHANGED, LAST_CHECKED, LAST_ERRORFREE, TAGS, ICON_NUMBER )
values ('ev3Brick',NULL,'42','<block_set xmlns=''http://de.fhg.iais.roberta.blockly''><instance x=''300'' y=''50''><block id=''1'' type=''robBrick_EV3-Brick''><field name="WHEEL_DIAMETER">5.6</field><field name="TRACK_WIDTH">18</field><value name=''S1''><block id=''2'' type=''robBrick_touch''/></value><value name=''S4''><block id=''3'' type=''robBrick_ultrasonic''/></value><value name=''MB''><block id=''4'' type=''robBrick_motor_big''><field name=''MOTOR_REGULATION''>TRUE</field><field name=''MOTOR_REVERSE''>OFF</field><field name=''MOTOR_DRIVE''>RIGHT</field></block></value><value name=''MC''><block id=''5'' type=''robBrick_motor_big''><field name=''MOTOR_REGULATION''>TRUE</field><field name=''MOTOR_REVERSE''>OFF</field><field name=''MOTOR_DRIVE''>LEFT</field></block></value></block></instance></block_set>',
now, now, now, now,
 '', 0
);
commit;

insert into TOOLBOX
( NAME, OWNER_ID, ROBOT_ID, TOOLBOX_TEXT, CREATED, LAST_CHANGED, LAST_CHECKED, LAST_ERRORFREE, TAGS, ICON_NUMBER )
values ('beginner',NULL,'43','<toolbox_set id="toolbox" style="display: none"><category name="TOOLBOX_ACTION"><block type="robActions_motorDiff_on_for"><value name="POWER"><block type="math_number"><field name="NUM">30</field></block></value><value name="DISTANCE"><block type="math_number"><field name="NUM">20</field></block></value></block><block type="robActions_motorDiff_on"><value name="POWER"><block type="math_number"><field name="NUM">30</field></block></value></block><block type="robActions_motorDiff_stop"> </block><block type="robActions_motorDiff_turn_for"><value name="POWER"><block type="math_number"><field name="NUM">30</field></block></value><value name="DEGREE"><block type="math_number"><field name="NUM">20</field></block></value></block><block type="robActions_motorDiff_turn"><value name="POWER"><block type="math_number"><field name="NUM">30</field></block></value></block><block type="sim_LED_on"/><block type="sim_LED_off"/></category><category name="TOOLBOX_SENSOR"><block type="robSensors_touch_isPressed"> </block><block type="sim_ultrasonic_getSample"><field name="SENSORPORT">4</field></block><block type="sim_colour_getSample"><field name="SENSORPORT">3</field></block></category><category name="TOOLBOX_CONTROL"><block type="robControls_if"/><block type="robControls_ifElse"/><block type="robControls_loopForever"/><block type="controls_repeat"> </block><block type="robControls_wait_time"><value name="WAIT"><block type="math_number"><field name="NUM">500</field></block></value></block><block type="robControls_wait_for"><value name="WAIT0"><block type="logic_compare"><value name="A"><block type="sim_getSample"> </block></value><value name="B"><block type="logic_boolean"> </block></value></block></value></block></category><category name="TOOLBOX_LOGIC"><block type="logic_compare"/><block type="logic_operation"/><block type="logic_boolean"/></category><category name="TOOLBOX_MATH"><block type="math_number"/><block type="math_arithmetic"/></category><category name="TOOLBOX_COLOUR"><block type="robColour_picker"><field name="COLOUR">#585858</field></block><block type="robColour_picker"><field name="COLOUR">#000000</field></block><block type="robColour_picker"><field name="COLOUR">#0057a6</field></block><block type="robColour_picker"><field name="COLOUR">#00642e</field></block><block type="robColour_picker"><field name="COLOUR">#f7d117</field></block><block type="robColour_picker"><field name="COLOUR">#b30006</field></block><block type="robColour_picker"><field name="COLOUR">#FFFFFF</field></block><block type="robColour_picker"><field name="COLOUR">#532115</field></block></category><category name="TOOLBOX_VARIABLE" custom="VARIABLE"/></toolbox_set>',
now, now, now, now,
 '', 0
 );
commit;

insert into TOOLBOX
( NAME, OWNER_ID, ROBOT_ID, TOOLBOX_TEXT, CREATED, LAST_CHANGED, LAST_CHECKED, LAST_ERRORFREE, TAGS, ICON_NUMBER )
values('beginner',NULL,'42','<toolbox_set id="toolbox" style="display: none"><category name="TOOLBOX_ACTION"><block type="robActions_motorDiff_on_for"><value name="POWER"><block type="math_number"><field name="NUM">30</field></block></value><value name="DISTANCE"><block type="math_number"><field name="NUM">20</field></block></value></block><block type="robActions_motorDiff_on"><value name="POWER"><block type="math_number"><field  name="NUM">30</field></block></value></block><block type="robActions_motorDiff_stop"/><block type="robActions_motorDiff_turn_for"><value name="POWER"><block type="math_number"><field name="NUM">30</field></block></value><value name="DEGREE"><block type="math_number"><field name="NUM">20</field></block></value></block><block type="robActions_motorDiff_turn"><value name="POWER"><block type="math_number"><field name="NUM">30</field></block></value></block><block type="robActions_display_text"><value name="OUT"><block type="text"><field name="TEXT">Hallo</field></block></value><value name="COL"><block type="math_number"><field name="NUM">0</field></block></value><value name="ROW"><block type="math_number"><field name="NUM">0</field></block></value></block><block type="robActions_display_clear"/><block type="robActions_play_tone"><value name="FREQUENCE"><block type="math_number"><field name="NUM">300</field></block></value><value name="DURATION"><block type="math_number"><field name="NUM">100</field></block></value></block><block type="robActions_play_setVolume"><value name="VOLUME"><block type="math_number"><field name="NUM">50</field></block></value></block><block type="robActions_brickLight_on"/><block type="robActions_brickLight_off"/><block type="robActions_brickLight_reset"/></category><category name="TOOLBOX_SENSOR"><block type="robSensors_touch_isPressed"/><block type="robSensors_ultrasonic_getSample"><field name="SENSORPORT">4</field></block><block type="robSensors_colour_getSample"><field name="SENSORPORT">3</field></block><block type="robSensors_infrared_getSample"><field name="SENSORPORT">4</field></block><block type="robSensors_encoder_reset"/><block type="robSensors_encoder_getSample"/><block type="robSensors_key_isPressed"/><block type="robSensors_gyro_reset"><field name="SENSORPORT">2</field></block><block type="robSensors_gyro_getSample"><field name="SENSORPORT">2</field></block><block type="robSensors_timer_getSample"/><block type="robSensors_timer_reset"/></category><category name="TOOLBOX_CONTROL"><block type="robControls_if"/><block type="robControls_ifElse"/><block type="robControls_loopForever"/><block type="controls_repeat"/><block type="robControls_wait_time"><value name="WAIT"><block type="math_number"><field name="NUM">500</field></block></value></block><block type="robControls_wait_for"><value name="WAIT0"><block type="logic_compare"><value name="A"><block type="robSensors_getSample"/></value><value name="B"><block type="logic_boolean"/></value></block></value></block></category><category name="TOOLBOX_LOGIC"><block type="logic_compare"/><block type="logic_operation"/><block type="logic_boolean"/></category><category name="TOOLBOX_MATH"><block type="math_number"/><block type="math_arithmetic"/></category><category name="TOOLBOX_TEXT"><block type="text"/></category><category name="TOOLBOX_COLOUR"><block type="robColour_picker"><field name="COLOUR">#585858</field></block><block type="robColour_picker"><field name="COLOUR">#000000</field></block><block type="robColour_picker"><field name="COLOUR">#0057a6</field></block><block type="robColour_picker"><field name="COLOUR">#00642e</field></block><block type="robColour_picker"><field name="COLOUR">#f7d117</field></block><block type="robColour_picker"><field name="COLOUR">#b30006</field></block><block type="robColour_picker"><field name="COLOUR">#FFFFFF</field></block><block type="robColour_picker"><field name="COLOUR">#532115</field></block></category><category name="TOOLBOX_VARIABLE" custom="VARIABLE"/></toolbox_set>',
now, now, now, now,
 '', 0
 );
commit;

insert into TOOLBOX
( NAME, OWNER_ID, ROBOT_ID, TOOLBOX_TEXT, CREATED, LAST_CHANGED, LAST_CHECKED, LAST_ERRORFREE, TAGS, ICON_NUMBER )
values('expert',NULL,'42','<toolbox_set id="toolbox" style="display: none"><category name="TOOLBOX_ACTION"><category name="TOOLBOX_MOVE"><block type="robActions_motor_on_for"><field name="MOTORPORT">B</field><value name="POWER"><block type="math_number"><field name="NUM">30</field></block></value><value name="VALUE"><block type="math_number"><field name="NUM">1</field></block></value></block><block type="robActions_motor_on"><field name="MOTORPORT">B</field><value name="POWER"><block type="math_number"><field name="NUM">30</field></block></value></block><block type="robActions_motor_getPower"><field name="MOTORPORT">B</field></block><block type="robActions_motor_setPower"><field name="MOTORPORT">B</field><value name="POWER"><block type="math_number"><field name="NUM">30</field></block></value></block><block type="robActions_motor_stop"><field name="MOTORPORT">A</field></block></category><category name="TOOLBOX_DRIVE"><block type="robActions_motorDiff_on"><value name="POWER"><block type="math_number"><field name="NUM">30</field></block></value></block><block type="robActions_motorDiff_on_for"><value name="POWER"><block type="math_number"><field name="NUM">30</field></block></value><value name="DISTANCE"><block type="math_number"><field name="NUM">20</field></block></value></block><block type="robActions_motorDiff_stop"/><block type="robActions_motorDiff_turn_for"><value name="POWER"><block type="math_number"><field name="NUM">30</field></block></value><value name="DEGREE"><block type="math_number"><field name="NUM">20</field></block></value></block><block type="robActions_motorDiff_turn"><value name="POWER"><block type="math_number"><field name="NUM">30</field></block></value></block></category><category name="TOOLBOX_DISPLAY"><block type="robActions_display_text"><value name="OUT"><block type="text"><field name="TEXT">Hallo</field></block></value><value name="COL"><block type="math_number"><field name="NUM">0</field></block></value><value name="ROW"><block type="math_number"><field name="NUM">0</field></block></value></block><block type="robActions_display_picture"><value name="X"><block type="math_number"><field name="NUM">0</field></block></value><value name="Y"><block type="math_number"><field name="NUM">0</field></block></value></block><block type="robActions_display_clear"/></category><category name="TOOLBOX_SOUND"><block type="robActions_play_tone"><value name="FREQUENCE"><block type="math_number"><field name="NUM">300</field></block></value><value name="DURATION"><block type="math_number"><field name="NUM">100</field></block></value></block><block type="robActions_play_file"/><block type="robActions_play_setVolume"><value name="VOLUME"><block type="math_number"><field name="NUM">50</field></block></value></block><block type="robActions_play_getVolume"/></category><category name="TOOLBOX_LIGHT"><block type="robActions_brickLight_on"/><block type="robActions_brickLight_off"/><block type="robActions_brickLight_reset"/></category></category><category name="TOOLBOX_SENSOR"><block type="robSensors_touch_isPressed"/><block type="robSensors_ultrasonic_getSample"><field name="SENSORPORT">4</field></block><block type="robSensors_colour_getSample"><field name="SENSORPORT">3</field></block><block type="robSensors_infrared_getSample"><field name="SENSORPORT">4</field></block><block type="robSensors_encoder_reset"/><block type="robSensors_encoder_getSample"/><block type="robSensors_key_isPressed"/><block type="robSensors_gyro_reset"><field name="SENSORPORT">2</field></block><block type="robSensors_gyro_getSample"><field name="SENSORPORT">2</field></block><block type="robSensors_timer_getSample"/><block type="robSensors_timer_reset"/></category><category name="TOOLBOX_CONTROL"><category name="TOOLBOX_DECISION"><block type="robControls_if"/><block type="robControls_ifElse"/></category><category name="TOOLBOX_LOOP"><block type="robControls_loopForever"/><block type="controls_repeat_ext"><value name="TIMES"><block type="math_number"><field name="NUM">10</field></block></value></block><block type="controls_whileUntil"/><block type="controls_for"><value name="FROM"><block type="math_number"><field name="NUM">1</field></block></value><value name="TO"><block type="math_number"><field name="NUM">10</field></block></value><value name="BY"><block type="math_number"><field name="NUM">1</field></block></value></block><block type="controls_forEach"/><block type="controls_flow_statements"/></category><category name="TOOLBOX_WAIT"><block type="robControls_wait"/><block type="robControls_wait_time"><value name="WAIT"><block type="math_number"><field name="NUM">500</field></block></value></block><block type="robControls_wait_for"><value name="WAIT0"><block type="logic_compare"><value name="A"><block type="robSensors_getSample"/></value><value name="B"><block type="logic_boolean"/></value></block></value></block></category></category><category name="TOOLBOX_LOGIC"><block type="logic_compare"/><block type="logic_operation"/><block type="logic_negate"/><block type="logic_boolean"/><block type="logic_null"/><block type="logic_ternary"/></category><category name="TOOLBOX_MATH"><block type="math_number"/><block type="math_arithmetic"/><block type="math_single"/><block type="math_trig"/><block type="math_constant"/><block type="math_number_property"/><block type="math_change"><value name="DELTA"><block type="math_number"><field name="NUM">1</field></block></value></block><block type="math_round"/><block type="math_on_list"/><block type="math_modulo"/><block type="math_constrain"><value name="LOW"><block type="math_number"><field name="NUM">1</field></block></value><value name="HIGH"><block type="math_number"><field name="NUM">100</field></block></value></block><block type="math_random_int"><value name="FROM"><block type="math_number"><field name="NUM">1</field></block></value><value name="TO"><block type="math_number"><field name="NUM">100</field></block></value></block><block type="math_random_float"/></category><category name="TOOLBOX_TEXT"><block type="text"/><block type="robText_join"/><block type="text_append"><value name="TEXT"><block type="text"/></value></block></category><category name="TOOLBOX_LIST"><block type="lists_create_empty"/><block type="robLists_create_with"><value name="ADD0"><block type="math_number"/></value><value name="ADD1"><block type="math_number"/></value><value name="ADD2"><block type="math_number"/></value></block><block type="lists_repeat"><value name="NUM"><block type="math_number"><field name="NUM">5</field></block></value></block><block type="lists_length"/><block type="lists_isEmpty"/><block type="lists_indexOf"/><block type="lists_getIndex"/><block type="lists_setIndex"/><block type="lists_getSublist"/></category><category name="TOOLBOX_COLOUR"><block type="robColour_picker"/></category><category name="TOOLBOX_VARIABLE" custom="VARIABLE"/><category name="TOOLBOX_PROCEDURE" custom="PROCEDURE"/><category name="TOOLBOX_COMMUNICATION"><block type="robCommunication_startConnection"/><block type="robCommunication_sendBlock"/><block type="robCommunication_receiveBlock"/><block type="robCommunication_waitForConnection"/></category></toolbox_set>',
now, now, now, now,
 '', 0
 );
commit;

insert into TOOLBOX
( NAME, OWNER_ID, ROBOT_ID, TOOLBOX_TEXT, CREATED, LAST_CHANGED, LAST_CHECKED, LAST_ERRORFREE, TAGS, ICON_NUMBER )
values('ev3Brick',NULL,'42','',
now, now, now, now,
 '', 0
 );
commit;

insert into TOOLBOX
( NAME, OWNER_ID, ROBOT_ID, TOOLBOX_TEXT, CREATED, LAST_CHANGED, LAST_CHECKED, LAST_ERRORFREE, TAGS, ICON_NUMBER )
values('expert',NULL,'43','<toolbox_set id="toolbox" style="display: none"><category name="TOOLBOX_ACTION"><category name="TOOLBOX_MOVE"><block type="sim_motor_on"><value name="POWER"><block type="math_number"><field name="NUM">30</field></block></value></block><block type="sim_motor_on_for"><value name="POWER"><block type="math_number"><field name="NUM">30</field></block></value><value name="VALUE"><block type="math_number"><field name="NUM">1</field></block></value></block><block type="sim_motor_stop"></block></category><category name="TOOLBOX_DRIVE"><block type="robActions_motorDiff_on"><value name="POWER"><block type="math_number"><field name="NUM">30</field></block></value></block><block type="robActions_motorDiff_on_for"><value name="POWER"><block type="math_number"><field name="NUM">30</field></block></value><value name="DISTANCE"><block type="math_number"><field name="NUM">20</field></block></value></block><block type="robActions_motorDiff_stop"> </block><block type="robActions_motorDiff_turn"><value name="POWER"><block type="math_number"><field name="NUM">30</field></block></value></block><block type="robActions_motorDiff_turn_for"><value name="POWER"><block type="math_number"><field name="NUM">30</field></block></value><value name="DEGREE"><block type="math_number"><field name="NUM">20</field></block></value></block></category><category name="TOOLBOX_LIGHT"><block type="sim_LED_on"/><block type="sim_LED_off"/></category></category><category name="TOOLBOX_SENSOR"><block type="sim_touch_isPressed"> </block><block type="sim_ultrasonic_getSample"><field name="SENSORPORT">4</field></block><block type="sim_colour_getSample"><field name="SENSORPORT">3</field></block></category><category name="TOOLBOX_CONTROL"><block type="robControls_if"/><block type="robControls_ifElse"/><block type="robControls_loopForever"/><block type="controls_repeat"> </block><block type="robControls_wait_time"><value name="WAIT"><block type="math_number"><field name="NUM">500</field></block></value></block><block type="robControls_wait_for"><value name="WAIT0"><block type="logic_compare"><value name="A"><block type="sim_getSample"> </block></value><value name="B"><block type="logic_boolean"> </block></value></block></value></block></category><category name="TOOLBOX_LOGIC"><block type="logic_compare"/><block type="logic_operation"/><block type="logic_boolean"/></category><category name="TOOLBOX_MATH"><block type="math_number"/><block type="math_arithmetic"/></category><category name="TOOLBOX_COLOUR"><block type="robColour_picker"><field name="COLOUR">#585858</field></block><block type="robColour_picker"><field name="COLOUR">#000000</field></block><block type="robColour_picker"><field name="COLOUR">#0057a6</field></block><block type="robColour_picker"><field name="COLOUR">#00642e</field></block><block type="robColour_picker"><field name="COLOUR">#f7d117</field></block><block type="robColour_picker"><field name="COLOUR">#b30006</field></block><block type="robColour_picker"><field name="COLOUR">#FFFFFF</field></block><block type="robColour_picker"><field name="COLOUR">#532115</field></block></category><category name="TOOLBOX_VARIABLE" custom="VARIABLE"/></toolbox_set>',
now, now, now, now,
 '', 0
 );
commit;

insert into PROGRAM
( NAME, OWNER_ID, ROBOT_ID, PROGRAM_TEXT, CREATED, LAST_CHANGED, LAST_CHECKED, LAST_ERRORFREE, NUMBER_OF_BLOCKS, TAGS, ICON_NUMBER )
values('NEPOprog',1,43,'<block_set xmlns="http://de.fhg.iais.roberta.blockly"><instance x="370" y="50"><block type="robControls_start" id="149" intask="true" deletable="false"><mutation declare="false"></mutation></block><block type="robActions_motorDiff_on" id="168" inline="false" intask="true"><field name="DIRECTION">FOREWARD</field><value name="POWER"><block type="math_number" id="169" intask="true"><field name="NUM">30</field></block></value></block><block type="robControls_wait_for" id="189" inline="false" intask="true"><value name="WAIT0"><block type="logic_compare" id="190" inline="true" intask="true"><mutation operator_range="COLOUR"></mutation><field name="OP">EQ</field><value name="A"><block type="sim_getSample" id="191" intask="true" deletable="false" movable="false"><mutation input="COLOUR_COLOUR"></mutation><field name="SENSORTYPE">COLOUR_COLOUR</field><field name="SENSORPORT">3</field></block></value><value name="B"><block type="robColour_picker" id="197" intask="true"><field name="COLOUR">#000000</field></block></value></block></value></block></instance></block_set>',
now, now, now, now,
0,'', 0
 );
commit;