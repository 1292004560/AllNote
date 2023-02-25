#/bin/bash
echo "创建pdb1和pdb2数据库========================="
su - oracle -c "sqlplus /nolog <<\"EOF\"
conn / as sysdba
create pluggable database pdb1 admin user pdbadmin identified by oracle  file_name_convert=('pdbseed','pdb1');
create pluggable database pdb2 admin user pdbadmin identified by oracle  file_name_convert=('pdbseed','pdb2');
exit;
EOF"
