#/bin/bash
echo "备份tnsnames.ora 数据"
cp  $ORACLE_HOME/network/admin/tnsnames.ora ./tns.txt
cp  $ORACLE_HOME/network/admin/tnsnames.ora ./tns2.txt

cat tns2.txt >> tns.txt

sed -i '16c ORCLPDB' tns.txt
sed -i '21c  (SERVICE_NAME = orclpdb)' tns.txt
rm -r $ORACLE_HOME/network/admin/tnsnames.ora
cp tns.txt  $ORACLE_HOME/network/admin/tnsnames.ora

su - oracle -c "sqlplus / as sysdba <<\"EOF\"
alter pluggable database ORCLPDB open read write;
alter session set container=ORCLPDB;
exit;
EOF"
echo "重启监听"
lsnrctl stop
lsnrctl start
su - oracle -c "sqlplus /nolog <<\"EOF\"
conn / as sysdba
alter session set container=ORCLPDB;
drop table student;
CREATE TABLE student(
  id VARCHAR(14),
  name VARCHAR2(13)
);
exit;
EOF"
