#/bin/bash
echo "向工作机中的pdbs数据库pdb1中添加表记录test1,向工作机中的pdbs数据库pdb2中添加表记录test2========================="
su - oracle -c "sqlplus /nolog <<\"EOF\"
conn / as sysdba
alter pluggable database pdb1 open read write;
alter session set container=pdb1;
drop table test1;
CREATE TABLE tes1(
  id VARCHAR(14),
  name VARCHAR2(13)
);
alter pluggable database pdb2 open read write;
alter session set container=pdb2;
drop table tes2;
CREATE TABLE tes2(
  id VARCHAR(14),
  name VARCHAR2(13)
);
exit;
EOF"
