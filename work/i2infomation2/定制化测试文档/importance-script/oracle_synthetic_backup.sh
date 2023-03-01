#!/usr/bin/env sh
su - oracle <<EON
sqlplus /nolog << EOF
conn /as sysdba 
shutdown immediate;
startup mount;
alter database archivelog;
EOF
EON

# 将数据库变为开启状态
su - oracle <<EON
sqlplus /nolog << EOF
conn /as sysdba 
alter database open;
archive log list; 
EOF
EON