#!/bin/sh
su - oracle <<EON
sqlplus /nolog << EOF
conn /as sysdba 
alter database open resetlogs;
EOF
EON