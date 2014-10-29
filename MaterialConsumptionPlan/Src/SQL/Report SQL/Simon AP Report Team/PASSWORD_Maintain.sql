sql>SELECT username,PROFILE FROM dba_users;

sql>SELECT * FROM dba_profiles s WHERE s.profile=\'DEFAULT\' AND resource_name=\'PASSWORD_LIFE_TIME\';

sql>ALTER PROFILE DEFAULT LIMIT PASSWORD_LIFE_TIME UNLIMITED;

$sqlplus / as sysdba
sql> alter user  system identified by password