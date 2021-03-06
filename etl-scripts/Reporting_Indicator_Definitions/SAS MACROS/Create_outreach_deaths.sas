
PROC OPTIONS OPTION = MACRO; RUN;

%Macro create_death_reason();


PROC IMPORT OUT= outreach_dates
            DATAFILE= "C:\DATA\CSV DATASETS\outreach_dates.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

data missapp_date;
format appdate missdate  ddmmyy10.;
set outreach_dates;
if concept_id=1592;
dd=substr(obs_datetime,9,2);
mm=substr(obs_datetime,6,2);
yy=substr(obs_datetime,1,4);
dd1=substr(value_datetime,9,2);
mm1=substr(value_datetime,6,2);
yy1=substr(value_datetime,1,4);
appdate=mdy(mm,dd,yy);
missdate=mdy(mm1,dd1,yy1);
drop obs_datetime mm yy dd concept_id dd1 mm1 yy1 value_datetime;
run;

proc sort data=death_outreach out=death_outreach_final  nodupkey; by person_id appdate dod ;run;


PROC DATASETS LIBRARY=WORK NOLIST;
		DELETE outreach_dates death_outreach;
		RUN;
   		QUIT;


%Mend create_death_reason;
%create_death_reason;
