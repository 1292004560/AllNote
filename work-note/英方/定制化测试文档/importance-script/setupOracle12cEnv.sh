#!/bin/bash

dbSoftPath=$1
dbVersion=$2
iscdb=$3

echo $dbSoftPath
echo $dbVersion
echo $iscdb
####################### prepare swap disk ###############################
echo "n
p
1


t
82
p
w"|fdisk /dev/sdc
mkswap /dev/sdc1
swapoff -a
swapon /dev/sdc1
echo "/dev/sdc1 swap swap defaults 0 0" >> /etc/fstab


####################### define related 12c installation destination and layer ###############################
dbTopDir=/u01
oracleSid=orcl
oracleBase=/u01/app/oracle
oracleHome=/u01/app/oracle/product/12/db_1
oracleInventory=/u01/app/oraInventory
oracleData=/u01/app/oracle/oradata


####################### prepare related system account and packages ###############################
groupadd oinstall
groupadd dba
useradd -g oinstall -G dba -d /home/oracle -s /bin/bash -c "Oracle Software Owner" -m oracle
# yum -y install binutils compat-libcap1 compat-libstdc++-33 compat-libstdc++-33*i686 compat-libstdc++-33*.devel gcc gcc-c++ glibc glibc*i686 glibc-devel glibc-devel*.i686 ksh libaio libaio*.i686 libaio-devel libaio-devel*.devel libgcc libgcc*.i686 libstdc++ libstdc++*.i686 libstdc++-devel libstdc++-devel*.devel libXi libXi*.i686  libXtst libXtst*.i686  make sysstat unixODBC unixODBC*.i686 unixODBC-devel unixODBC-devel*.i686


####################### adjust related system seting ###############################
echo "
fs.aio-max-nr = 1048576
fs.file-max = 6815744
kernel.shmall = 2097152
kernel.shmmax  = 2061584302
kernel.shmmni = 4096
kernel.sem = 250 32000 100 128
net.ipv4.ip_local_port_range = 9000 65500
net.core.rmem_default = 262144
net.core.rmem_max = 4194304
net.core.wmem_default = 262144
net.core.wmem_max = 1048586
">> /etc/sysctl.conf
sysctl -p
echo "
oracle soft nproc 2047
oracle hard nproc 16384
oracle soft nofile 1024
oracle hard nofile 65536
oracle soft stack 10240
oracle hard stack 10240
">> /etc/security/limits.conf
echo "
if [ \$USER = "oracle" ]; then
   if [ $SHELL = "/bin/ksh" ]; then
       ulimit -p 16384
       ulimit -n 65536
    else
       ulimit -u 16384 -n 65536
   fi
fi
">> /etc/profile
source /etc/profile

echo "
export NLS_LANG=AMERICAN_AMERICA.UTF8
export LANG=en_US.UTF-8
export ORACLE_BASE=$oracleBase
export ORACLE_HOME=$oracleHome
export ORACLE_SID=$oracleSid
export PATH=\$ORACLE_HOME/bin:/usr/sbin:$PATH
export LD_LIBRARY_PATH=\$ORACLE_HOME/lib
">> /home/oracle/.bash_profile
source /home/oracle/.bash_profile
chmod -R 755 /home/oracle
chown -R oracle:oinstall /home/oracle/

echo "
export NLS_LANG=AMERICAN_AMERICA.UTF8
export LANG=en_US.UTF-8
export ORACLE_BASE=$oracleBase
export ORACLE_HOME=$oracleHome
export ORACLE_SID=$oracleSid
export PATH=\$ORACLE_HOME/bin:/usr/sbin:$PATH
export LD_LIBRARY_PATH=\$ORACLE_HOME/lib
">> /root/.bash_profile
source /root/.bash_profile

useradd -g oinstall -G dba -m renl
mkdir -p /home/renl
cp /root/.bash_profile /home/renl
source /home/renl/.bash_profile

####################### prepare 12c binary and response file ###############################
mkfs.xfs /dev/sdd
mkdir $dbTopDir
mount /dev/sdd $dbTopDir
if [ $dbVersion = '12.1.0.2' ]
then
	unzip $dbSoftPath/12.1.0.2_Linux_x86.64/linuxamd64_12102_database_1of2.zip -d $dbTopDir 
	unzip $dbSoftPath/12.1.0.2_Linux_x86.64/linuxamd64_12102_database_2of2.zip -d $dbTopDir
elif [ $dbVersion = '12.2.0.1' ]
then
	unzip $dbSoftPath/12.2.0.1_Linux_x86.64/linuxx64_12201_database.zip -d $dbTopDir
fi
cp $dbTopDir/database/response/db_install.rsp $dbTopDir/dbinstall.rsp

sed -i "s|oracle.install.option.*|oracle.install.option=INSTALL_DB_SWONLY|g" $dbTopDir/dbinstall.rsp
sed -i "s|ORACLE_HOSTNAME.*|ORACLE_HOSTNAME=$(hostname -s)|g" $dbTopDir/dbinstall.rsp
sed -i "s|UNIX_GROUP_NAME.*|UNIX_GROUP_NAME=oinstall|g" $dbTopDir/dbinstall.rsp
sed -i "s|INVENTORY_LOCATION.*|INVENTORY_LOCATION=$oracleInventory|g" $dbTopDir/dbinstall.rsp
sed -i "s|SELECTED_LANGUAGES.*|SELECTED_LANGUAGES=en,zh_CN|g" $dbTopDir/dbinstall.rsp
sed -i "s|ORACLE_HOME.*|ORACLE_HOME=$oracleHome|g" $dbTopDir/dbinstall.rsp
sed -i "s|ORACLE_BASE.*|ORACLE_BASE=$oracleBase|g" $dbTopDir/dbinstall.rsp
sed -i "s|oracle.install.db.InstallEdition.*|oracle.install.db.InstallEdition=EE|g" $dbTopDir/dbinstall.rsp
if [ $dbVersion = '12.2.0.1' ]
then
	echo "this is a flag12.2.0.1......................................................."
	sed -i "s|oracle.install.db.OSDBA_GROUP.*|oracle.install.db.OSDBA_GROUP=dba|g" $dbTopDir/dbinstall.rsp
	sed -i "s|oracle.install.db.OSOPER_GROUP.*|oracle.install.db.OSOPER_GROUP=oinstall|g" $dbTopDir/dbinstall.rsp
	sed -i "s|oracle.install.db.OSBACKUPDBA_GROUP.*|oracle.install.db.OSBACKUPDBA_GROUP=oinstall|g" $dbTopDir/dbinstall.rsp
	sed -i "s|oracle.install.db.OSDGDBA_GROUP.*|oracle.install.db.OSDGDBA_GROUP=oinstall|g" $dbTopDir/dbinstall.rsp
	sed -i "s|oracle.install.db.OSKMDBA_GROUP.*|oracle.install.db.OSKMDBA_GROUP=oinstall|g" $dbTopDir/dbinstall.rsp
	sed -i "s|oracle.install.db.OSRACDBA_GROUP.*|oracle.install.db.OSRACDBA_GROUP=oinstall|g" $dbTopDir/dbinstall.rsp
elif [ $dbVersion = '12.1.0.2' ]
then
	echo "this is a flag12.1.0.2......................................................"
	sed -i "s|oracle.install.db.DBA_GROUP.*|oracle.install.db.DBA_GROUP=dba|g" $dbTopDir/dbinstall.rsp
	sed -i "s|oracle.install.db.OPER_GROUP.*|oracle.install.db.OPER_GROUP=oinstall|g" $dbTopDir/dbinstall.rsp
	sed -i "s|oracle.install.db.BACKUPDBA_GROUP.*|oracle.install.db.BACKUPDBA_GROUP=oinstall|g" $dbTopDir/dbinstall.rsp
	sed -i "s|oracle.install.db.DGDBA_GROUP.*|oracle.install.db.DGDBA_GROUP=oinstall|g" $dbTopDir/dbinstall.rsp
	sed -i "s|oracle.install.db.KMDBA_GROUP.*|oracle.install.db.KMDBA_GROUP=oinstall|g" $dbTopDir/dbinstall.rsp
fi
sed -i "s|oracle.install.db.config.starterdb.type.*|oracle.install.db.config.starterdb.type=GENERAL_PURPOSE|g" $dbTopDir/dbinstall.rsp
sed -i "s|oracle.install.db.config.starterdb.memoryLimit.*|oracle.install.db.config.starterdb.memoryLimit=512|g" $dbTopDir/dbinstall.rsp
sed -i "s|oracle.install.db.config.starterdb.password.ALL.*|oracle.install.db.config.starterdb.password.ALL=welcome1|g" $dbTopDir/dbinstall.rsp
sed -i "s|oracle.install.db.config.starterdb.storageType.*|oracle.install.db.config.starterdb.storageType=FILE_SYSTEM_STORAGE|g" $dbTopDir/dbinstall.rsp
sed -i "s|oracle.install.db.config.starterdb.fileSystemStorage.dataLocation.*|oracle.install.db.config.starterdb.fileSystemStorage.dataLocation=$oracleData|g" $dbTopDir/dbinstall.rsp
sed -i "s|SECURITY_UPDATES_VIA_MYORACLESUPPORT.*|SECURITY_UPDATES_VIA_MYORACLESUPPORT=false|g" $dbTopDir/dbinstall.rsp
sed -i "s|DECLINE_SECURITY_UPDATES.*|DECLINE_SECURITY_UPDATES=true|g" $dbTopDir/dbinstall.rsp
sed -i "s|oracle.install.db.config.starterdb.characterSet.*|oracle.install.db.config.starterdb.characterSet=AL32UTF8|g" $dbTopDir/dbinstall.rsp

chown -R oracle:oinstall $dbTopDir
chmod 755 -R $dbTopDir


####################### setup and configure 12c db ###############################
echo "Trying to install oracle 12c..............."
su - oracle -c "$dbTopDir/database/runInstaller -ignoreSysPrereqs  -ignorePrereq -invPtrLoc $oracleInventory/oraInst.loc -force -silent -waitforcompletion -responseFile $dbTopDir/dbinstall.rsp"
if [ $? -eq 0 ]; then
    echo "Trying to run $oracleHome/root.sh..............."
    $oracleHome/root.sh
    echo "Trying to netca..............."
    su - oracle -c "$oracleHome/bin/netca -silent -responsefile $dbTopDir/database/response/netca.rsp"
    if [ $? -eq 0 ]; then
        echo "Trying to dbca..............."
        if [ $iscdb = 'false' ]; then
            su - oracle -c "dbca -createDatabase -templateName General_Purpose.dbc -gdbName $oracleSid -sid $oracleSid -sysPassword welcome1 -systemPassword welcome1 -dbsnmpPassword welcome1 -emConfiguration LOCAL -datafileJarLocation \$ORACLE_HOME/assistants/dbca/templates -storageType FS -datafileDestination $oracleData -responseFile NO_VALUE -characterset AL32UTF8 -totalMemory 1638 -obfuscatedPasswords false -sampleSchema true -oratabLocation ORATAB -recoveryAreaDestination NO_VALUE -silent"
        elif [ $iscdb = 'true' ]; then
            su - oracle -c "dbca -createDatabase -templateName General_Purpose.dbc -gdbName $oracleSid -sid $oracleSid -createAsContainerDatabase true -numberOfPDBs 1 -pdbName orclpdb -sysPassword welcome1 -systemPassword welcome1 -pdbAdminPassword welcome1 -dbsnmpPassword welcome1 -emExpressPort 5500 -omsPort 0 -memoryPercentage 40 -automaticMemoryManagement false -datafileJarLocation $ORACLE_HOME/assistants/dbca/templates -storageType FS -datafileDestination /u01/app/oradata -responseFile NO_VALUE -characterset AL32UTF8 -listeners LISTENER -obfuscatedPasswords false -sampleSchema true -oratabLocation ORATAB -recoveryAreaDestination NO_VALUE -silent"             
        fi
            
        if [ $? -eq 0 ]; then
            sed -i "s|ORACLE_HOME_LISTNER=.*|ORACLE_HOME_LISTNER=\$ORACLE_HOME|g" $oracleHome/bin/dbstart
            sed -i "s|ORACLE_HOME_LISTNER=.*|ORACLE_HOME_LISTNER=\$ORACLE_HOME|g" $oracleHome/bin/dbshut
            echo "checking to db status..............."
            su - oracle -c "lsnrctl status;ps -ef|grep ora_|grep -v grep;sqlplus / as sysdba <<\"EOF\"
select status from v\$instance;
select * from v\$version;
exit;
EOF"
            exit 0
        else
            echo dbca with failures
            exit 1
        fi
    else
        echo netca with failures
        exit 1
    fi
else
    echo db installation with failure
    exit 1
fi

