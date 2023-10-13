## wintm.bat

```bash
@echo off

hostname|findstr dttvm
if errorlevel 1 (
    exit 0
)
ping -n 10 127.0.0.1>nul
ping www.baidu.com -n 10
if errorlevel 0 (

    TZUTIL /s "China Standard Time" & w32tm /resync

)

echo start script %date% %time%
ping -n 10 127.0.0.1>nul
TZUTIL /s "China Standard Time" & w32tm /resync /force
echo end script %date% %time%
```

## winsetupsvr.bat

```bash
@echo off

hostname|findstr "dttvm dttvp"
if errorlevel 1 (
    exit 0
)

ping -n 10 127.0.0.1>nul
ping www.baidu.com -n 10
if errorlevel 0 (

    TZUTIL /s "China Standard Time" & net stop w32time & net start w32time & w32tm /resync /force

    tasklist|findstr sshd.exe
    if errorlevel 1 (
        echo start sshd....
        "C:\Program Files\OpenSSH\usr\sbin\sshd.exe"
    )
    if not exist z:\ (
        echo mount dtt src....
        net use z: \\172.20.64.100\auto_package
    )
    if not exist d:\ (
        echo mount disk1 ....
        diskpart /s z:\script\diskpartsvr.txt
    )
    if not exist d:\ (
        echo mount disk1 ....
        diskpart /s z:\script\diskpartsvr2.txt
    )    
    if exist D:\auto (
        echo remkdir auto home....
        rd /s/q D:\auto
        echo mkdir auto home....
        md D:\auto
        xcopy z:\DTT\*.* D:\auto /s /e /c /y /h /r
        xcopy z:\script\*.* D:\auto\script /s /e /c /y /h /r
    ) else (
        echo mkdir auto home....
        md D:\auto
        xcopy z:\DTT\*.* D:\auto /s /e /c /y /h /r
        xcopy z:\script\*.* D:\auto\script /s /e /c /y /h /r
    )

    if not exist C:\Users\Administrator\.ssh (
        md C:\Users\Administrator\.ssh
        copy z:\soft\key\whb_git_id_rsa C:\Users\Administrator\.ssh\id_rsa
        type z:\soft\key\whb_git_known_hosts >> C:\Users\Administrator\.ssh\known_hosts
    )
       
    if not exist D:\work (
        echo mkdir auto work....
        md D:\work
    )

    tasklist|findstr vncserver.exe
    if errorlevel 1 (
        echo start vncserver....
        "C:\Program Files\RealVNC\VNC Server\vncserver.exe" -service -start
    )

    netstat -ano|findstr 33033
    if errorlevel 1 (
        echo start dtt proxy....
        echo "start /b java -cp %AUTO_HOME%\common\lib\dtt-1.0.0.jar;%AUTO_HOME%\common\lib\xmlparserv2.jar;%AUTO_HOME%\common\lib\jsch2.jar info2soft.engine.Proxy 33033 >%AUTO_WORK%\nohup.out"
        start /b java -cp %AUTO_HOME%\common\lib\dtt-1.0.0.jar;%AUTO_HOME%\common\lib\xmlparserv2.jar;%AUTO_HOME%\common\lib\jsch2.jar info2soft.engine.Proxy 33033 >%AUTO_WORK%\nohup.out
        REM net start vncserver

    )
)

echo end script %date% %time%
```

## winsetup2003.bat

```sh
@echo off

hostname|findstr "dttvm dttvp"
if errorlevel 1 (
    exit 0
)

ping -n 10 127.0.0.1>nul
ping www.baidu.com -n 10
if errorlevel 0 (

    TZUTIL /s "China Standard Time" & net stop w32time & net start w32time & w32tm /resync /force

    tasklist|findstr sshd.exe
    if errorlevel 1 (
        echo start sshd....
        "C:\Program Files\OpenSSH\usr\sbin\sshd.exe"
    )
    if not exist z:\ (
        echo mount dtt src....
        net use z: \\172.20.64.100\auto_package
    )
    if not exist d:\ (
        echo mount disk1 ....
        diskpart /s z:\script\diskpartsvr.txt
    )
    if not exist d:\ (
        echo mount disk1 ....
        diskpart /s z:\script\diskpartsvr2.txt
    )    
    if exist D:\auto (
        echo remkdir auto home....
        rd /s/q D:\auto
        echo mkdir auto home....
        md D:\auto
        xcopy z:\DTT\*.* D:\auto /s /e /c /y /h /r
        xcopy z:\script\*.* D:\auto\script /s /e /c /y /h /r
    ) else (
        echo mkdir auto home....
        md D:\auto
        xcopy z:\DTT\*.* D:\auto /s /e /c /y /h /r
        xcopy z:\script\*.* D:\auto\script /s /e /c /y /h /r
    )

    if not exist C:\Users\Administrator\.ssh (
        md C:\Users\Administrator\.ssh
        copy z:\soft\key\whb_git_id_rsa C:\Users\Administrator\.ssh\id_rsa
        type z:\soft\key\whb_git_known_hosts >> C:\Users\Administrator\.ssh\known_hosts
    )
       
    if not exist D:\work (
        echo mkdir auto work....
        md D:\work
    )

    tasklist|findstr vncserver.exe
    if errorlevel 1 (
        echo start vncserver....
        "C:\Program Files\RealVNC\VNC Server\vncserver.exe" -service -start
    )

    netstat -ano|findstr 33033
    if errorlevel 1 (
        echo start dtt proxy....
        echo "start /b java -cp %AUTO_HOME%\common\lib\dtt-1.0.0.jar;%AUTO_HOME%\common\lib\xmlparserv2.jar;%AUTO_HOME%\common\lib\jsch2.jar info2soft.engine.Proxy 33033 >%AUTO_WORK%\nohup.out"
        start /b java -cp %AUTO_HOME%\common\lib\dtt-1.0.0.jar;%AUTO_HOME%\common\lib\xmlparserv2.jar;%AUTO_HOME%\common\lib\jsch2.jar info2soft.engine.Proxy 33033 >%AUTO_WORK%\nohup.out
        REM net start vncserver

    )
)

echo end script %date% %time%
```

## winsetup.bat

```sh
@echo off

hostname|findstr dttvm
if errorlevel 1 (
    exit 0
)

set dttBranch=%1

ping -n 10 127.0.0.1>nul
ping www.baidu.com -n 10
if errorlevel 0 (

    TZUTIL /s "China Standard Time" & net stop w32time & net start w32time & w32tm /resync /force

    if not exist z:\ (
        echo mount dtt src....
        net use z: \\172.20.64.100\auto_package
    )
    if not exist d:\ (
        echo mount disk1 ....
        diskpart /s z:\script\diskpart.txt
    )
    if not exist d:\ (
        echo mount disk1 ....
        diskpart /s z:\script\diskpart2.txt
    )
    if exist D:\auto (
        echo remkdir auto home....
        rd /s/q D:\auto
        echo mkdir auto home....
        md D:\auto
        xcopy z:\DTT\*.* D:\auto /s /e /c /y /h /r
        xcopy z:\script\*.* D:\auto\script /s /e /c /y /h /r
    ) else (
        echo mkdir auto home....
        md D:\auto
        xcopy z:\DTT\*.* D:\auto /s /e /c /y /h /r
        xcopy z:\script\*.* D:\auto\script /s /e /c /y /h /r
    )

    if not exist C:\Users\Administrator\.ssh (
        md C:\Users\Administrator\.ssh
        copy z:\soft\key\whb_git_id_rsa C:\Users\Administrator\.ssh\id_rsa
        type z:\soft\key\whb_git_known_hosts >> C:\Users\Administrator\.ssh\known_hosts
    )
    
    if defined dttBranch (
        rd /s/q D:\auto\latest
        if "%dttBranch%" == "master" (
            echo git clone ssh://git@code.info2soft.com:25730/i2qa/auto/topologizer.git D:\auto\latest
            git clone ssh://git@code.info2soft.com:25730/i2qa/auto/topologizer.git D:\auto\latest
        ) else (
            echo git clone ssh://git@code.info2soft.com:25730/i2qa/auto/topologizer.git -b %dttBranch% D:\auto\latest
            git clone ssh://git@code.info2soft.com:25730/i2qa/auto/topologizer.git -b %dttBranch% D:\auto\latest
        )
        rd /s/q D:\auto\basicTasks D:\auto\python D:\auto\topologies
        md D:\auto\basicTasks D:\auto\python D:\auto\topologies
        xcopy D:\auto\latest\basicTasks\*.* D:\auto\basicTasks /s /e /c /y /h /r
        xcopy D:\auto\latest\python\*.* D:\auto\python /s /e /c /y /h /r
        xcopy D:\auto\latest\topologies\*.* D:\auto\topologies /s /e /c /y /h /r
        xcopy D:\auto\latest\script\*.* D:\auto\script /s /e /c /y /h /r
    )    
    
    if not exist D:\work (
        echo mkdir auto work....
        md D:\work
    )

    tasklist|findstr vncserver.exe
    if errorlevel 1 (
        echo start vncserver....
        "C:\Program Files\RealVNC\VNC Server\vncserver.exe" -service -start
    )

    netstat -ano|findstr 33033
    if errorlevel 1 (
        echo start dtt proxy....
        echo "start /b java -cp %AUTO_HOME%\common\lib\dtt-1.0.0.jar;%AUTO_HOME%\common\lib\xmlparserv2.jar;%AUTO_HOME%\common\lib\jsch2.jar info2soft.engine.Proxy 33033 >%AUTO_WORK%\nohup.out"
        start /b java -cp %AUTO_HOME%\common\lib\dtt-1.0.0.jar;%AUTO_HOME%\common\lib\xmlparserv2.jar;%AUTO_HOME%\common\lib\jsch2.jar info2soft.engine.Proxy 33033 >%AUTO_WORK%\nohup.out
        REM net start vncserver

    )
)
```

## updateNic.sh

```sh
#!/bin/bash

macAddress=`ip addr|grep ether|awk '{print $2}'`
netCardName=`ip addr|grep ^2|awk '{print $2}'|awk -F: '{print $1}'`
netCfgFile="/etc/sysconfig/network-scripts/ifcfg-$netCardName"
if ! [ -e $netCfgFile ]; then
    netCfgFile="/etc/sysconfig/network/ifcfg-$netCardName"
fi

if [ $# -eq 1 ]; then
    newIP=$1
fi

if uname -a|grep PVE ; then
    netCfgFile="/etc/network/interfaces"
    sed -i "s|address.*|address  $newIP|g" $netCfgFile
    service networking restart
    exit 0
fi

if uname -a|grep -i 4.19.90-23.8.v2101.ky10.aarch64 ; then
    netCfgFile="/etc/sysconfig/network-scripts/ifcfg-$netCardName"
    sed -i "s|IPADDR=.*|IPADDR=$newIP|g" $netCfgFile
    reboot
    exit 0
fi

if uname -a | grep -i smp && grep -i suse /proc/version; then
    netCfgFile="/etc/sysconfig/network/ifcfg-$netCardName"
    sed -i "s|IPADDR=.*|IPADDR=$newIP|g" $netCfgFile
    service network restart
    exit 0
fi

if uname -a|grep -i 4.4.58-20171113.kylin.5.all-generic ; then
    netCfgFile="/etc/network/interfaces"
    sed -i "s|address.*|address  $newIP|g" $netCfgFile
    reboot
    exit 0
fi

if uname -a|grep -i 4.19.90-24.4.v2101.ky10.x86_64 ; then
    netCfgFile="/etc/sysconfig/network-scripts/ifcfg-$netCardName"
    sed -i "s|IPADDR=.*|IPADDR=$newIP|g" $netCfgFile
    reboot
    exit 0
fi

if uname -a|grep -i 4.4.131-20191129.kylin.x86-generic ; then
    netCfgFile="/etc/network/interfaces"
    sed -i "s|address.*|address  $newIP|g" $netCfgFile
    reboot
    exit 0
fi

if uname -a|grep -i 4.19.90-25.10.v2101.ky10.aarch64 ; then
    netCfgFile="/etc/sysconfig/network-scripts/ifcfg-$netCardName"
    sed -i "s|IPADDR.*|IPADDR=$newIP|g" $netCfgFile
    reboot
    exit 0
fi

if uname -a|grep -i 4.19.90-23.6.v2101.ky10 ; then
    netCfgFile="/etc/sysconfig/network-scripts/ifcfg-$netCardName"
    sed -i "s|IPADDR=.*|IPADDR=$newIP|g" $netCfgFile
    reboot
    exit 0
fi

if uname -a|grep -i 4.4.131-20190726.kylin.server-generic; then
    netCfgFile="/etc/network/interfaces"
    sed -i "s|address.*|address $newIP|g" $netCfgFile
    reboot
    exit 0
fi

if uname -a|grep -i 5.4.119-19.0009.7.rc1 ; then
    netCfgFile="/etc/sysconfig/network-scripts/ifcfg-$netCardName"
    sed -i "s|IPADDR=.*|IPADDR=$newIP|g" $netCfgFile
    reboot
    exit 0
fi

if uname -a|grep -i uos ; then
    netCfgFile="/etc/network/interfaces"
    sed -i "s|address.*|address  $newIP|g" $netCfgFile
    /etc/init.d/networking restart
    exit 0
fi
#uos x86
if uname -a|grep -i 4.19.0-server-amd64 ; then
    netCfgFile="/etc/network/interfaces"
    sed -i "s|address.*|address  $newIP|g" $netCfgFile
    /etc/init.d/networking restart
    exit 0
fi

#uos arm
if uname -a|grep -i dtt-PC ; then
    netCfgFile="/etc/network/interfaces"
    sed -i "s|address.*|address  $newIP|g" $netCfgFile
    reboot
    exit 0
fi

#uos-euler arm
if uname -a|grep -i up1.uel20.aarch64 ; then
    netCfgFile="/etc/sysconfig/network-scripts/ifcfg-$netCardName"
    sed -i "s|IPADDR=.*|IPADDR=$newIP|g" $netCfgFile
    reboot
    exit 0
fi

if uname -a|grep -i up2.uel20.aarch64 ; then
    netCfgFile="/etc/sysconfig/network-scripts/ifcfg-$netCardName"
    sed -i "s|IPADDR=.*|IPADDR=$newIP|g" $netCfgFile
    reboot
    exit 0
fi

#special euler arm
if uname -a|grep -i oe1.aarch64 ; then
    netCfgFile="/etc/sysconfig/network-scripts/ifcfg-$netCardName"
    sed -i "s|IPADDR=.*|IPADDR=$newIP|g" $netCfgFile
    reboot
    exit 0
fi

if uname -a|grep -i neokylin ; then
    netCfgFile="/etc/sysconfig/network-scripts/ifcfg-$netCardName"
    sed -i "s|IPADDR=.*|IPADDR=$newIP|g" $netCfgFile
    service network restart
    exit 0
fi

if uname -a|grep -i 2.6.18-411.ky3.skl ; then
    netCfgFile="/etc/sysconfig/network-scripts/ifcfg-$netCardName"
    sed -i "s|IPADDR=.*|IPADDR=$newIP|g" $netCfgFile
    service network restart
    exit 0
fi

if uname -a|grep -i 2.6.32-754.23.1.ky3.kb1.pg.x86_64 ; then
    netCfgFile="/etc/sysconfig/network-scripts/ifcfg-$netCardName"
    sed -i "s|IPADDR=.*|IPADDR=$newIP|g" $netCfgFile
    service network restart
    exit 0
fi

if uname -a|grep -i yhkylin ; then
    netCfgFile="/etc/sysconfig/network-scripts/ifcfg-$netCardName"
    sed -i "s|IPADDR=.*|IPADDR=$newIP|g" $netCfgFile
    reboot
    exit 0
fi

if uname -a|grep -i BCLinux ; then
    netCfgFile="/etc/sysconfig/network-scripts/ifcfg-$netCardName"
    sed -i "s|IPADDR=.*|IPADDR=$newIP|g" $netCfgFile
    service network restart
    exit 0
fi

if uname -a|grep -i NFS ; then
    netCfgFile="/etc/sysconfig/network-scripts/ifcfg-$netCardName"
    sed -i "s|IPADDR=.*|IPADDR=$newIP|g" $netCfgFile
    reboot
    exit 0
fi

if uname -a|grep -i 4.4.58-20180824.kylin.x86-generic ; then
    netCfgFile="/etc/network/interfaces"
    sed -i "s|address.*|address  $newIP|g" $netCfgFile
    reboot
    exit 0
fi

if uname -a|grep -i 4.4.131-20200704.kylin.server-generic ; then
    netCfgFile="/etc/network/interfaces"
    sed -i "s|address.*|address  $newIP|g" $netCfgFile
    reboot
    exit 0
fi

if uname -a|grep -i 4.4.131-20200618.kylin.desktop-generic ; then
    netCfgFile="/etc/network/interfaces"
    sed -i "s|address.*|address  $newIP|g" $netCfgFile
    reboot
    exit 0
fi

if uname -a|grep -i 4.19.90-24.4.v2101.ky10.aarch64 ; then
    netCfgFile="/etc/sysconfig/network-scripts/ifcfg-$netCardName"
    sed -i "s|IPADDR=.*|IPADDR=$newIP|g" $netCfgFile
    reboot
    exit 0
fi

if uname -a|grep -i 4.19.90-11.ky10.aarch64 ; then
    netCfgFile="/etc/sysconfig/network-scripts/ifcfg-$netCardName"
    sed -i "s|IPADDR=.*|IPADDR=$newIP|g" $netCfgFile
    reboot
    exit 0
fi
# puhua
if uname -a|grep -i 3.10.0-327.el7.isoft ; then
    netCfgFile="/etc/sysconfig/network-scripts/ifcfg-$netCardName"
    sed -i "s|IPADDR=.*|IPADDR=$newIP|g" $netCfgFile
    reboot
    exit 0
fi

if uname -a|grep -i 4.19.90-9.ky10.aarch64 ; then
    netCfgFile="/etc/sysconfig/network-scripts/ifcfg-$netCardName"
    sed -i "s|IPADDR=.*|IPADDR=$newIP|g" $netCfgFile
    reboot
    exit 0
fi

if uname -a|grep -iE 'openeuler|eulerosv2r9' ; then
    netCfgFile="/etc/sysconfig/network-scripts/ifcfg-$netCardName"
    sed -i "s|IPADDR=.*|IPADDR=$newIP|g" $netCfgFile
    nmcli c reload
	  nmcli c up $netCardName
    exit 0
fi

#  20220629 add openEuler 22.03 LTS(华为欧拉）
#  20230621 add openEuler 22.03 sp1.28(华为欧拉)
#  20230629 add openEuler 22.03 sp1.12(华为欧拉)
if uname -a|grep -iE 'oe2203.x86_64|5.10.0-136.28.0.104.oe2203sp1.x86_64|5.10.0-136.12.0.86.oe2203sp1.x86_64' ; then
    netCfgFile="/etc/sysconfig/network-scripts/ifcfg-$netCardName"
    sed -i "s|IPADDR=.*|IPADDR=$newIP|g" $netCfgFile
    nmcli c reload
	  nmcli c up $netCardName
    exit 0
fi

if uname -a|grep -i el8.aarch64 ; then
    netCfgFile="/etc/sysconfig/network-scripts/ifcfg-$netCardName"
    sed -i "s|IPADDR=.*|IPADDR=$newIP|g" $netCfgFile
    reboot
    exit 0
fi

if uname -a|grep -i H3C ; then
    netCfgFile="/etc/sysconfig/network-scripts/ifcfg-vswitch0"
    sed -i "s|IPADDR=.*|IPADDR=$newIP|g" $netCfgFile
    service network restart
    exit 0
fi

if uname -a|grep -i cvknode ; then
    netCfgFile="/etc/sysconfig/network-scripts/ifcfg-vswitch0"
    sed -i "s|IPADDR=.*|IPADDR=$newIP|g" $netCfgFile
    service network restart
    exit 0
fi

if uname -a|grep -i debian ; then
    netCfgFile="/etc/network/interfaces"
    sed -i "s|address.*|address  $newIP|g" $netCfgFile
    if lsb_release -a|grep -i Release|grep 9 ; then
        reboot
    else
        service networking restart
    fi
    exit 0
fi

if uname -a|grep -i ubuntu ; then
    netCfgFile="/etc/network/interfaces"
    sed -i "s|address.*|address  $newIP|g" $netCfgFile
    service networking restart
    reboot
    exit 0
fi
#rocky8.4
if uname -a|grep -i el8_4.x86_64 ; then
    netCfgFile="/etc/sysconfig/network-scripts/ifcfg-$netCardName"
    sed -i "s|IPADDR=.*|IPADDR=$newIP|g" $netCfgFile
    reboot
    exit 0
fi

if ! grep -n $macAddress $netCfgFile ; then
    sed -i "s|HWADDR.*|HWADDR=$macAddress|g" $netCfgFile
    sed -i "/^UUID/d" $netCfgFile
fi

if ! [ -z $newIP ]; then
    ipKey=`grep ^IPA $netCfgFile|cut -d'=' -f1`
    sed -i "s|IPADDR.*|$ipKey=$newIP|g" $netCfgFile
fi

if uname -a|grep -i el8.x86_64 ; then
    reboot
else
    service network restart
fi
```

## uitestsetup.bat

```sh
@echo off

hostname|findstr dttvm
if errorlevel 1 (
    exit 0
)

if exist c:\autologin.reg (
    echo import auto login information to register table
    reg import c:\autologin.reg
)

ping www.baidu.com -n 1
if errorlevel 0 (

    TZUTIL /s "China Standard Time" & net stop w32time & net start w32time & w32tm /resync
    
    if not exist C:\Users\Administrator\AppData\Local\Google (
        mklink /J C:\Users\Administrator\AppData\Local\Google "C:\Program Files\Google"
    )
    if not exist C:\Users\Administrator\Desktop\chrome.exe (
        mklink C:\Users\Administrator\Desktop\chrome.exe C:\Users\Administrator\AppData\Local\Google\Chrome\Application\chrome.exe
    )
    if not exist z:\ (
        echo mount dtt src....
        net use z: \\172.20.64.100\auto_package
    )

    tasklist|findstr vncserver.exe
    if errorlevel 1 (
        echo start vncserver....
        "C:\Program Files\RealVNC\VNC Server\vncserver.exe" -service -start
    )
    netstat -ano|findstr 33033
    if errorlevel 1 (
        echo start dtt proxy....
        if exist C:\Users\Administrator\auto (
            echo delete auto home....
            rd /s/q C:\Users\Administrator\auto
        )
        echo mkdir auto home....
        md C:\Users\Administrator\auto
        if exist C:\Users\Administrator\work (
            echo delete auto work....
            rd /s/q C:\Users\Administrator\work
        )
        echo mkdir auto work....
        md C:\Users\Administrator\work
        xcopy z:\DTT\*.* C:\Users\Administrator\auto /s /e /c /y /h /r
        echo "start /b java -cp C:\Users\Administrator\auto\common\lib\dtt-1.0.0.jar;C:\Users\Administrator\auto\common\lib\xmlparserv2.jar;C:\Users\Administrator\auto\common\lib\jsch2.jar info2soft.engine.Proxy 33033 >C:\Users\Administrator\work\nohup.out"
        start /b java -cp C:\Users\Administrator\auto\common\lib\dtt-1.0.0.jar;C:\Users\Administrator\auto\common\lib\xmlparserv2.jar;C:\Users\Administrator\auto\common\lib\jsch2.jar info2soft.engine.Proxy 33033 >C:\Users\Administrator\work\nohup.out
        REM net start vncserver

    )
)
```

## uitestlogin.bat

```sh
@echo off

echo start script %date% %time%

hostname|findstr dttvm
if errorlevel 1 (
    exit 0
)

ping -n 30 127.0.0.1>nul

for /f "tokens=2 delims=:" %%i in ('ipconfig^|findstr /c:"IPv4"') do set ipstr=%%i
for /f "tokens=*" %%i in ("%ipstr%") do set ip=%%~nxi

ping www.baidu.com -n 10
if errorlevel 0 (

    TZUTIL /s "China Standard Time" & w32tm /resync

    if not exist z:\ (
        echo mount dtt src....
        net use z: \\172.20.64.100\auto_package
    )

    if not exist c:\keys (
        echo generate ssh key....
        md c:\keys
        copy /Y z:\soft\key\whb_git_id_rsa c:\keys\git
        ssh-keygen -t rsa -f c:\keys\ssh -N ""
        REM for /F %%j in ( 'hostname' ) do ( set tag_flag=%%j )
        echo copy /Y c:\keys\ssh.pub z:\keys\%ip%_ssh.pub
        copy /Y c:\keys\ssh.pub z:\keys\%ip%_ssh.pub
    )
    if not exist C:\Users\Administrator\.ssh (
        md C:\Users\Administrator\.ssh
        copy z:\soft\key\whb_git_id_rsa C:\Users\Administrator\.ssh\id_rsa
        type z:\soft\key\whb_git_known_hosts >> C:\Users\Administrator\.ssh\known_hosts
    )
    netstat -ano|findstr 33033
    if errorlevel 1 (
        echo start dtt proxy....
        if exist C:\Users\Administrator\auto (
            echo delete auto home....
            rd /s/q C:\Users\Administrator\auto
        )
        echo mkdir auto home....
        md C:\Users\Administrator\auto
        if exist C:\Users\Administrator\work (
            echo delete auto work....
            rd /s/q C:\Users\Administrator\work
        )
        echo mkdir auto work....
        md C:\Users\Administrator\work
        xcopy z:\DTT\*.* C:\Users\Administrator\auto /s /e /c /y /h /r
        echo "start /b java -cp C:\Users\Administrator\auto\common\lib\dtt-1.0.0.jar;C:\Users\Administrator\auto\common\lib\xmlparserv2.jar;C:\Users\Administrator\auto\common\lib\jsch2.jar info2soft.engine.Proxy 33033 >C:\Users\Administrator\work\nohup.out"
        start /b java -cp C:\Users\Administrator\auto\common\lib\dtt-1.0.0.jar;C:\Users\Administrator\auto\common\lib\xmlparserv2.jar;C:\Users\Administrator\auto\common\lib\jsch2.jar info2soft.engine.Proxy 33033 >C:\Users\Administrator\work\nohup.out
        REM net start vncserver

    )
)

echo end script %date% %time%
ping -n 30 127.0.0.1>nul
TZUTIL /s "China Standard Time" & w32tm /resync
echo done > C:\Users\Administrator\started
echo end script %date% %time%
```

## uirunner.sh

```sh
#!/bin/bash
WORK_DIR=$(dirname $0)
echo WORK_DIR: $WORK_DIR


if [ $# -eq 2 ]; then
    TEST_SUITE=$1
    TEST_DATA=$2
fi

if [ $# -eq 3 ]; then
    TEST_SUITE=$1
    TEST_DATA=$2
    BRANCH=$3
fi

if [ -z $TEST_SUITE ]; then
    echo "test suite must be provided."
    exit 1
fi
if [ -z $TEST_DATA ]; then
    echo "test data file must be provided."
    exit 1
fi
if [ ! -e $TEST_DATA ]; then
    echo "test data file must be existed."
    exit 1
fi

NFS_DIR=/home/i2auto
HTTP_DOC_DIR=/home/result
TEST_HOME=/home/package
PROJECT_HOME=$TEST_HOME/i2up


###############   setup test resources    ##################
source /etc/profile
if [[ -z $SKIP_DOWNLOAD || $SKIP_DOWNLOAD != true ]]; then
gitHost=/root/.ssh/known_hosts
if [ ! -e $gitHost ]; then
    echo "cat /home/i2auto/autotools/ssh_publickey/whb_git_know_host >> $gitHost"
    cat /home/i2auto/autotools/ssh_publickey/whb_git_know_host >> $gitHost
elif ! grep info2soft $gitHost ; then
    echo "cat /home/i2auto/autotools/ssh_publickey/whb_git_know_host >> $gitHost"
    cat /home/i2auto/autotools/ssh_publickey/whb_git_know_host >> $gitHost
else
    echo "git host has existed"
fi
if [ -z $BRANCH ]; then
    git clone ssh://git@code.info2soft.com:25730/i2qa/auto/i2up.git 
else
    if [ -e "$NFS_DIR/$BRANCH" ]; then
        echo "cp -fr $NFS_DIR/$BRANCH $PROJECT_HOME"
        cp -fr $NFS_DIR/$BRANCH $PROJECT_HOME
    else
        echo "git clone ssh://git@code.info2soft.com:25730/i2qa/auto/i2up.git -b $BRANCH"
        git clone ssh://git@code.info2soft.com:25730/i2qa/auto/i2up.git -b $BRANCH 
    fi
fi
fi
#cd $TEST_HOME
#git config core.sshCommand 'ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
#git clone ssh://git@code.info2soft.com:25730/i2qa/auto/i2up.git -b pagerefactor


if [ ! -e $PROJECT_HOME ]; then
    echo "ERROR: The specified project home $PROJECT_HOME does not exist."
    exit 1
fi
if [ ! -e $PROJECT_HOME/testdata/TestSuite/$TEST_SUITE ]; then
    echo "ERROR: the specified test suite $TEST_SUITE does not exist under $PROJECT_HOME/testdata/TestSuite"
    exit 1
fi
cd $PROJECT_HOME
chmod +x $PROJECT_HOME/common/chromedriver

##############  setup complied folder     ##################
if [ -d results/compiled ]; then
    rm -rf results/compiled
fi
mkdir -p results/compiled


#############   setup reunner, test suite, test json data   ##################
cp common/runner.conf.linux common/runner.conf
cp -f InstanceInfo.xml InstanceInfo.xml.bak
cp InstanceInfo.xml.linux InstanceInfo.xml

i2upIp=$(cat $TEST_DATA|grep i2upIp|cut -d: -f2|cut -d'"' -f2)
i2upVersion=$(cat $TEST_DATA|grep i2upVersion|cut -d: -f2|cut -d'"' -f2)
i2upOsType=$(cat $TEST_DATA|grep i2upOsType|cut -d: -f2|cut -d'"' -f2)
i2upOsVersion=$(cat $TEST_DATA|grep i2upOsVersion|cut -d: -f2|cut -d'"' -f2)
componentOsType=$(cat $TEST_DATA|grep componentOsType|cut -d: -f2|cut -d'"' -f2)
componentOsVersion=$(cat $TEST_DATA|grep componentOsVersion|cut -d: -f2|cut -d'"' -f2)    
componentName=$(cat $TEST_DATA|grep componentName|cut -d: -f2|cut -d'"' -f2)
componentVersion=$(cat $TEST_DATA|grep componentVersion|cut -d: -f2|cut -d'"' -f2)
componentIpList=$(cat $TEST_DATA|grep componentIpList|cut -d: -f2|cut -d'"' -f2)

sed -i "s|TestSuite/LoginTest.xml|TestSuite/$TEST_SUITE|g" InstanceInfo.xml
sed -i "s|i2upIpTemplate|$i2upIp|g" InstanceInfo.xml
sed -i "s|i2upVersionTemplate|$i2upVersion|g" InstanceInfo.xml
sed -i "s|i2upOsTypeTemplate|$i2upOsType|g" InstanceInfo.xml
sed -i "s|i2upOsVersionTemplate|$i2upOsVersion|g" InstanceInfo.xml
sed -i "s|componentNameTemplate|$componentName|g" InstanceInfo.xml
sed -i "s|componentVersionTemplate|$componentVersion|g" InstanceInfo.xml
sed -i "s|componentOsTypeTemplate|$componentOsType|g" InstanceInfo.xml
sed -i "s|componentOsVersionTemplate|$componentOsVersion|g" InstanceInfo.xml
sed -i "s|componentIpListTemplate|$componentIpList|g" InstanceInfo.xml

#############   trigger uitest     ##################
echo "java -Dfile.encoding=UTF-8 -cp $CLASSPATH:$PROJECT_HOME/common/lib/selenium-runner-1.0.0-20190903.jar:$PROJECT_HOME/results/compiled info2soft.qa.TestRunner | tee results/TestRunner.txt"
java -Dfile.encoding=UTF-8 -cp $CLASSPATH:$PROJECT_HOME/common/lib/selenium-runner-1.0.0-20190903.jar:$PROJECT_HOME/results/compiled info2soft.qa.TestRunner | tee results/TestRunner.txt


############   cleanup non-test result    ############# 
rm -rf results/profile*
rm -rf results/compiled*


############    upload result into http server   ############# 
if [[ $# -lt 3 || $3 != "no" ]]; then
    echo "start to upload result into http server"
    componentOs=${componentOsType}_${componentOsVersion}
    i2upOs=${i2upOsType}_${i2upOsVersion}
    RESULT_DIR=$HTTP_DOC_DIR/i2up_$i2upVersion/$i2upOs/${componentName}_$componentVersion/$componentOs/$(date +%Y%m%d%H%M%S)
    echo "mkdir -p $RESULT_DIR"
    mkdir -p $RESULT_DIR
    echo "cp -fr results/* $RESULT_DIR"
    cp -fr results/*  $RESULT_DIR
fi


############    check and return test status    ############# 
if find results -name Summary.xml|xargs grep -i "fail"
then
   echo "The job failed";
   exit 1
else
   echo "The job succeeded";
   exit 0
fi
```

## turnOnDMArchivelog.sh

```sh
#!/bin/bash
su -l dmdba -c "
disql /nolog << EOF
    conn SYSDBA/SYSDBA
    alter DATABASE MOUNT;
    alter database add archivelog 'dest=/root/dmdba/dmdbms/data/dmarchivelog,type=local,file_size=1024,space_limit=4096';
    ALTER DATABASE ARCHIVELOG;
    ALTER DATABASE OPEN;
    EXIT;
EOF
"
```

## topologizer.sh

```sh
#!/bin/bash

WORK_DIR=$(cd $(dirname $0); pwd)
echo WORK_DIR: $WORK_DIR

LIB_DIR=$(dirname $WORK_DIR)
LIB_DIR="${LIB_DIR}/common/lib"

    source /etc/profile
    
    CLASSPATH=${LIB_DIR}/topologizer-1.0.0.jar:${LIB_DIR}/dom4j-1.6.1.jar:$CLASSPATH
    echo "java -cp $CLASSPATH info2soft.qa.auto.util.Topologizer $@"
    java -cp $CLASSPATH info2soft.qa.auto.util.Topologizer $@
```

## startport.sh

```sh
#!/bin/bash
autoHomeDir="/root/auto"
autoWorkDir="/root/work"
if ! ps -ef|grep java|grep 33033 ;then
    source /etc/profile
    export AUTO_HOME=$autoHomeDir
    export AUTO_WORK=$autoWorkDir
    CLASSPATH=$AUTO_HOME/common/lib/dtt-1.0.0.jar:$AUTO_HOME/common/lib/xmlparserv2.jar:$AUTO_HOME/common/lib/jsch2.jar:$CLASSPATH
    echo "nohup java -cp $CLASSPATH info2soft.engine.Proxy 33033 >/root/nohup.out 2>&1 &"
    if netstat -anp|grep :33033 ;then
        echo "33033 has been used"
        if netstat -anp|grep 33033|grep 'rpc.statd' ;then
            echo "stop rpc-statd"
            service rpc-statd stop
            nohup java -cp $CLASSPATH info2soft.engine.Proxy 33033 >/root/nohup.out 2>&1 &
            sleep 2s
            service rpc-statd start
        fi
        if netstat -anp|grep 33033|grep rpcbind ;then
            echo "stop rpcbind"
            service rpcbind stop
            nohup java -cp $CLASSPATH info2soft.engine.Proxy 33033 >/root/nohup.out 2>&1 &
            sleep 2s
            service rpcbind start
        fi
    else
        nohup java -cp $CLASSPATH info2soft.engine.Proxy 33033 >/root/nohup.out 2>&1 &
    fi
fi
```

## startDttJobMultiOs.sh

```sh
#!/bin/bash

if [ $# -lt 2 ]; then
    echo "USAGE: /home/i2auto/script/startDttJob.sh -t /home/i2auto/DTT/topologies/demoTest.xml -d /home/i2auto/testdata/inputData/coopyTestData_template.json -o centos_7.4 -v 7.1.55.19092919 TEST_SUITE=DemoTest.xml MAIL_LIST=wanghb@info2soft.com,fanzk@info2soft.com -startproxy"
    exit 1
fi

nasMountDir="/home/i2auto"

while getopts "t:o:d:v:" opt; do
    case $opt in
        t)
            topology=$OPTARG
            ;;
        o)
            platform=$OPTARG
            ;;
        d)
            testDataTemplate=$OPTARG
            ;;
        v)
            testVersion=$OPTARG
            ;;
        :)
             echo "$0:Must supply an argument to -$OPTARG."
             exit 1
             ;;
    esac
done

if [ -z $platform ]; then
    echo "platform must be provided."
    exit 1
fi
osArray=(${platform//,/ })
if [ ${#osArray[@]} -gt 2 ]; then
    echo "Current only support two vm for node installation and one vm for i2up installation"
    exit 1
elif [ ${#osArray[@]} -eq 2 ]; then
    componentOsSet=${osArray[0]}
    i2upOsSet=${osArray[1]}
    if [[ $componentOsSet =~ ":" ]] ; then
        echo "Not support to specify node vm number in $componentOsSet"
        exit 1
    fi
    if [[ $i2upOsSet =~ ":" ]] ; then
        echo "Not support to specify i2up vm number in $i2upOsSet"
        exit 1
    fi    
    platform="${componentOsSet}:2,$i2upOsSet"
    componentOsArray=(${componentOsSet//_/ })
    i2upOsArray=(${i2upOsSet//_/ })
else
    osSet=${osArray[0]}
    if [[ $osSet =~ ":" ]]; then
        echo "Not support to specify vm number in $osSet"
        exit 1
    fi
    platform="${osSet}:3"
    componentOsArray=(${osSet//_/ })
    i2upOsArray=(${osSet//_/ })
fi

vmUser=root
vmPwd=123456
vmProxyPort=33033
vmAutoHome=/root/auto
vmAutoWork=/root/work


if docker images
then
    dttJobId=dtt$(date +%Y%m%d%H%M%N)
    echo "start dtt job $dttJobId"
    mkdir -p /root/$dttJobId
    AUTO_HOME=/root/$dttJobId/auto
    AUTO_WORK=/root/$dttJobId/work
    ###############   setup test resources    ##################
    $nasMountDir/script/dttenv.sh $AUTO_HOME $AUTO_WORK
    source /etc/profile
    #set back to prevent change from /etc/profile
    export AUTO_HOME=$AUTO_HOME
    export AUTO_WORK=$AUTO_WORK

    ####################### start to prepare dtt test vm host ###################################
    echo "..................start to prepare dtt test vm host................."

    cp -f $AUTO_HOME/vm.properties $AUTO_WORK/vm.properties
    $AUTO_HOME/script/generateVm.sh $platform $AUTO_WORK/vm.properties

    echo "..................complete to prepare dtt test vm host................."
    ####################### complete to prepare dtt test vm host ###################################

    machineList=`grep vm_ip_list  $AUTO_WORK/vm.properties|cut -d'=' -f2`
    ipArray=(${machineList//,/ })
    ####################### start to prepare dtt test env ###################################
    echo "..................start to prepare dtt test env................."
    
    for ip in ${ipArray[@]}
    do
        newMachineList=${newMachineList}${ip}:${vmUser}:${vmPwd}","
    done
    echo "$nasMountDir/script/setupDttEnv.sh ${newMachineList%?}"
    $nasMountDir/script/setupDttEnv.sh ${newMachineList%?}
    echo "..................complete to prepare dtt test env................."
    ####################### complete to prepare dtt test env ###################################


    #############   setup topology file   ##################
    cp -f $AUTO_HOME/InstanceInfo.xml $AUTO_HOME/InstanceInfo.xml.bak
    sed -i "s|.*TOPOFILE.*|<param name=\"TOPOFILE\" value=\"$topology\"/>|g" $AUTO_HOME/InstanceInfo.xml
    
    
    #############   setup test data json file   ##################
    testDataFile=$AUTO_WORK/testData.json
    cp -f $testDataTemplate $testDataFile
    sed -i "s|nodeIpTemplate1|${ipArray[0]}|g" $testDataFile
    sed -i "s|nodeIpTemplate2|${ipArray[1]}|g" $testDataFile
    sed -i "s|i2upIpTemplate|${ipArray[2]}|g" $testDataFile
    sed -i "s|i2upOsTypeTemplate|${i2upOsArray[0]}|g" $testDataFile
    sed -i "s|componentOsTypeTemplate|${componentOsArray[0]}|g" $testDataFile
    sed -i "s|i2upOsVersionTemplate|${i2upOsArray[1]}|g" $testDataFile
    sed -i "s|componentOsVersionTemplate|${componentOsArray[1]}|g" $testDataFile
    sed -i "s|i2upVersionTemplate|${testVersion}|g" $testDataFile
    sed -i "s|componentVersionTemplate|${testVersion}|g" $testDataFile
    cp -f $testDataFile $nasMountDir/testdata/inputData/${dttJobId}testData.json
    testDataFile=$nasMountDir/testdata/inputData/${dttJobId}testData.json
    
    #############   trigger dtt job     ##################
    for ip in ${ipArray[@]}
    do
        dttjobMachineList=${dttjobMachineList}${ip}:${vmProxyPort}:${vmUser}:${vmPwd}:${vmAutoHome}:${vmAutoWork}","
    done
    CLASSPATH=$AUTO_HOME/common/lib/dtt-1.0.0.jar:$AUTO_HOME/common/lib/xmlparserv2.jar:$AUTO_HOME/common/lib/jsch2.jar:$CLASSPATH    
    echo "java -cp $CLASSPATH info2soft.execution.StartDttJob -m ${dttjobMachineList%?} TEST_DATA=$testDataFile $@ | tee $AUTO_WORK/console.log"
    java -cp $CLASSPATH info2soft.execution.StartDttJob -m ${dttjobMachineList%?} TEST_DATA=$testDataFile $@ | tee $AUTO_WORK/console.log
    rm -rf $testDataFile
    #rm -rf /root/$dttJobId
else
    ###############   setup test resources    ##################
    $nasMountDir/script/dttenv.sh
    source /etc/profile

    #############   setup topology file   ##################
    cp -f $AUTO_HOME/InstanceInfo.xml $AUTO_HOME/InstanceInfo.xml.bak
    sed -i "s|.*TOPOFILE.*|<param name=\"TOPOFILE\" value=\"$topology\"/>|g" $AUTO_HOME/InstanceInfo.xml


    #############   trigger dtt job     ##################
    CLASSPATH=$AUTO_HOME/common/lib/dtt-1.0.0.jar:$AUTO_HOME/common/lib/xmlparserv2.jar:$AUTO_HOME/common/lib/jsch2.jar:$CLASSPATH    
    echo "java -cp $CLASSPATH info2soft.execution.StartDttJob -m ${dttjobMachineList%?} $@"
    java -cp $CLASSPATH info2soft.execution.StartDttJob -m ${dttjobMachineList%?} $@
fi




####################### start to cleanup dtt test vm host ###################################
echo "..................start to cleanup dtt test vm host.................."

echo "..................complete to cleanup dtt test vm host.................."
####################### complete to cleanup dtt test vm host ###################################
```

## startDttJob.sh

```sh
#!/bin/bash

if [ $# -lt 2 ]; then
    echo "USAGE: /home/i2auto/script/startDttJob.sh -t /home/i2auto/DTT/topologies/demoTest.xml -o centos_7.4 -v 7.1.55.19092919 TEST_SUITE=DemoTest.xml MAIL_LIST=wanghb@info2soft.com,fanzk@info2soft.com -startproxy"
    exit 1
fi

nasMountDir="/home/i2auto"

while getopts "t:o:v:" opt; do
    case $opt in
        t)
            topology=$OPTARG
            ;;
        o)
            platform=$OPTARG
            ;;
        v)
            testVersion=$OPTARG
            ;;
        :)
             echo "$0:Must supply an argument to -$OPTARG."
             exit 1
             ;;
    esac
done

if [ -z $topology ]; then
    echo "topology must be provided."
    exit 1
fi
if [ ! -f $topology ]; then
    echo "topology file $topology must be existed."
    exit 1
fi
if [ -z $platform ]; then
    echo "platform must be provided."
    exit 1
fi
testDataTemplate="$nasMountDir/testdata/inputData/TestDataTemplate.json"
if [ ! -f $testDataTemplate ]; then
    echo "testDataTemplate file $testDataTemplate must be existed."
    exit 1
fi
if [ -z $testVersion ]; then
    echo "platform must be provided."
    exit 1
fi

osArray=(${platform//,/ })
if [ ${#osArray[@]} -gt 2 ]; then
    echo "Current only support two vm for node installation and one vm for i2up installation"
    exit 1
elif [ ${#osArray[@]} -eq 2 ]; then
    componentOsSet=${osArray[0]}
    i2upOsSet=${osArray[1]}
    if [[ $componentOsSet =~ ":" ]] ; then
        echo "Not support to specify node vm number in $componentOsSet"
        exit 1
    fi
    if [[ $i2upOsSet =~ ":" ]] ; then
        echo "Not support to specify i2up vm number in $i2upOsSet"
        exit 1
    fi    
    platform="${componentOsSet}:2,$i2upOsSet"
    componentOsArray=(${componentOsSet//_/ })
    i2upOsArray=(${i2upOsSet//_/ })
else
    osSet=${osArray[0]}
    if [[ $osSet =~ ":" ]]; then
        echo "Not support to specify vm number in $osSet"
        exit 1
    fi
    platform="${osSet}:3"
    componentOsArray=(${osSet//_/ })
    i2upOsArray=(${osSet//_/ })
fi

vmUser=root
vmPwd=123456
vmProxyPort=33033
vmAutoHome=/root/auto
vmAutoWork=/root/work


if docker images
then
    dttJobId=dtt$(date +%Y%m%d%H%M%N)
    echo "start dtt job $dttJobId"
    mkdir -p /root/$dttJobId
    AUTO_HOME=/root/$dttJobId/auto
    AUTO_WORK=/root/$dttJobId/work
    ###############   setup test resources    ##################
    $nasMountDir/script/dttenv.sh $AUTO_HOME $AUTO_WORK
    source /etc/profile
    #set back to prevent change from /etc/profile
    export AUTO_HOME=$AUTO_HOME
    export AUTO_WORK=$AUTO_WORK

    ####################### start to prepare dtt test vm host ###################################
    echo "..................start to prepare dtt test vm host................."

    cp -f $AUTO_HOME/vm.properties $AUTO_WORK/vm.properties
    $AUTO_HOME/script/generateVm.sh $platform $AUTO_WORK/vm.properties

    echo "..................complete to prepare dtt test vm host................."
    ####################### complete to prepare dtt test vm host ###################################

    machineList=`grep vm_ip_list  $AUTO_WORK/vm.properties|cut -d'=' -f2`
    ipArray=(${machineList//,/ })
    ####################### start to prepare dtt test env ###################################
    echo "..................start to prepare dtt test env................."
    
    for ip in ${ipArray[@]}
    do
        newMachineList=${newMachineList}${ip}:${vmUser}:${vmPwd}","
    done
    echo "$nasMountDir/script/setupDttEnv.sh ${newMachineList%?}"
    $nasMountDir/script/setupDttEnv.sh ${newMachineList%?}
    echo "..................complete to prepare dtt test env................."
    ####################### complete to prepare dtt test env ###################################


    #############   setup topology file   ##################
    cp -f $AUTO_HOME/InstanceInfo.xml $AUTO_HOME/InstanceInfo.xml.bak
    sed -i "s|.*TOPOFILE.*|<param name=\"TOPOFILE\" value=\"$topology\"/>|g" $AUTO_HOME/InstanceInfo.xml
    
    
    #############   setup test data json file   ##################
    testDataFile=$AUTO_WORK/testData.json
    cp -f $testDataTemplate $testDataFile
    sed -i "s|nodeIpTemplate1|${ipArray[0]}|g" $testDataFile
    sed -i "s|nodeIpTemplate2|${ipArray[1]}|g" $testDataFile
    sed -i "s|i2upIpTemplate|${ipArray[2]}|g" $testDataFile
    sed -i "s|componentIpListTemplate|${ipArray[0]},${ipArray[1]}|g" $testDataFile
    sed -i "s|i2upOsTypeTemplate|${i2upOsArray[0]}|g" $testDataFile
    sed -i "s|componentOsTypeTemplate|${componentOsArray[0]}|g" $testDataFile
    sed -i "s|i2upOsVersionTemplate|${i2upOsArray[1]}|g" $testDataFile
    sed -i "s|componentOsVersionTemplate|${componentOsArray[1]}|g" $testDataFile
    sed -i "s|i2upVersionTemplate|${testVersion}|g" $testDataFile
    sed -i "s|componentVersionTemplate|${testVersion}|g" $testDataFile
    cp -f $testDataFile $nasMountDir/testdata/inputData/${dttJobId}testData.json
    testDataFile=$nasMountDir/testdata/inputData/${dttJobId}testData.json
    
    #############   trigger dtt job     ##################
    for ip in ${ipArray[@]}
    do
        dttjobMachineList=${dttjobMachineList}${ip}:${vmProxyPort}:${vmUser}:${vmPwd}:${vmAutoHome}:${vmAutoWork}","
    done
    CLASSPATH=$AUTO_HOME/common/lib/dtt-1.0.0.jar:$AUTO_HOME/common/lib/xmlparserv2.jar:$AUTO_HOME/common/lib/jsch2.jar:$CLASSPATH    
    echo "java -cp $CLASSPATH info2soft.execution.StartDttJob -m ${dttjobMachineList%?} TEST_DATA=$testDataFile $@ | tee $AUTO_WORK/console.log"
    java -cp $CLASSPATH info2soft.execution.StartDttJob -m ${dttjobMachineList%?} TEST_DATA=$testDataFile $@ | tee $AUTO_WORK/console.log
    rm -rf $testDataFile
    #rm -rf /root/$dttJobId
else
    ###############   setup test resources    ##################
    $nasMountDir/script/dttenv.sh
    source /etc/profile

    #############   setup topology file   ##################
    cp -f $AUTO_HOME/InstanceInfo.xml $AUTO_HOME/InstanceInfo.xml.bak
    sed -i "s|.*TOPOFILE.*|<param name=\"TOPOFILE\" value=\"$topology\"/>|g" $AUTO_HOME/InstanceInfo.xml


    #############   trigger dtt job     ##################
    CLASSPATH=$AUTO_HOME/common/lib/dtt-1.0.0.jar:$AUTO_HOME/common/lib/xmlparserv2.jar:$AUTO_HOME/common/lib/jsch2.jar:$CLASSPATH    
    echo "java -cp $CLASSPATH info2soft.execution.StartDttJob -m ${dttjobMachineList%?} $@"
    java -cp $CLASSPATH info2soft.execution.StartDttJob -m ${dttjobMachineList%?} $@
fi




####################### start to cleanup dtt test vm host ###################################
echo "..................start to cleanup dtt test vm host.................."

echo "..................complete to cleanup dtt test vm host.................."
####################### complete to cleanup dtt test vm host ###################################


```

## startDockervnc.sh

```sh
#!/bin/bash
WORK_DIR=$(dirname $0)
echo WORK_DIR: $WORK_DIR

dockerName=i2test$(date +%Y%m%d%H%M%S)


#!/bin/bash
WORK_DIR=$(dirname $0)
echo WORK_DIR: $WORK_DIR

dockerName=i2test$(date +%Y%m%d%H%M%S)

if ps -ef|grep docker|grep DISPLAY ; then
    echo "There are some of dtt dockers started with DISPLAY"
    DTT_PROC_ID_LIST=($(ps -ef|grep docker|grep DISPLAY|cut -d"=" -f2|awk -F" " '{print $1}'|sort))
    VNC_ID_LIST=($(vncserver -list|grep :|grep -v session|awk -F" " '{print $1}'|sort))
    VNC_ID_LISTBK=${VNC_ID_LIST[@]}
    for vncId in ${VNC_ID_LIST[@]}; do
        echo "vncid is $vncId"
        i=0
        for dttProcId in ${DTT_PROC_ID_LIST[@]}; do
            echo "dtt proc id is $dttProcId"
            if [ $vncId = $dttProcId ];then
                echo "delete vncid $vncId"
                unset VNC_ID_LIST[$i]
            fi
            let i+=1
        done
    done

            for oldvnc in ${VNC_ID_LISTBK[@]}; do
                 echo "3333333333333333333 oldvnc is $oldvnc"
            done
     
    if [ ${#VNC_ID_LIST[@]} -eq 0 ]; then
        echo "no remaining vnc, so start new vnc"
        vncPort=1
        while [ $vncPort -lt 10 ]
        do
            FOUND=0
            for oldvnc in ${VNC_ID_LISTBK[@]}; do
                if [[ $oldvnc =~ $vncPort ]]; then
                    FOUND=1
                fi
            done
            if [ $FOUND -eq 0 ]; then
                break
            fi
            let vncPort+=1
        done
        echo "try to start vnc on :$vncPort"
echo "kill -9 \`ps -ef|grep \"Xvnc :$vncPort\" | grep -v grep| awk -F\" \" '{print $2}'\`"
        if ps -ef|grep -v grep|grep "Xvnc :$vncPort" ; then
            echo "There are orphan vnc process on :$vncPort"
            echo "kill -9 `ps -ef|grep \"Xvnc :$vncPort\" | grep -v grep| awk -F\" \" '{print $2}'`"
            kill -9 `ps -ef|grep "Xvnc :$vncPort" | grep -v grep| awk -F" " '{print $2}'`
        fi
        if [ -e "/tmp/.X${vncPort}-lock" ];then
            echo "rm -f /tmp/.X${vncPort}-lock"
            rm -f /tmp/.X${vncPort}-lock
        fi
        if [ -e "/tmp/.X11-unix/X${vncPort}" ];then
            echo "rm -f /tmp/.X11-unix/X${vncPort}"
            rm -f /tmp/.X11-unix/X${vncPort}
        fi
        vncserver :$vncPort
        VNC_DISPLAY=":$vncPort"
        echo "assinged vnc is $VNC_DISPLAY"
    else
        echo "vnc remaining number is ${#VNC_ID_LIST[@]}"
        VNC_DISPLAY=""
        for vnc in ${VNC_ID_LIST[@]}; do
            echo "the remaining vnc id is $vnc"
            VNC_DISPLAY=$vnc
            break
        done
        echo "assinged vnc is $VNC_DISPLAY" 
    fi
else
    echo "no dtt docker running"
    if vncserver -list|grep :|grep -v session ; then
        echo "There are some of vnc started"
        abc=$(vncserver -list|grep :|grep -v session)
        echo "0000000000 $abc"
        VNC_DISPLAY=$(vncserver -list|grep :|grep -v session|head -1|cut -f1)
        echo "assinged vnc is $VNC_DISPLAY"
        echo "kill -9 `ps -ef|grep 'Xvnc :1' | grep -v 'grep' | awk -F\" \" '{print $2}'`"
    else
        echo "no vnc running,so try to start on :1"
        if ps -ef|grep 'Xvnc :1' ; then
            echo "There are orphan vnc process on :1"
            echo "kill -9 `ps -ef|grep 'Xvnc :1' | grep -v 'grep' | awk -F\" \" '{print $2}'`"
            kill -9 `ps -ef | grep APPTOP | awk -F" " '{print $2}' | grep -v "grep" | grep -v "5605"`
        fi
        if [ -e "/tmp/.X1-lock" ];then
            echo "rm -f /tmp/.X1-lock"
            rm -f /tmp/.X1-lock
        fi
        if [ -e "/tmp/.X11-unix/X1" ];then
            echo "rm -f /tmp/.X11-unix/X1"
            rm -f /tmp/.X11-unix/X1
        fi
        echo "try to start vnc on :1"
        vncserver :1
        VNC_DISPLAY=$(vncserver -list|grep :|grep -v session|head -1|cut -f1)
        echo "assinged vnc is $VNC_DISPLAY"        
    fi
fi


```

## startDocker.sh

```sh
#!/bin/bash
WORK_DIR=$(dirname $0)
echo WORK_DIR: $WORK_DIR

dockerName=i2test$(date +%Y%m%d%H%M%S)

if ps -ef|grep docker|grep DISPLAY ; then
    echo "There are some of dtt dockers started with DISPLAY"
    DTT_PROC_ID_LIST=($(ps -ef|grep docker|grep DISPLAY|cut -d"=" -f2|awk -F" " '{print $1}'|sort))
    VNC_ID_LIST=($(vncserver -list|grep :|grep -v session|awk -F" " '{print $1}'|sort))
    VNC_ID_LISTBK=${VNC_ID_LIST[@]}
    i=0
    for vncId in ${VNC_ID_LIST[@]}; do
        echo "vncid is $vncId"
        for dttProcId in ${DTT_PROC_ID_LIST[@]}; do
            echo "dtt proc id is $dttProcId"
            if [ $vncId = $dttProcId ];then
                echo "delete vncid $vncId"
                echo "current i is $i"
                echo "current VNC_ID_LIST ${VNC_ID_LIST[$i]}"
                unset VNC_ID_LIST[$i]
            fi
        done
        let i+=1
    done
    
    if [ ${#VNC_ID_LIST[@]} -eq 0 ]; then
        echo "no remaining vnc, so start new vnc"
        vncPort=1
        while [ $vncPort -lt 10 ]
        do
            FOUND=0
            for oldvnc in ${VNC_ID_LISTBK[@]}; do
                if [[ $oldvnc =~ $vncPort ]]; then
                    FOUND=1
                fi
            done
            if [ $FOUND -eq 0 ]; then
                break
            fi
            let vncPort+=1
        done
        echo "try to start vnc on :$vncPort"
        if ps -ef|grep -v grep|grep "Xvnc :$vncPort" ; then
            echo "There are orphan vnc process on :$vncPort"
            echo "kill -9 \`ps -ef|grep \"Xvnc :$vncPort\"|grep -v grep|awk -F\" \" '{print \$2}'\`"
            kill -9 `ps -ef|grep "Xvnc :$vncPort"|grep -v grep|awk -F" " '{print $2}'`
        fi
        if [ -e "/tmp/.X${vncPort}-lock" ];then
            echo "rm -f /tmp/.X${vncPort}-lock"
            rm -f /tmp/.X${vncPort}-lock
        fi
        if [ -e "/tmp/.X11-unix/X${vncPort}" ];then
            echo "rm -f /tmp/.X11-unix/X${vncPort}"
            rm -f /tmp/.X11-unix/X${vncPort}
        fi
        vncserver :$vncPort
        VNC_DISPLAY=":$vncPort"
        echo "assinged vnc is $VNC_DISPLAY"
    else
        echo "vnc remaining number is ${#VNC_ID_LIST[@]}"
        VNC_DISPLAY=""
        for vnc in ${VNC_ID_LIST[@]}; do
            echo "the remaining vnc id is $vnc"
            VNC_DISPLAY=$vnc
            break
        done
        echo "assinged vnc is $VNC_DISPLAY" 
    fi
else
    echo "no dtt docker running"
    if vncserver -list|grep :|grep -v session ; then
        echo "There are some of vnc started"
        VNC_DISPLAY=$(vncserver -list|grep :|grep -v session|head -1|cut -f1)
        echo "assinged vnc is $VNC_DISPLAY"
    else
        echo "no vnc running,so start new vnc on :1"
        if ps -ef|grep -v grep|grep 'Xvnc :1' ; then
            echo "There are orphan vnc process on :1"
            echo "kill -9 \`ps -ef|grep \"Xvnc :1\"|grep -v grep|awk -F\" \" '{print \$2}'\`"
            kill -9 `ps -ef|grep "Xvnc :1"|grep -v grep|awk -F" " '{print $2}'`
        fi
        if [ -e "/tmp/.X1-lock" ];then
            echo "rm -f /tmp/.X1-lock"
            rm -f /tmp/.X1-lock
        fi
        if [ -e "/tmp/.X11-unix/X1" ];then
            echo "rm -f /tmp/.X11-unix/X1"
            rm -f /tmp/.X11-unix/X1
        fi
        echo "try to start vnc on :1"
        vncserver :1
        VNC_DISPLAY=$(vncserver -list|grep :|grep -v session|head -1|cut -f1)
        echo "assinged vnc is $VNC_DISPLAY"        
    fi
fi

if [ -z $VNC_DISPLAY ]; then
    echo "The VNC_DISPLAY must be provided."
    exit 1
fi

dockerOptions="-v /etc/localtime:/etc/localtime:ro -v /tmp/.X11-unix:/tmp/.X11-unix --privileged -v /home/i2auto:/home/i2auto -v /var/www/html:/home/result"

if [ $1 == "it" ]; then
    echo "RUNNING docker run -it $dockerOptions -e DISPLAY=$VNC_DISPLAY --name $dockerName i2auto:autobase /bin/bash"
    docker run -it $dockerOptions -e DISPLAY=$VNC_DISPLAY --name $dockerName i2auto:autobase /bin/bash
    vncserver -kill $VNC_DISPLAY
    exit 0
fi
if [ -n $WORKDIR ]; then
    dockerOptions="$dockerOptions -v $WORKDIR:/home/package"
fi
if [ $# -eq 2 ]; then
    echo "$(date +%Y-%m-%d) $(date +%H:%M:%S) RUNNING: docker run -d $dockerOptions -e DISPLAY=$VNC_DISPLAY -e TEST_SUITE=$1 -e TEST_DATA=$2 --name $dockerName i2auto:autobase /bin/bash -c '/home/i2auto/script/uirunner.sh'"
    docker run -d $dockerOptions -e DISPLAY=$VNC_DISPLAY -e TEST_SUITE=$1 -e TEST_DATA=$2 --name $dockerName i2auto:autobase /bin/bash -c '/home/i2auto/script/uirunner.sh'
fi
if [ $# -eq 3 ]; then
    echo "$(date +%Y-%m-%d) $(date +%H:%M:%S) RUNNING: docker run -d $dockerOptions -e DISPLAY=$VNC_DISPLAY -e TEST_SUITE=$1 -e TEST_DATA=$2 -e BRANCH=$3 --name $dockerName i2auto:autobase /bin/bash -c '/home/i2auto/script/uirunner.sh'"
    docker run -d $dockerOptions -e DISPLAY=$VNC_DISPLAY -e TEST_SUITE=$1 -e TEST_DATA=$2 -e BRANCH=$3 --name $dockerName i2auto:autobase /bin/bash -c '/home/i2auto/script/uirunner.sh'
fi

timeOut=36000
interval=30
time=0
echo "docker ps --filter status=exited --filter name=$dockerName|grep $dockerName"
docker ps --filter status=exited --filter name=$dockerName|grep $dockerName
while [ $? -ne 0 -a $time -le $timeOut ]
do
    let time+=$interval
    sleep $interval
    echo "$(date +%Y-%m-%d) $(date +%H:%M:%S) RUNNING: docker ps --filter status=exited --filter name=$dockerName|grep $dockerName"
    docker ps --filter status=exited --filter name=$dockerName|grep $dockerName
done
if [ $time -ge $timeOut ]; then
    #########sleep 30 to wait docker logs flush#########
    sleep 30
    echo "$(date +%Y-%m-%d) $(date +%H:%M:%S) docker has not been completed in $timeOut seconds"
    docker logs --tail 50 $dockerName
else
    sleep 10
    echo "$(date +%Y-%m-%d) $(date +%H:%M:%S) docker has been completed in $timeOut seconds"
    docker logs --tail 50 $dockerName
    #docker rm -f $dockerName
fi
sleep 10
echo "$(date +%Y-%m-%d) $(date +%H:%M:%S) RUNNING: vncserver -kill $VNC_DISPLAY"
vncserver -kill $VNC_DISPLAY


```

## setupWinAutoResource.bat

```sh
xcopy x:\dttJob%1\auto\*.* D:\auto /s /e /c /y /h /r
xcopy z:\resources\FileOpr\*.* D:\auto\resources\FileOpr /s /e /c /y /h /r
net use g: \\10.1.0.9\testData
```

## setupTestServer.sh

```sh
#!/bin/bash

nasMountDir="/home/i2auto"
dttHomeDir="$codeMountDir/dttJob$1/auto"


    isMounted=0
    echo "ls $dttHomeDir"
    ls $dttHomeDir
    while [ $? -ne 0 ]
    do
        echo "ls $nasMountDir"
        ls $nasMountDir
        if [ $? -ne 0 ]; then
            echo "mkdir -p $nasMountDir"
            mkdir -p $nasMountDir
        fi
        if [ $isMounted -eq 0 ];then
            echo "mount -t nfs 172.20.64.100:/nfs/auto_package $nasMountDir"
            mount -t nfs 172.20.64.100:/nfs/auto_package $nasMountDir
            isMounted=1
        fi
        echo "wait 10s....."
        sleep 10
        echo "ls $dttHomeDir"
        ls $dttHomeDir
    done

isMounted=0
rootDisk=/dev/sdb
if [ -e $rootDisk ];then
    echo "/dev/sdb is existed"
    echo "df|grep sdb"
    df|grep sdb
    if [ $? -ne 0 ];then
        echo "mount $rootDisk /root"
        mount $rootDisk /root
    fi
fi

```

## setupRacSharedDisk.sh

```sh
#!/bin/bash

lsblk
systemctl enable target
systemctl restart target

echo "n
p
1

62916608
n
p
2

125833216
n
p
3


w
" | fdisk /dev/sdc
lsblk
partprobe /dev/sdc1
partprobe /dev/sdc2
partprobe /dev/sdc3
#####dd if=/dev/zero of=/dev/sdc1 bs=4M count=7600
#####dd if=/dev/zero of=/dev/sdc2 bs=4M count=7600
#####dd if=/dev/zero of=/dev/sdc3 bs=4M count=7600

targetcli /backstores/block create serversdc1 /dev/sdc1
targetcli /backstores/block create serversdc2 /dev/sdc2
targetcli /backstores/block create serversdc3 /dev/sdc3
targetcli /backstores/block create serversdd /dev/sdd
targetcli /backstores/block create serversde /dev/sde
targetcli /iscsi create iqn.2020-07.info2soft.com:racasm
targetcli /iscsi/iqn.2020-07.info2soft.com:racasm/tpg1/acls create iqn.2020-07.info2soft.com:rac1
targetcli /iscsi/iqn.2020-07.info2soft.com:racasm/tpg1/acls create iqn.2020-07.info2soft.com:rac2
targetcli /iscsi/iqn.2020-07.info2soft.com:racasm/tpg1/luns create /backstores/block/serversdc1
targetcli /iscsi/iqn.2020-07.info2soft.com:racasm/tpg1/luns create /backstores/block/serversdc2
targetcli /iscsi/iqn.2020-07.info2soft.com:racasm/tpg1/luns create /backstores/block/serversdc3
targetcli /iscsi/iqn.2020-07.info2soft.com:racasm/tpg1/luns create /backstores/block/serversdd
targetcli /iscsi/iqn.2020-07.info2soft.com:racasm/tpg1/luns create /backstores/block/serversde
targetcli /iscsi/iqn.2020-07.info2soft.com:racasm/tpg1/portals delete 0.0.0.0 3260
targetcli /iscsi/iqn.2020-07.info2soft.com:racasm/tpg1/portals create $1
targetcli /iscsi/iqn.2020-07.info2soft.com:racasm/tpg1/portals create $2
targetcli /iscsi/iqn.2020-07.info2soft.com:racasm/tpg1/portals create $3
if [ $# == 5 ];then
    targetcli /iscsi/iqn.2020-07.info2soft.com:racasm/tpg1/portals create $4
    targetcli /iscsi/iqn.2020-07.info2soft.com:racasm/tpg1/portals create $5
fi
targetcli / saveconfig
cat /etc/target/saveconfig.json

systemctl status target

#############  config dns  ##################
##yum -y install bind

reverseRuleIp="70.20.172"
if ifconfig|grep 172.20.68 ;then
    reverseRuleIp="68.20.172"
fi

sed -i 's/127.0.0.1/any/g' /etc/named.conf
sed -i 's/localhost/any/g' /etc/named.conf

echo "
zone \"info2soft.dtt\" IN {
         type master;
         file \"info2soft.dtt.zone\";
         allow-update { none; };
};

zone \"${reverseRuleIp}.in-addr.arpa\" IN {
          type master;
          file \"info2soft.dtt.local\";
          allow-update { none; };
};
" >> /etc/named.rfc1912.zones

cd /var/named;cp -fpr named.empty info2soft.dtt.zone;cp -fpr named.empty info2soft.dtt.local

echo "
SCANIPHOSTBIT   PTR scan-ip.info2soft.dtt
" >> /var/named/info2soft.dtt.local

echo "
scan-ip A SCANIP
" >> /var/named/info2soft.dtt.zone
exit 0
```

## setupRacNodeEnv.sh

```sh
#!/bin/bash

asmServer=$1
rac1Ip=$2
rac2Ip=$3
privateIps=$4
publicIps=$5
rac1HostName=$6
rac2HostName=$7
nodeNumber=$8
dbVersion=$9

echo $dbVersion
array=(${dbVersion//./ })
dbVersion=${array[0]}
echo $dbVersion

if [ $dbVersion = '10' ]; then
    yum -y install ld-linux.so.2
fi

g_home="/u01/app/$dbVersion/grid_1"
echo $g_home

systemctl disable target
systemctl stop target

####################### prepare private ip,vip, scan ip, network setting###############################
privateIpArray=(${privateIps//,/ })
publicIpArray=(${publicIps//,/ })
publicNetCardName="ens160"
privateNetCardName="ens192"
netCfgHome="/etc/sysconfig/network-scripts"
publicNetCfgFile="$netCfgHome/ifcfg-${publicNetCardName}"
privateNetCfgFile="$netCfgHome/ifcfg-${privateNetCardName}"
cp $publicNetCfgFile $privateNetCfgFile
sed -i "s/DNS1.*/DNS1=172.20.64.9\nDNS2=114.114.114.144/g" $publicNetCfgFile
sed -i "s|NAME.*|NAME=$privateNetCardName|g" $privateNetCfgFile
sed -i "s|DEVICE.*|DEVICE=$privateNetCardName|g" $privateNetCfgFile
sed -i "s|GATEWAY.*|GATEWAY=10.1.0.1|g" $privateNetCfgFile
sed -i "s|NETMASK.*|NETMASK=255.255.0.0|g" $privateNetCfgFile
sed -i "s|IPV6INIT.*|IPV6INIT=no|g" $privateNetCfgFile
sed -i "s|IPV6_AUTOCONF.*|IPV6_AUTOCONF=no|g" $privateNetCfgFile
sed -i "/^DNS1/d" $privateNetCfgFile
sed -i "/^PEERDNS/d" $privateNetCfgFile

if [ $nodeNumber -eq 2 ]; then
    macAddress=`ip addr|grep ${privateNetCardName} -A 1|grep ether|awk '{print $2}'`
    sed -i "s|HWADDR.*|HWADDR=$macAddress|g" $privateNetCfgFile
    sed -i "s|IPADDR.*|IPADDR=${privateIpArray[1]}|g" $privateNetCfgFile

    racHostName=$rac2HostName
    echo "$rac1Ip  ${rac1HostName}.info2soft.com  ${rac1HostName}
${privateIpArray[0]}  rac1-priv
${privateIpArray[1]}  rac2-priv
${publicIpArray[0]}  rac1-vip
${publicIpArray[1]}  rac2-vip
${publicIpArray[2]}  scan-ip
" >> /etc/hosts
    
else
    macAddress=`ip addr|grep ${privateNetCardName} -A 1|grep ether|awk '{print $2}'`
    sed -i "s|HWADDR.*|HWADDR=$macAddress|g" $privateNetCfgFile
    sed -i "s|IPADDR.*|IPADDR=${privateIpArray[0]}|g" $privateNetCfgFile  
    
    racHostName=$rac1HostName
    echo "$rac2Ip  ${rac2HostName}.info2soft.com  ${rac2HostName}
${privateIpArray[0]}  rac1-priv
${privateIpArray[1]}  rac2-priv
${publicIpArray[0]}  rac1-vip
${publicIpArray[1]}  rac2-vip
${publicIpArray[2]}  scan-ip
" >> /etc/hosts

fi
service network restart
echo "search info2soft.dtt" >> /etc/resolv.conf


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
sed -i "/swap/d" /etc/fstab
echo "/dev/sdc1 swap swap defaults 0 0
tmpfs /dev/shm tmpfs defaults,size=4096M 0 0" >> /etc/fstab
mount -o remount /dev/shm


####################### prepare related system account ###############################
groupadd -g 1000 oinstall
groupadd -g 1020 asmadmin
groupadd -g 1021 asmdba
groupadd -g 1022 asmoper
groupadd -g 1031 dba
groupadd -g 1032 oper
useradd -u 1100 -g oinstall -G asmadmin,asmdba,asmoper,dba,oper grid
useradd -u 1101 -g oinstall -G dba,asmdba,oper oracle
echo Welcome1|passwd --stdin grid
echo Welcome1|passwd --stdin oracle


####################### prepare asm disk ###############################
sed -i "s/InitiatorName=.*/InitiatorName=iqn.2020-07.info2soft.com:rac$nodeNumber/g" /etc/iscsi/initiatorname.iscsi
systemctl restart iscsi
systemctl status iscsi
iscsiadm -m discovery -t st -p $asmServer
iscsiadm -m node -T iqn.2020-07.info2soft.com:racasm -p $asmServer:3260 -l
lsscsi -ds
if [ $dbVersion = '10' ]; then
    echo "
KERNEL==\"sd*\", SUBSYSTEM==\"block\", PROGRAM==\"/usr/lib/udev/scsi_id --whitelisted --replace-whitespace --device=/dev/\$name\", RESULT==\"$(/usr/lib/udev/scsi_id -g -u -d /dev/sde)\", SYMLINK+=\"asmdisk/DATADISK01\", OWNER=\"oracle\", GROUP=\"dba\", MODE=\"0660\"
KERNEL==\"sd*\", SUBSYSTEM==\"block\", PROGRAM==\"/usr/lib/udev/scsi_id --whitelisted --replace-whitespace --device=/dev/\$name\", RESULT==\"$(/usr/lib/udev/scsi_id -g -u -d /dev/sdi)\", SYMLINK+=\"asmdisk/DATADISK02\", OWNER=\"oracle\", GROUP=\"dba\", MODE=\"0660\"
KERNEL==\"sd*\", SUBSYSTEM==\"block\", PROGRAM==\"/usr/lib/udev/scsi_id --whitelisted --replace-whitespace --device=/dev/\$name\", RESULT==\"$(/usr/lib/udev/scsi_id -g -u -d /dev/sdh)\", SYMLINK+=\"asmdisk/DATADISK03\", OWNER=\"oracle\", GROUP=\"dba\", MODE=\"0660\"
KERNEL==\"sd*\", SUBSYSTEM==\"block\", PROGRAM==\"/usr/lib/udev/scsi_id --whitelisted --replace-whitespace --device=/dev/\$name\", RESULT==\"$(/usr/lib/udev/scsi_id -g -u -d /dev/sdg)\", SYMLINK+=\"asmdisk/OCRDISK01\", OWNER=\"oracle\", GROUP=\"dba\", MODE=\"0660\"
KERNEL==\"sd*\", SUBSYSTEM==\"block\", PROGRAM==\"/usr/lib/udev/scsi_id --whitelisted --replace-whitespace --device=/dev/\$name\", RESULT==\"$(/usr/lib/udev/scsi_id -g -u -d /dev/sdf)\", SYMLINK+=\"asmdisk/OCRDISK02\", OWNER=\"oracle\", GROUP=\"dba\", MODE=\"0660\"
    ">> /etc/udev/rules.d/99-oracle-asmdevices.rules
else
    echo "
KERNEL==\"sd*\", SUBSYSTEM==\"block\", PROGRAM==\"/usr/lib/udev/scsi_id --whitelisted --replace-whitespace --device=/dev/\$name\", RESULT==\"$(/usr/lib/udev/scsi_id -g -u -d /dev/sde)\", SYMLINK+=\"asmdisk/DATADISK01\", OWNER=\"grid\", GROUP=\"asmadmin\", MODE=\"0660\"
KERNEL==\"sd*\", SUBSYSTEM==\"block\", PROGRAM==\"/usr/lib/udev/scsi_id --whitelisted --replace-whitespace --device=/dev/\$name\", RESULT==\"$(/usr/lib/udev/scsi_id -g -u -d /dev/sdi)\", SYMLINK+=\"asmdisk/DATADISK02\", OWNER=\"grid\", GROUP=\"asmadmin\", MODE=\"0660\"
KERNEL==\"sd*\", SUBSYSTEM==\"block\", PROGRAM==\"/usr/lib/udev/scsi_id --whitelisted --replace-whitespace --device=/dev/\$name\", RESULT==\"$(/usr/lib/udev/scsi_id -g -u -d /dev/sdh)\", SYMLINK+=\"asmdisk/DATADISK03\", OWNER=\"grid\", GROUP=\"asmadmin\", MODE=\"0660\"
KERNEL==\"sd*\", SUBSYSTEM==\"block\", PROGRAM==\"/usr/lib/udev/scsi_id --whitelisted --replace-whitespace --device=/dev/\$name\", RESULT==\"$(/usr/lib/udev/scsi_id -g -u -d /dev/sdg)\", SYMLINK+=\"asmdisk/OCRDISK01\", OWNER=\"grid\", GROUP=\"asmadmin\", MODE=\"0660\"
KERNEL==\"sd*\", SUBSYSTEM==\"block\", PROGRAM==\"/usr/lib/udev/scsi_id --whitelisted --replace-whitespace --device=/dev/\$name\", RESULT==\"$(/usr/lib/udev/scsi_id -g -u -d /dev/sdf)\", SYMLINK+=\"asmdisk/OCRDISK02\", OWNER=\"grid\", GROUP=\"asmadmin\", MODE=\"0660\"
    ">> /etc/udev/rules.d/99-oracle-asmdevices.rules
fi
/sbin/udevadm control --reload-rules
/sbin/udevadm trigger --type=devices --action=change

count=`ls /dev/asmdisk/ | wc -w`
until [ $count -eq 5 ]
do
    /sbin/udevadm control --reload-rules
    /sbin/udevadm trigger --type=devices --action=change
    count=`ls /dev/asmdisk/ | wc -w`
done
echo $count

####################### prepare ssh keys ###############################
chown -R oracle:oinstall /home/oracle/
su - grid -c "ssh-keygen -t rsa -f ~/.ssh/id_rsa -N '';ssh-keygen -t dsa -f ~/.ssh/id_dsa -N '';cat ~/.ssh/*.pub >> ~/.ssh/authorized_keys"
su - oracle -c "ssh-keygen -t rsa -f ~/.ssh/id_rsa -N '';ssh-keygen -t dsa -f ~/.ssh/id_dsa -N '';cat ~/.ssh/*.pub >> ~/.ssh/authorized_keys"


####################### prepare installation layer and related files ###############################
mkfs.xfs /dev/sdd
mkdir /u01
mount /dev/sdd /u01
mkdir -p /u01/app/grid
mkdir -p /u01/app/oracle
mkdir -p /u01/app/oracle/dbf
mkdir -p $g_home
if [[ $dbVersion = '18' || $dbVersion = '19' ]]; then
    mkdir -p /u01/app/oracle/product/$dbVersion/db
fi

if [ $dbVersion = '10' ]; then
    mkdir -p /u01/app/oracle/product/$dbVersion/db
    mkdir -p /u01/app/oracle/product/$dbVersion/crs
fi

echo "#!/usr/bin/expect

set timeout 60
set HOST   [lindex \$argv 0]
spawn ssh \$HOST date
expect {
\"yes/no\" { send \"yes\\r\";exp_continue }
}
expect eof
">> /u01/sshdate

echo "#!/bin/bash

/u01/sshdate $rac1HostName
/u01/sshdate $rac2HostName
/u01/sshdate rac1-priv
/u01/sshdate rac2-priv
">> /u01/validSsh.sh

chmod -R 775 /u01
chown -R grid:oinstall /u01
chown -R oracle:oinstall /u01/app/oracle


####################### adjust related system seting ###############################
echo "
fs.file-max = 6815744
fs.aio-max-nr = 1048576
kernel.sem = 250 32000 100 128
kernel.shmall = 2097152
kernel.shmmax = 6012954215
#kernel.shmmax = 4294967296
#kernel.shmmax  = 536870912
kernel.shmmni = 4096
net.ipv4.ip_local_port_range = 9000 65500
net.core.rmem_default = 262144
net.core.rmem_max = 4194304
net.core.wmem_default = 262144
net.core.wmem_max = 1048576
kernel.panic_on_oops=1
net.ipv4.ipfrag_high_thresh = 16777216
net.ipv4.ipfrag_low_thresh = 15728640
vm.min_free_kbytes= 1048576
">> /etc/sysctl.conf
sysctl -p

echo "
grid soft nofile 65536
grid hard nofile 65536
grid soft nproc 65536
grid hard nproc 65536
grid soft stack 65536
grid hard stack 65536
oracle soft nofile 65536
oracle hard nofile 65536
oracle soft nproc 65536
oracle hard nproc 65536
oracle soft stack 65536
oracle hard stack 65536
">> /etc/security/limits.conf

echo "session required pam_limits.so" >> /etc/pam.d/login

echo "NOZEROCONF=yes" >> /etc/sysconfig/network

echo "
if [ \$USER = "oracle" ] && [ \$USER = "grid" ]; then
   if [ $SHELL = "/bin/ksh" ]; then
       ulimit -p 16384
       ulimit -n 65536
    else
       ulimit -u 16384 -n 65536
   fi
   umask 022
fi
">> /etc/profile


echo "
export GRID_HOME=$g_home
export ORACLE_HOME=/u01/app/oracle/product/$dbVersion/db
export PATH=\$GRID_HOME/bin:\$GRID_HOME/OPatch:/sbin:/bin:/usr/sbin:/usr/bin:$PATH
export LD_LIBRARY_PATH=\$ORACLE_HOME/lib:/lib:/usr/lib
">> /root/.bash_profile
source /root/.bash_profile

if [ $dbVersion = '10' ]; then
    echo "
export TMP=/tmp
export TMPDIR=\$TMP
export ORACLE_HOSTNAME=$racHostName
export ORACLE_UNQNAME=$racHostName
export NLS_LANG=AMERICAN_AMERICA.UTF8
export LANG=en_US.UTF-8
export ORACLE_BASE=/u01/app/oracle
export ORA_CRS_HOME=\$ORACLE_BASE/product/$dbVersion/crs
export ORACLE_HOME=\$ORACLE_BASE/product/$dbVersion/db
export ORACLE_SID=dttrac$nodeNumber
export PATH=/usr/sbin:\$PATH
export PATH=\$ORACLE_HOME/bin:\$ORA_CRS_HOME/bin:\$PATH
export LD_LIBRARY_PATH=\$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=\$ORACLE_HOME/JRE:\$ORACLE_HOME/jlib:\$ORACLE_HOME/rdbms/jlib 
    ">> /home/oracle/.bash_profile
else
    echo "
export TMP=/tmp
export TMPDIR=\$TMP
export ORACLE_HOSTNAME=$racHostName
export ORACLE_UNQNAME=$racHostName
export NLS_LANG=AMERICAN_AMERICA.UTF8
export LANG=en_US.UTF-8
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=\$ORACLE_BASE/product/$dbVersion/db
export ORACLE_SID=dttrac$nodeNumber
export PATH=/usr/sbin:\$PATH
export PATH=\$ORACLE_HOME/bin:\$PATH
export LD_LIBRARY_PATH=\$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=\$ORACLE_HOME/JRE:\$ORACLE_HOME/jlib:\$ORACLE_HOME/rdbms/jlib 
    ">> /home/oracle/.bash_profile
fi
source /home/oracle/.bash_profile

echo "
export TMP=/tmp
export TMPDIR=\$TMP
export ORACLE_HOSTNAME=$racHostName
export ORACLE_BASE=/u01/app/grid
export ORACLE_HOME=$g_home
export ORACLE_SID=+ASM$nodeNumber
export PATH=/usr/sbin:\$PATH
export PATH=\$ORACLE_HOME/bin:\$PATH
export LD_LIBRARY_PATH=\$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=\$ORACLE_HOME/JRE:\$ORACLE_HOME/jlib:\$ORACLE_HOME/rdbms/jlib
">> /home/grid/.bash_profile
source /home/grid/.bash_profile

exit 0

```

## setupOracle19cEnv.sh

```sh
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


####################### prepare related system account and packages ###############################
groupadd oinstall
groupadd dba
groupadd oper
useradd -g oinstall -G dba,oper -d /home/oracle -s /bin/bash -c "Oracle Software Owner" -m oracle

mkfs.xfs /dev/sdd
mkdir /u01
mount /dev/sdd /u01
echo "/dev/sdd /u01 ext4 defaults 0 0" >> /etc/fstab

mkdir -p /u01/app/oracle/product/19/db_1

echo "y
y" | yum install bc gcc gcc-c++ binutils compat-libcap1 compat-libstdc++ dtrace-modules dtrace-modules-headers ace-ctf-devel libX11 libXau libXi libXtst libXrender libXrender-devel libgcc librdmacm-devel libstdc++ libstdc++-devel libxcb make smartmontools sysstat 


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
net.core.wmem_max = 1048576
kernel.panic_on_oops = 1
">> /etc/sysctl.conf
sysctl -p

echo "
oracle soft nproc 2047
oracle hard nproc 16384
oracle soft nofile 1024
oracle hard nofile 65536
oracle soft stack 10240
oracle hard stack 10240
" >> /etc/security/limits.conf

echo "
if [ \$USER = "oracle" ]; then
   if [ $SHELL = "/bin/ksh" ]; then
       ulimit -p 16384
       ulimit -n 65536
    else
       ulimit -u 16384 -n 65536
   fi
   umask 022
fi
">> /etc/profile

echo "
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=/u01/app/oracle/product/19/db_1
export ORACLE_SID=orcl
export NLS_LANG=AMERICAN_AMERICA.UTF8
export LANG=en_US.UTF-8
export TNS_ADMIN=\$ORACLE_HOME/network/admin
export PATH=\$ORACLE_HOME/bin:/usr/bin:/bin:/usr/bin/X11:/usr/local/bin:$PATH
export CLASSPATH=\$ORACLE_HOME/JRE:\$ORACLE_HOME/jlib:\$ORACLE_HOME/rdbms/jlib:\$ORACLE_HOME/network/jlib
export LD_LIBRARY_PATH=\$ORACLE_HOME/lib:\$ORACLE_HOME/oracm/lib:/lib:/usr/lib:/usr/local/lib
export TEMP=/tmp
export TMPDIR=/tmp
umask 000
">> /home/oracle/.bash_profile
source /home/oracle/.bash_profile
chmod -R 755 /home/oracle;chown -R oracle:oinstall /home/oracle/

echo "
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=/u01/app/oracle/product/19/db_1
export ORACLE_SID=orcl
export NLS_LANG=AMERICAN_AMERICA.UTF8
export LANG=en_US.UTF-8
export TNS_ADMIN=\$ORACLE_HOME/network/admin
export PATH=\$ORACLE_HOME/bin:/usr/bin:/bin:/usr/bin/X11:/usr/local/bin:$PATH
export CLASSPATH=\$ORACLE_HOME/JRE:\$ORACLE_HOME/jlib:\$ORACLE_HOME/rdbms/jlib:\$ORACLE_HOME/network/jlib
export LD_LIBRARY_PATH=\$ORACLE_HOME/lib:\$ORACLE_HOME/oracm/lib:/lib:/usr/lib:/usr/local/lib
export TEMP=/tmp
export TMPDIR=/tmp
umask 000
">> /root/.bash_profile
source /root/.bash_profile

useradd -g oinstall -G dba -m renl
mkdir -p /home/renl
cp /root/.bash_profile /home/renl
source /home/renl/.bash_profile

####################### prepare 19c binary and response file ###############################

if [ $dbVersion = '19.3.0.0' ]
then
	unzip $dbSoftPath/19.3.0.0_Linux_x86.64/LINUX.X64_193000_db_home.zip -d /u01/app/oracle/product/19/db_1
fi
cp /u01/app/oracle/product/19/db_1/install/response/db_install.rsp /u01/dbinstall.rsp

sed -i "s|oracle.install.option.*|oracle.install.option=INSTALL_DB_SWONLY|g" /u01/dbinstall.rsp
sed -i "s|UNIX_GROUP_NAME.*|UNIX_GROUP_NAME=oinstall|g" /u01/dbinstall.rsp
sed -i "s|INVENTORY_LOCATION.*|INVENTORY_LOCATION=/u01/app/oraInventory|g" /u01/dbinstall.rsp
sed -i "s|ORACLE_BASE.*|ORACLE_BASE=/u01/app/oracle|g" /u01/dbinstall.rsp
sed -i "s|ORACLE_HOME.*|ORACLE_HOME=/u01/app/oracle/product/19/db_1|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.InstallEdition.*|oracle.install.db.InstallEdition=EE|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.OSDBA_GROUP.*|oracle.install.db.OSDBA_GROUP=dba|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.OSOPER_GROUP.*|oracle.install.db.OSOPER_GROUP=oper|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.OSBACKUPDBA_GROUP.*|oracle.install.db.OSBACKUPDBA_GROUP=dba|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.OSDGDBA_GROUP.*|oracle.install.db.OSDGDBA_GROUP=dba|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.OSKMDBA_GROUP.*|oracle.install.db.OSKMDBA_GROUP=dba|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.OSRACDBA_GROUP.*|oracle.install.db.OSRACDBA_GROUP=dba|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.config.starterdb.type.*|oracle.install.db.config.starterdb.type=GENERAL_PURPOSE|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.config.starterdb.memoryLimit.*|oracle.install.db.config.starterdb.memoryLimit=512|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.config.starterdb.password.ALL.*|oracle.install.db.config.starterdb.password.ALL=Welcome1|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.config.starterdb.storageType.*|oracle.install.db.config.starterdb.storageType=FILE_SYSTEM_STORAGE|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.config.starterdb.fileSystemStorage.dataLocation.*|oracle.install.db.config.starterdb.fileSystemStorage.dataLocation=/u01/app/oracle/oradata|g" /u01/dbinstall.rsp
sed -i "s|SECURITY_UPDATES_VIA_MYORACLESUPPORT.*|SECURITY_UPDATES_VIA_MYORACLESUPPORT=false|g" /u01/dbinstall.rsp
sed -i "s|DECLINE_SECURITY_UPDATES.*|DECLINE_SECURITY_UPDATES=true|g" /u01/dbinstall.rsp

chown -R oracle:oinstall /u01/
chmod 755 -R /u01


####################### setup and configure 19c db ###############################
echo "Trying to install oracle 19c..............."
su - oracle -c "\$ORACLE_HOME/runInstaller -ignorePrereq -force -silent -waitforcompletion -responseFile /u01/dbinstall.rsp"
echo $?
if [ $? -eq 0 ]; then
    echo "db install suc..............."    
    echo "Trying to run scripts..............."
    /u01/app/oraInventory/orainstRoot.sh
    /u01/app/oracle/product/19/db_1/root.sh
    
    echo "Trying to netca................."
    su - oracle -c "netca -silent -responsefile \$ORACLE_HOME/assistants/netca/netca.rsp"
    if [ $? -eq 0 ]; then
    	echo "netca suc................."
    	echo "Trying to dbca..............."
    	if [ $iscdb = 'false' ]; then
    	    su - oracle -c "dbca -createDatabase -templateName General_Purpose.dbc -gdbName orcl -sid orcl \
    	    -sysPassword Welcome1 -systemPassword Welcome1 -dbsnmpPassword Welcome1 \
    	    -emConfiguration LOCAL -datafileJarLocation \$ORACLE_HOME/assistants/dbca/templates \
    	    -storageType FS -datafileDestination /u01/app/oracle/oradata \
    	    -characterset AL32UTF8 -totalMemory 1638 -obfuscatedPasswords false -sampleSchema true -silent"
    	elif [ $iscdb = 'true' ]; then
    	    su - oracle -c "dbca -createDatabase -templateName General_Purpose.dbc -gdbName orcl -sid orcl \
    	    -createAsContainerDatabase true -numberOfPDBs 1 -pdbName orclpdb \
    	    -sysPassword Welcome1 -systemPassword Welcome1 -pdbAdminPassword Welcome1 -dbsnmpPassword Welcome1 \
    	    -emExpressPort 5500 -omsPort 0 -memoryPercentage 40 -automaticMemoryManagement false \
    	    -datafileJarLocation \$ORACLE_HOME/assistants/dbca/templates \
    	    -storageType FS -datafileDestination /u01/app/oracle/oradata \
    	    -characterset AL32UTF8 -listeners LISTENER \
    	    -obfuscatedPasswords false -sampleSchema true -silent"
    	fi
    	if [ $? -eq 0 ]; then
    	    echo "dbca suc....................."
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
```

## setupOracle19cASMEnv.sh

```sh
#!/bin/bash

dbSoftPath=$1
dbVersion=$2
iscdb=$3

echo $dbSoftPath
echo $dbVersion
echo $iscdb

####################### prepare related system account and packages ###############################
groupadd oinstall
groupadd dba
groupadd asmdba
groupadd asmadmin
groupadd asmoper
groupadd oper
groupadd backupdba
groupadd dgdba
groupadd kmdba
useradd -g oinstall -G asmadmin,asmdba,asmoper,oper,dba grid
useradd -g oinstall -G dba,asmdba,oper,backupdba,dgdba,kmdba oracle

mkfs.xfs /dev/sdd
mkdir /u01
mount /dev/sdd /u01
echo "/dev/sdd /u01 ext4 defaults 0 0" >> /etc/fstab

mkdir -p /u01/app/oracle/product/19/db_1
mkdir -p /u01/app/grid/product/19/grid_1
chown -R grid:oinstall /u01
chown -R grid:oinstall /u01/app/grid

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

echo "n



34952988
n



69904156
n



104855324
w" | fdisk /dev/sde

localip=$(cat /etc/sysconfig/network-scripts/ifcfg-ens160 | grep IPADDR | tr -d "IPADDR=")
echo $localip

lsblk
yum -y install targetcli
systemctl enable target
systemctl restart target

targetcli /backstores/block create serversde1 /dev/sde1
targetcli /backstores/block create serversde2 /dev/sde2
targetcli /backstores/block create serversde3 /dev/sde3

targetcli /iscsi create iqn.2020-12.info2soft.com:racasm
targetcli /iscsi/iqn.2020-12.info2soft.com:racasm/tpg1/acls create iqn.2020-12.info2soft.com:rac1

targetcli /iscsi/iqn.2020-12.info2soft.com:racasm/tpg1/luns create /backstores/block/serversde1
targetcli /iscsi/iqn.2020-12.info2soft.com:racasm/tpg1/luns create /backstores/block/serversde2
targetcli /iscsi/iqn.2020-12.info2soft.com:racasm/tpg1/luns create /backstores/block/serversde3

targetcli / saveconfig

sed -i "s/InitiatorName=.*/InitiatorName=iqn.2020-12.info2soft.com:rac1/g" /etc/iscsi/initiatorname.iscsi
systemctl restart iscsi
systemctl status iscsi
iscsiadm -m discovery -t st -p $localip
iscsiadm -m node -T iqn.2020-12.info2soft.com:racasm -p $localip:3260 -l
lsscsi -ds

echo "
KERNEL==\"sd*\", SUBSYSTEM==\"block\", PROGRAM==\"/usr/lib/udev/scsi_id --whitelisted --replace-whitespace --device=/dev/\$name\", RESULT==\"$(/usr/lib/udev/scsi_id -g -u -d /dev/sdf)\", SYMLINK+=\"asmdisk/DATADISK01\", OWNER=\"grid\", GROUP=\"asmadmin\", MODE=\"0660\"
KERNEL==\"sd*\", SUBSYSTEM==\"block\", PROGRAM==\"/usr/lib/udev/scsi_id --whitelisted --replace-whitespace --device=/dev/\$name\", RESULT==\"$(/usr/lib/udev/scsi_id -g -u -d /dev/sdg)\", SYMLINK+=\"asmdisk/DATADISK02\", OWNER=\"grid\", GROUP=\"asmadmin\", MODE=\"0660\"
KERNEL==\"sd*\", SUBSYSTEM==\"block\", PROGRAM==\"/usr/lib/udev/scsi_id --whitelisted --replace-whitespace --device=/dev/\$name\", RESULT==\"$(/usr/lib/udev/scsi_id -g -u -d /dev/sdh)\", SYMLINK+=\"asmdisk/DATADISK03\", OWNER=\"grid\", GROUP=\"asmadmin\", MODE=\"0660\"
">> /etc/udev/rules.d/99-oracle-asmdevices.rules

/sbin/udevadm control --reload-rules
/sbin/udevadm trigger --type=devices --action=change

f1="/dev/asmdisk/DATADISK01"
f2="/dev/asmdisk/DATADISK02"
f3="/dev/asmdisk/DATADISK03"

for var in $f1 $f2 $f3
do
	if [ ! -L "$var" ]
	then
		/sbin/udevadm control --reload-rules
		/sbin/udevadm trigger --type=devices --action=change
	fi
done

str=`ls -lh /dev/sdf`
str=${str//" "/ }
arr=($str)
echo ${arr[2]}
until [ "${arr[2]}" = "grid" ]
do
	/sbin/udevadm control --reload-rules
	/sbin/udevadm trigger --type=devices --action=change
	str=`ls -lh /dev/sdf`
	str=${str//" "/ }
	arr=($str)
done
echo ${arr[2]}


####################### prepare related  packages ##################################
echo "y" | yum install bc gcc gcc-c++ binutils compat-libcap1 compat-libstdc++ dtrace-modules dtrace-modules-headers ace-ctf-devel libX11 libXau libXi libXtst libXrender libXrender-devel libgcc librdmacm-devel libstdc++ libstdc++-devel libxcb make smartmontools sysstat 

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
net.core.wmem_max = 1048576
kernel.panic_on_oops = 1
">> /etc/sysctl.conf
sysctl -p

echo "
oracle soft nproc 16384
oracle hard nproc 16384
oracle soft nofile 1024
oracle hard nofile 65536
oracle  soft  stack  10240
oracle  hard stack  32768
grid   soft   nofile    1024
grid   hard   nofile    65536
grid   soft   nproc    16384
grid   hard   nproc    16384
grid   soft   stack    10240
grid   hard   stack    32768
">> /etc/security/limits.conf

echo "
if [ \$USER = "oracle" ]; then
   if [ $SHELL = "/bin/ksh" ]; then
       ulimit -p 16384
       ulimit -n 65536
    else
       ulimit -u 16384 -n 65536
   fi
   umask 022
fi
">> /etc/profile

echo "
export ORACLE_BASE=/u01/app/grid
export ORACLE_HOME=\$ORACLE_BASE/product/19/grid_1
export ORACLE_SID=+ASM
export NLS_DATE_FORMAT='yyyy-mm-dd hh24:mi:ss'
export TNS_ADMIN=\$ORACLE_HOME/network/admin
export CLASSPATH=\$ORACLE_HOME/JRE:\$ORACLE_HOME/jlib:\$ORACLE_HOME/rdbms/jlib
export PATH=\$ORACLE_HOME/bin:$PATH
export LD_LIBRARY_PATH=\$ORACLE_HOME/lib:\$ORACLE_HOME/oracm/lib:/lib:/usr/lib:/usr/local/lib
export TEMP=/tmp
export TMP=/tmp
export TMPDIR=/tmp
">>/home/grid/.bash_profile
source /home/grid/.bash_profile

echo "
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=/u01/app/oracle/product/19/db_1
export ORACLE_SID=orcl
export NLS_LANG=AMERICAN_AMERICA.UTF8
export LANG=en_US.UTF-8
export NLS_DATE_FORMAT='yyyy-mm-dd hh24:mi:ss'
export TNS_ADMIN=\$ORACLE_HOME/network/admin
export PATH=\$ORACLE_HOME/bin:/usr/bin:/bin:/usr/bin/X11:/usr/local/bin:$PATH
export CLASSPATH=\$ORACLE_HOME/JRE:\$ORACLE_HOME/jlib:\$ORACLE_HOME/rdbms/jlib:\$ORACLE_HOME/network/jlib
export LD_LIBRARY_PATH=\$ORACLE_HOME/lib:\$ORACLE_HOME/oracm/lib:/lib:/usr/lib:/usr/local/lib
export TEMP=/tmp
export TMPDIR=/tmp
umask 000
">> /home/oracle/.bash_profile
source /home/oracle/.bash_profile
chmod -R 755 /home/oracle;chown -R oracle:oinstall /home/oracle/

echo "
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=/u01/app/oracle/product/19/db_1
export ORACLE_SID=orcl
export NLS_LANG=AMERICAN_AMERICA.UTF8
export LANG=en_US.UTF-8
export TNS_ADMIN=\$ORACLE_HOME/network/admin
export PATH=\$ORACLE_HOME/bin:/usr/bin:/bin:/usr/bin/X11:/usr/local/bin:$PATH
export CLASSPATH=\$ORACLE_HOME/JRE:\$ORACLE_HOME/jlib:\$ORACLE_HOME/rdbms/jlib:\$ORACLE_HOME/network/jlib
export LD_LIBRARY_PATH=\$ORACLE_HOME/lib:\$ORACLE_HOME/oracm/lib:/lib:/usr/lib:/usr/local/lib
export TEMP=/tmp
export TMPDIR=/tmp
umask 000
">> /root/.bash_profile
source /root/.bash_profile

useradd -g oinstall -G dba -m renl
mkdir -p /home/renl
cp /root/.bash_profile /home/renl
source /home/renl/.bash_profile

####################### prepare 19c binary and response file ###############################

if [ $dbVersion = '19.3.0.0' ]
then
    unzip $dbSoftPath/19.3.0.0_Linux_x86.64/LINUX.X64_193000_grid_home.zip -d /u01/app/grid/product/19/grid_1
    unzip $dbSoftPath/19.3.0.0_Linux_x86.64/LINUX.X64_193000_db_home.zip -d /u01/app/oracle/product/19/db_1
fi
cp /u01/app/oracle/product/19/db_1/install/response/db_install.rsp /u01/dbinstall.rsp
cp /u01/app/grid/product/19/grid_1/install/response/gridsetup.rsp /u01/grid.rsp

echo "write grid response file.........................."
sed -i "s|ORACLE_HOSTNAME=|ORACLE_HOSTNAME=$(hostname -s)|g" /u01/grid.rsp
sed -i "s|ORACLE_HOME=|ORACLE_HOME=/u01/app/grid/product/19/grid_1|g" /u01/grid.rsp
sed -i "s|INVENTORY_LOCATION.*|INVENTORY_LOCATION=/u01/app/oraInventory|g" /u01/grid.rsp
sed -i "s|oracle.install.option.*|oracle.install.option=HA_CONFIG|g" /u01/grid.rsp
sed -i "s|ORACLE_BASE.*|ORACLE_BASE=/u01/app/grid|g" /u01/grid.rsp
sed -i "s|oracle.install.asm.OSDBA.*|oracle.install.asm.OSDBA=asmdba|g" /u01/grid.rsp
sed -i "s|oracle.install.asm.OSOPER.*|oracle.install.asm.OSOPER=asmoper|g" /u01/grid.rsp
sed -i "s|oracle.install.asm.OSASM.*|oracle.install.asm.OSASM=asmadmin|g" /u01/grid.rsp
sed -i "s|oracle.install.asm.SYSASMPassword.*|oracle.install.asm.SYSASMPassword=Welcome1|g" /u01/grid.rsp
sed -i "s|oracle.install.asm.diskGroup.name.*|oracle.install.asm.diskGroup.name=DATA|g" /u01/grid.rsp
sed -i "s|oracle.install.asm.diskGroup.redundancy.*|oracle.install.asm.diskGroup.redundancy=NORMAL|g" /u01/grid.rsp
sed -i "s|oracle.install.asm.diskGroup.AUSize.*|oracle.install.asm.diskGroup.AUSize=4|g" /u01/grid.rsp
sed -i "s|oracle.install.asm.diskGroup.disks=|oracle.install.asm.diskGroup.disks=/dev/asmdisk/DATADISK01,/dev/asmdisk/DATADISK02,/dev/asmdisk/DATADISK03|g" /u01/grid.rsp
sed -i "s|oracle.install.asm.diskGroup.diskDiscoveryString=|oracle.install.asm.diskGroup.diskDiscoveryString=/dev/asmdisk/|g" /u01/grid.rsp
sed -i "s|oracle.install.asm.monitorPassword.*|oracle.install.asm.monitorPassword=Welcome1|g" /u01/grid.rsp

echo "write db response file.........................."
sed -i "s|oracle.install.option.*|oracle.install.option=INSTALL_DB_SWONLY|g" /u01/dbinstall.rsp
sed -i "s|UNIX_GROUP_NAME.*|UNIX_GROUP_NAME=oinstall|g" /u01/dbinstall.rsp
sed -i "s|INVENTORY_LOCATION.*|INVENTORY_LOCATION=/u01/app/oraInventory|g" /u01/dbinstall.rsp
sed -i "s|ORACLE_BASE.*|ORACLE_BASE=/u01/app/oracle|g" /u01/dbinstall.rsp
sed -i "s|ORACLE_HOME.*|ORACLE_HOME=/u01/app/oracle/product/19/db_1|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.InstallEdition.*|oracle.install.db.InstallEdition=EE|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.OSDBA_GROUP.*|oracle.install.db.OSDBA_GROUP=dba|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.OSOPER_GROUP.*|oracle.install.db.OSOPER_GROUP=oper|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.OSBACKUPDBA_GROUP.*|oracle.install.db.OSBACKUPDBA_GROUP=backupdba|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.OSDGDBA_GROUP.*|oracle.install.db.OSDGDBA_GROUP=dgdba|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.OSKMDBA_GROUP.*|oracle.install.db.OSKMDBA_GROUP=kmdba|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.OSRACDBA_GROUP.*|oracle.install.db.OSRACDBA_GROUP=dba|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.config.starterdb.type.*|oracle.install.db.config.starterdb.type=GENERAL_PURPOSE|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.config.starterdb.memoryLimit.*|oracle.install.db.config.starterdb.memoryLimit=512|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.config.starterdb.password.ALL.*|oracle.install.db.config.starterdb.password.ALL=Welcome1|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.config.starterdb.storageType.*|oracle.install.db.config.starterdb.storageType=FILE_SYSTEM_STORAGE|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.config.starterdb.fileSystemStorage.dataLocation.*|oracle.install.db.config.starterdb.fileSystemStorage.dataLocation=$oracleData|g" /u01/dbinstall.rsp
sed -i "s|SECURITY_UPDATES_VIA_MYORACLESUPPORT.*|SECURITY_UPDATES_VIA_MYORACLESUPPORT=false|g" /u01/dbinstall.rsp
sed -i "s|DECLINE_SECURITY_UPDATES.*|DECLINE_SECURITY_UPDATES=true|g" /u01/dbinstall.rsp

chown -R grid:oinstall /u01
chown -R grid:oinstall /u01/app/grid
chown -R oracle:oinstall /u01/app/oracle
chmod -R 775 /u01/


####################### setup and configure 19c db ###############################
su - grid -c "yes | \$ORACLE_HOME/gridSetup.sh -silent -responseFile /u01/grid.rsp"
echo $?
if [ $? -eq 0 ]; then
    echo "Execute Configuration Scripts............................."
    /u01/app/oraInventory/orainstRoot.sh
    /u01/app/grid/product/19/grid_1/root.sh
    su - grid -c "/u01/app/grid/product/19/grid_1/gridSetup.sh -executeConfigTools -responseFile /u01/grid.rsp -silent"
    echo "grid install suc ........................."
    echo "db install start..........................."
    
    su - oracle -c "\$ORACLE_HOME/runInstaller -ignorePrereq -force -silent -waitforcompletion -responseFile /u01/dbinstall.rsp"
    echo $?
    if [ $? -eq 0 ]; then
	    echo "db install suc..............."    
	    echo "Trying to run scripts..............."
	    /u01/app/oracle/product/19/db_1/root.sh
	    echo "Trying to netca................."
	    su - oracle -c "netca -silent -responsefile \$ORACLE_HOME/assistants/netca/netca.rsp"
	    if [ $? -eq 0 ]; then
	        echo "netca suc................."
	        echo "Trying to dbca..............."
	        if [ $iscdb = 'false' ]; then
	            su - oracle -c "dbca -createDatabase -templateName General_Purpose.dbc -gdbName orcl -sid orcl \
	            -sysPassword Welcome1 -systemPassword Welcome1 -dbsnmpPassword Welcome1 -asmsnmpPassword Welcome1 \
	            -datafileJarLocation \$ORACLE_HOME/assistants/dbca/templates \
	            -storageType ASM -datafileDestination DATA/ -diskGroupName DATA \
	            -characterset AL32UTF8 -nationalCharacterSet UTF8 -memoryPercentage 40 -silent"
	        elif [ $iscdb = 'true' ]; then
	            su - oracle -c "dbca -createDatabase -templateName General_Purpose.dbc -gdbName orcl -sid orcl \
	            -createAsContainerDatabase true -numberOfPDBs 1 -pdbName orclpdb \
	            -sysPassword Welcome1 -systemPassword Welcome1 -pdbAdminPassword Welcome1 -dbsnmpPassword Welcome1 \
	            -emExpressPort 5500 -omsPort 0 -memoryPercentage 40 -automaticMemoryManagement false \
	            -datafileJarLocation \$ORACLE_HOME/assistants/dbca/templates \
	            -storageType ASM -datafileDestination DATA/ -diskGroupName DATA \
	            -characterset AL32UTF8 -obfuscatedPasswords false -sampleSchema true -silent"
	        fi
	        if [ $? -eq 0 ]; then
	            echo "dbca suc....................."
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
else
    echo grid installation with failure
    exit 1
fi
```

## setupOracle18cEnv.sh

```sh
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


####################### prepare related system account and packages ###############################
groupadd oinstall
groupadd dba
groupadd oper
useradd -g oinstall -G dba,oper -d /home/oracle -s /bin/bash -c "Oracle Software Owner" -m oracle

mkfs.xfs /dev/sdd
mkdir /u01
mount /dev/sdd /u01
echo "/dev/sdd /u01 ext4 defaults 0 0" >> /etc/fstab

mkdir -p /u01/app/oracle/product/18/db_1

#yum -y install binutils compat-libcap1 compat-libstdc++-33 compat-libstdc++-33*.i686 elfutils-libelf-devel gcc gcc-c++ glibc*.i686 glibc glibc-devel glibc-devel*.i686 ksh libgcc*.i686 libgcc libstdc++ libstdc++*.i686 libstdc++-devel libstdc++-devel*.i686 libaio libaio*.i686 libaio-devel libaio-devel*.i686 make sysstat unixODBC unixODBC*.i686 unixODBC-devel unixODBC-devel*.i686 libXp

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
net.core.wmem_max = 1048576
kernel.panic_on_oops = 1
">> /etc/sysctl.conf
sysctl -p

echo "
oracle soft nproc 2047
oracle hard nproc 16384
oracle soft nofile 1024
oracle hard nofile 65536
oracle soft stack 10240
oracle hard stack 10240
" >> /etc/security/limits.conf

echo "
if [ \$USER = "oracle" ]; then
   if [ $SHELL = "/bin/ksh" ]; then
       ulimit -p 16384
       ulimit -n 65536
    else
       ulimit -u 16384 -n 65536
   fi
   umask 022
fi
">> /etc/profile

echo "
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=/u01/app/oracle/product/18/db_1
export ORACLE_SID=orcl
export NLS_LANG=AMERICAN_AMERICA.UTF8
export LANG=en_US.UTF-8
export TNS_ADMIN=\$ORACLE_HOME/network/admin
export PATH=\$ORACLE_HOME/bin:/usr/bin:/bin:/usr/bin/X11:/usr/local/bin:$PATH
export CLASSPATH=\$ORACLE_HOME/JRE:\$ORACLE_HOME/jlib:\$ORACLE_HOME/rdbms/jlib:\$ORACLE_HOME/network/jlib
export LD_LIBRARY_PATH=\$ORACLE_HOME/lib:\$ORACLE_HOME/oracm/lib:/lib:/usr/lib:/usr/local/lib
export TEMP=/tmp
export TMPDIR=/tmp
umask 000
">> /home/oracle/.bash_profile
source /home/oracle/.bash_profile
chmod -R 755 /home/oracle;chown -R oracle:oinstall /home/oracle/

echo "
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=/u01/app/oracle/product/18/db_1
export ORACLE_SID=orcl
export NLS_LANG=AMERICAN_AMERICA.UTF8
export LANG=en_US.UTF-8
export TNS_ADMIN=\$ORACLE_HOME/network/admin
export PATH=\$ORACLE_HOME/bin:/usr/bin:/bin:/usr/bin/X11:/usr/local/bin:$PATH
export CLASSPATH=\$ORACLE_HOME/JRE:\$ORACLE_HOME/jlib:\$ORACLE_HOME/rdbms/jlib:\$ORACLE_HOME/network/jlib
export LD_LIBRARY_PATH=\$ORACLE_HOME/lib:\$ORACLE_HOME/oracm/lib:/lib:/usr/lib:/usr/local/lib
export TEMP=/tmp
export TMPDIR=/tmp
umask 000
">> /root/.bash_profile
source /root/.bash_profile

useradd -g oinstall -G dba -m renl
mkdir -p /home/renl
cp /root/.bash_profile /home/renl
source /home/renl/.bash_profile

####################### prepare 18c binary and response file ###############################

if [ $dbVersion = '18.3.0.0' ]
then
    unzip $dbSoftPath/18.3/LINUX.X64_180000_db_home.zip -d /u01/app/oracle/product/18/db_1
fi
cp /u01/app/oracle/product/18/db_1/install/response/db_install.rsp /u01/dbinstall.rsp

sed -i "s|oracle.install.option.*|oracle.install.option=INSTALL_DB_SWONLY|g" /u01/dbinstall.rsp
sed -i "s|UNIX_GROUP_NAME.*|UNIX_GROUP_NAME=oinstall|g" /u01/dbinstall.rsp
sed -i "s|INVENTORY_LOCATION.*|INVENTORY_LOCATION=/u01/app/oraInventory|g" /u01/dbinstall.rsp
sed -i "s|ORACLE_BASE.*|ORACLE_BASE=/u01/app/oracle|g" /u01/dbinstall.rsp
sed -i "s|ORACLE_HOME.*|ORACLE_HOME=/u01/app/oracle/product/18/db_1|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.InstallEdition.*|oracle.install.db.InstallEdition=EE|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.OSDBA_GROUP.*|oracle.install.db.OSDBA_GROUP=dba|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.OSOPER_GROUP.*|oracle.install.db.OSOPER_GROUP=oper|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.OSBACKUPDBA_GROUP.*|oracle.install.db.OSBACKUPDBA_GROUP=dba|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.OSDGDBA_GROUP.*|oracle.install.db.OSDGDBA_GROUP=dba|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.OSKMDBA_GROUP.*|oracle.install.db.OSKMDBA_GROUP=dba|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.OSRACDBA_GROUP.*|oracle.install.db.OSRACDBA_GROUP=dba|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.config.starterdb.type.*|oracle.install.db.config.starterdb.type=GENERAL_PURPOSE|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.config.starterdb.memoryLimit.*|oracle.install.db.config.starterdb.memoryLimit=512|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.config.starterdb.password.ALL.*|oracle.install.db.config.starterdb.password.ALL=Welcome1|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.config.starterdb.storageType.*|oracle.install.db.config.starterdb.storageType=FILE_SYSTEM_STORAGE|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.config.starterdb.fileSystemStorage.dataLocation.*|oracle.install.db.config.starterdb.fileSystemStorage.dataLocation=/u01/app/oracle/oradata|g" /u01/dbinstall.rsp
sed -i "s|SECURITY_UPDATES_VIA_MYORACLESUPPORT.*|SECURITY_UPDATES_VIA_MYORACLESUPPORT=false|g" /u01/dbinstall.rsp
sed -i "s|DECLINE_SECURITY_UPDATES.*|DECLINE_SECURITY_UPDATES=true|g" /u01/dbinstall.rsp

chown -R oracle:oinstall /u01/
chmod 755 -R /u01


####################### setup and configure 18c db ###############################
echo "Trying to install oracle 18c..............."
su - oracle -c "\$ORACLE_HOME/runInstaller -ignorePrereq -force -silent -waitforcompletion -responseFile /u01/dbinstall.rsp"
echo $?
if [ $? -eq 0 ]; then
    echo "db install suc..............."    
    echo "Trying to run scripts..............."
    /u01/app/oraInventory/orainstRoot.sh
    /u01/app/oracle/product/18/db_1/root.sh
    
    echo "Trying to netca................."
    su - oracle -c "netca -silent -responsefile \$ORACLE_HOME/assistants/netca/netca.rsp"
    if [ $? -eq 0 ]; then
    	echo "netca suc................."
    	echo "Trying to dbca..............."
    	if [ $iscdb = 'false' ]; then
    	    su - oracle -c "dbca -createDatabase -templateName General_Purpose.dbc -gdbName orcl -sid orcl \
    	    -sysPassword Welcome1 -systemPassword Welcome1 -dbsnmpPassword Welcome1 \
    	    -emConfiguration LOCAL -datafileJarLocation \$ORACLE_HOME/assistants/dbca/templates \
    	    -storageType FS -datafileDestination /u01/app/oracle/oradata \
    	    -characterset AL32UTF8 -totalMemory 1638 -obfuscatedPasswords false -sampleSchema true -silent"
    	elif [ $iscdb = 'true' ]; then
    	    su - oracle -c "dbca -createDatabase -templateName General_Purpose.dbc -gdbName orcl -sid orcl \
    	    -createAsContainerDatabase true -numberOfPDBs 1 -pdbName orclpdb \
    	    -sysPassword Welcome1 -systemPassword Welcome1 -pdbAdminPassword Welcome1 -dbsnmpPassword Welcome1 \
    	    -emExpressPort 5500 -omsPort 0 -memoryPercentage 40 -automaticMemoryManagement false \
    	    -datafileJarLocation \$ORACLE_HOME/assistants/dbca/templates \
    	    -storageType FS -datafileDestination /u01/app/oracle/oradata \
    	    -characterset AL32UTF8 -listeners LISTENER \
    	    -obfuscatedPasswords false -sampleSchema true -silent"
    	fi
    	if [ $? -eq 0 ]; then
    	    echo "dbca suc....................."
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
```

## setupOracle18cASMEnv.sh

```sh
#!/bin/bash

dbSoftPath=$1
dbVersion=$2
iscdb=$3

echo $dbSoftPath
echo $dbVersion
echo $iscdb

####################### prepare related system account and packages ###############################
groupadd oinstall
groupadd dba
groupadd asmdba
groupadd asmadmin
groupadd asmoper
groupadd oper
groupadd backupdba
groupadd dgdba
groupadd kmdba
useradd -g oinstall -G asmadmin,asmdba,asmoper,oper,dba grid
useradd -g oinstall -G dba,asmdba,oper,backupdba,dgdba,kmdba oracle

mkfs.xfs /dev/sdd
mkdir /u01
mount /dev/sdd /u01
echo "/dev/sdd /u01 ext4 defaults 0 0" >> /etc/fstab

mkdir -p /u01/app/oracle/product/18/db_1
mkdir -p /u01/app/grid/product/18/grid_1
chown -R grid:oinstall /u01
chown -R grid:oinstall /u01/app/grid

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

echo "n



34952988
n



69904156
n



104855324
w" | fdisk /dev/sde

localip=$(cat /etc/sysconfig/network-scripts/ifcfg-ens160 | grep IPADDR | tr -d "IPADDR=")
echo $localip

lsblk
yum -y install targetcli
systemctl enable target
systemctl restart target

targetcli /backstores/block create serversde1 /dev/sde1
targetcli /backstores/block create serversde2 /dev/sde2
targetcli /backstores/block create serversde3 /dev/sde3

targetcli /iscsi create iqn.2020-12.info2soft.com:racasm
targetcli /iscsi/iqn.2020-12.info2soft.com:racasm/tpg1/acls create iqn.2020-12.info2soft.com:rac1

targetcli /iscsi/iqn.2020-12.info2soft.com:racasm/tpg1/luns create /backstores/block/serversde1
targetcli /iscsi/iqn.2020-12.info2soft.com:racasm/tpg1/luns create /backstores/block/serversde2
targetcli /iscsi/iqn.2020-12.info2soft.com:racasm/tpg1/luns create /backstores/block/serversde3

targetcli / saveconfig

sed -i "s/InitiatorName=.*/InitiatorName=iqn.2020-12.info2soft.com:rac1/g" /etc/iscsi/initiatorname.iscsi
systemctl restart iscsi
systemctl status iscsi
iscsiadm -m discovery -t st -p $localip
iscsiadm -m node -T iqn.2020-12.info2soft.com:racasm -p $localip:3260 -l
lsscsi -ds

echo "
KERNEL==\"sd*\", SUBSYSTEM==\"block\", PROGRAM==\"/usr/lib/udev/scsi_id --whitelisted --replace-whitespace --device=/dev/\$name\", RESULT==\"$(/usr/lib/udev/scsi_id -g -u -d /dev/sdf)\", SYMLINK+=\"asmdisk/DATADISK01\", OWNER=\"grid\", GROUP=\"asmadmin\", MODE=\"0660\"
KERNEL==\"sd*\", SUBSYSTEM==\"block\", PROGRAM==\"/usr/lib/udev/scsi_id --whitelisted --replace-whitespace --device=/dev/\$name\", RESULT==\"$(/usr/lib/udev/scsi_id -g -u -d /dev/sdg)\", SYMLINK+=\"asmdisk/DATADISK02\", OWNER=\"grid\", GROUP=\"asmadmin\", MODE=\"0660\"
KERNEL==\"sd*\", SUBSYSTEM==\"block\", PROGRAM==\"/usr/lib/udev/scsi_id --whitelisted --replace-whitespace --device=/dev/\$name\", RESULT==\"$(/usr/lib/udev/scsi_id -g -u -d /dev/sdh)\", SYMLINK+=\"asmdisk/DATADISK03\", OWNER=\"grid\", GROUP=\"asmadmin\", MODE=\"0660\"
">> /etc/udev/rules.d/99-oracle-asmdevices.rules

/sbin/udevadm control --reload-rules
/sbin/udevadm trigger --type=devices --action=change

f1="/dev/asmdisk/DATADISK01"
f2="/dev/asmdisk/DATADISK02"
f3="/dev/asmdisk/DATADISK03"

for var in $f1 $f2 $f3
do
	if [ ! -L "$var" ]
	then
		/sbin/udevadm control --reload-rules
		/sbin/udevadm trigger --type=devices --action=change
	fi
done

str=`ls -lh /dev/sdf`
str=${str//" "/ }
arr=($str)
echo ${arr[2]}
until [ "${arr[2]}" = "grid" ]
do
	/sbin/udevadm control --reload-rules
	/sbin/udevadm trigger --type=devices --action=change
	str=`ls -lh /dev/sdf`
	str=${str//" "/ }
	arr=($str)
done
echo ${arr[2]}


####################### prepare related  packages ##################################
yum -y install binutils compat-libcap1 compat-libstdc++-33 compat-libstdc++-33*.i686 elfutils-libelf-devel gcc gcc-c++ glibc*.i686 glibc glibc-devel glibc-devel*.i686 ksh libgcc*.i686 libgcc libstdc++ libstdc++*.i686 libstdc++-devel libstdc++-devel*.i686 libaio libaio*.i686 libaio-devel libaio-devel*.i686 make sysstat unixODBC unixODBC*.i686 unixODBC-devel unixODBC-devel*.i686 libXp

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
net.core.wmem_max = 1048576
kernel.panic_on_oops = 1
">> /etc/sysctl.conf
sysctl -p

echo "
oracle soft nproc 16384
oracle hard nproc 16384
oracle soft nofile 1024
oracle hard nofile 65536
oracle  soft  stack  10240
oracle  hard stack  32768
grid   soft   nofile    1024
grid   hard   nofile    65536
grid   soft   nproc    16384
grid   hard   nproc    16384
grid   soft   stack    10240
grid   hard   stack    32768
">> /etc/security/limits.conf

echo "
if [ \$USER = "oracle" ]; then
   if [ $SHELL = "/bin/ksh" ]; then
       ulimit -p 16384
       ulimit -n 65536
    else
       ulimit -u 16384 -n 65536
   fi
   umask 022
fi
">> /etc/profile

echo "
export ORACLE_BASE=/u01/app/grid
export ORACLE_HOME=\$ORACLE_BASE/product/18/grid_1
export ORACLE_SID=+ASM
export NLS_DATE_FORMAT='yyyy-mm-dd hh24:mi:ss'
export TNS_ADMIN=\$ORACLE_HOME/network/admin
export CLASSPATH=\$ORACLE_HOME/JRE:\$ORACLE_HOME/jlib:\$ORACLE_HOME/rdbms/jlib
export PATH=\$ORACLE_HOME/bin:$PATH
export LD_LIBRARY_PATH=\$ORACLE_HOME/lib:\$ORACLE_HOME/oracm/lib:/lib:/usr/lib:/usr/local/lib
export TEMP=/tmp
export TMP=/tmp
export TMPDIR=/tmp
">>/home/grid/.bash_profile
source /home/grid/.bash_profile

echo "
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=/u01/app/oracle/product/18/db_1
export ORACLE_SID=orcl
export NLS_LANG=AMERICAN_AMERICA.UTF8
export LANG=en_US.UTF-8
export NLS_DATE_FORMAT='yyyy-mm-dd hh24:mi:ss'
export TNS_ADMIN=\$ORACLE_HOME/network/admin
export PATH=\$ORACLE_HOME/bin:/usr/bin:/bin:/usr/bin/X11:/usr/local/bin:$PATH
export CLASSPATH=\$ORACLE_HOME/JRE:\$ORACLE_HOME/jlib:\$ORACLE_HOME/rdbms/jlib:\$ORACLE_HOME/network/jlib
export LD_LIBRARY_PATH=\$ORACLE_HOME/lib:\$ORACLE_HOME/oracm/lib:/lib:/usr/lib:/usr/local/lib
export TEMP=/tmp
export TMPDIR=/tmp
umask 000
">> /home/oracle/.bash_profile
source /home/oracle/.bash_profile
chmod -R 755 /home/oracle;chown -R oracle:oinstall /home/oracle/

echo "
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=/u01/app/oracle/product/18/db_1
export ORACLE_SID=orcl
export NLS_LANG=AMERICAN_AMERICA.UTF8
export LANG=en_US.UTF-8
export TNS_ADMIN=\$ORACLE_HOME/network/admin
export PATH=\$ORACLE_HOME/bin:/usr/bin:/bin:/usr/bin/X11:/usr/local/bin:$PATH
export CLASSPATH=\$ORACLE_HOME/JRE:\$ORACLE_HOME/jlib:\$ORACLE_HOME/rdbms/jlib:\$ORACLE_HOME/network/jlib
export LD_LIBRARY_PATH=\$ORACLE_HOME/lib:\$ORACLE_HOME/oracm/lib:/lib:/usr/lib:/usr/local/lib
export TEMP=/tmp
export TMPDIR=/tmp
umask 000
">> /root/.bash_profile
source /root/.bash_profile

useradd -g oinstall -G dba -m renl
mkdir -p /home/renl
cp /root/.bash_profile /home/renl
source /home/renl/.bash_profile

####################### prepare 18c binary and response file ###############################

if [ $dbVersion = '18.3.0.0' ]
then
    unzip $dbSoftPath/18.3/LINUX.X64_180000_grid_home.zip -d /u01/app/grid/product/18/grid_1
    unzip $dbSoftPath/18.3/LINUX.X64_180000_db_home.zip -d /u01/app/oracle/product/18/db_1
fi
cp /u01/app/oracle/product/18/db_1/install/response/db_install.rsp /u01/dbinstall.rsp
cp /u01/app/grid/product/18/grid_1/install/response/gridsetup.rsp /u01/grid.rsp

echo "write grid response file.........................."
sed -i "s|ORACLE_HOSTNAME=|ORACLE_HOSTNAME=$(hostname -s)|g" /u01/grid.rsp
sed -i "s|ORACLE_HOME=|ORACLE_HOME=/u01/app/grid/product/18/grid_1|g" /u01/grid.rsp
sed -i "s|INVENTORY_LOCATION.*|INVENTORY_LOCATION=/u01/app/oraInventory|g" /u01/grid.rsp
sed -i "s|oracle.install.option.*|oracle.install.option=HA_CONFIG|g" /u01/grid.rsp
sed -i "s|ORACLE_BASE.*|ORACLE_BASE=/u01/app/grid|g" /u01/grid.rsp
sed -i "s|oracle.install.asm.OSDBA.*|oracle.install.asm.OSDBA=asmdba|g" /u01/grid.rsp
sed -i "s|oracle.install.asm.OSOPER.*|oracle.install.asm.OSOPER=asmoper|g" /u01/grid.rsp
sed -i "s|oracle.install.asm.OSASM.*|oracle.install.asm.OSASM=asmadmin|g" /u01/grid.rsp
sed -i "s|oracle.install.asm.SYSASMPassword.*|oracle.install.asm.SYSASMPassword=Welcome1|g" /u01/grid.rsp
sed -i "s|oracle.install.asm.diskGroup.name.*|oracle.install.asm.diskGroup.name=DATA|g" /u01/grid.rsp
sed -i "s|oracle.install.asm.diskGroup.redundancy.*|oracle.install.asm.diskGroup.redundancy=NORMAL|g" /u01/grid.rsp
sed -i "s|oracle.install.asm.diskGroup.AUSize.*|oracle.install.asm.diskGroup.AUSize=4|g" /u01/grid.rsp
sed -i "s|oracle.install.asm.diskGroup.disks=|oracle.install.asm.diskGroup.disks=/dev/asmdisk/DATADISK01,/dev/asmdisk/DATADISK02,/dev/asmdisk/DATADISK03|g" /u01/grid.rsp
sed -i "s|oracle.install.asm.diskGroup.diskDiscoveryString=|oracle.install.asm.diskGroup.diskDiscoveryString=/dev/asmdisk/|g" /u01/grid.rsp
sed -i "s|oracle.install.asm.monitorPassword.*|oracle.install.asm.monitorPassword=Welcome1|g" /u01/grid.rsp

echo "write db response file.........................."
sed -i "s|oracle.install.option.*|oracle.install.option=INSTALL_DB_SWONLY|g" /u01/dbinstall.rsp
sed -i "s|UNIX_GROUP_NAME.*|UNIX_GROUP_NAME=oinstall|g" /u01/dbinstall.rsp
sed -i "s|INVENTORY_LOCATION.*|INVENTORY_LOCATION=/u01/app/oraInventory|g" /u01/dbinstall.rsp
sed -i "s|ORACLE_BASE.*|ORACLE_BASE=/u01/app/oracle|g" /u01/dbinstall.rsp
sed -i "s|ORACLE_HOME.*|ORACLE_HOME=/u01/app/oracle/product/18/db_1|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.InstallEdition.*|oracle.install.db.InstallEdition=EE|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.OSDBA_GROUP.*|oracle.install.db.OSDBA_GROUP=dba|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.OSOPER_GROUP.*|oracle.install.db.OSOPER_GROUP=oper|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.OSBACKUPDBA_GROUP.*|oracle.install.db.OSBACKUPDBA_GROUP=backupdba|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.OSDGDBA_GROUP.*|oracle.install.db.OSDGDBA_GROUP=dgdba|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.OSKMDBA_GROUP.*|oracle.install.db.OSKMDBA_GROUP=kmdba|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.OSRACDBA_GROUP.*|oracle.install.db.OSRACDBA_GROUP=dba|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.config.starterdb.type.*|oracle.install.db.config.starterdb.type=GENERAL_PURPOSE|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.config.starterdb.memoryLimit.*|oracle.install.db.config.starterdb.memoryLimit=512|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.config.starterdb.password.ALL.*|oracle.install.db.config.starterdb.password.ALL=Welcome1|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.config.starterdb.storageType.*|oracle.install.db.config.starterdb.storageType=FILE_SYSTEM_STORAGE|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.config.starterdb.fileSystemStorage.dataLocation.*|oracle.install.db.config.starterdb.fileSystemStorage.dataLocation=$oracleData|g" /u01/dbinstall.rsp
sed -i "s|SECURITY_UPDATES_VIA_MYORACLESUPPORT.*|SECURITY_UPDATES_VIA_MYORACLESUPPORT=false|g" /u01/dbinstall.rsp
sed -i "s|DECLINE_SECURITY_UPDATES.*|DECLINE_SECURITY_UPDATES=true|g" /u01/dbinstall.rsp

chown -R grid:oinstall /u01
chown -R grid:oinstall /u01/app/grid
chown -R oracle:oinstall /u01/app/oracle
chmod -R 775 /u01/


####################### setup and configure 18c db ###############################
su - grid -c "yes | \$ORACLE_HOME/gridSetup.sh -silent -responseFile /u01/grid.rsp"
echo $?
if [ $? -eq 0 ]; then
    echo "Execute Configuration Scripts............................."
    /u01/app/oraInventory/orainstRoot.sh
    /u01/app/grid/product/18/grid_1/root.sh
    su - grid -c "/u01/app/grid/product/18/grid_1/gridSetup.sh -executeConfigTools -responseFile /u01/grid.rsp -silent"
    echo "grid install suc ........................."
    echo "db install start..........................."
    
    su - oracle -c "\$ORACLE_HOME/runInstaller -ignorePrereq -force -silent -waitforcompletion -responseFile /u01/dbinstall.rsp"
    echo $?
    if [ $? -eq 0 ]; then
	    echo "db install suc..............."    
	    echo "Trying to run scripts..............."
	    /u01/app/oracle/product/18/db_1/root.sh
	    echo "Trying to netca................."
	    su - oracle -c "netca -silent -responsefile \$ORACLE_HOME/assistants/netca/netca.rsp"
	    if [ $? -eq 0 ]; then
	        echo "netca suc................."
	        echo "Trying to dbca..............."
	        if [ $iscdb = 'false' ]; then
	            su - oracle -c "dbca -createDatabase -templateName General_Purpose.dbc -gdbName orcl -sid orcl \
	            -sysPassword Welcome1 -systemPassword Welcome1 -dbsnmpPassword Welcome1 -asmsnmpPassword Welcome1 \
	            -datafileJarLocation \$ORACLE_HOME/assistants/dbca/templates \
	            -storageType ASM -datafileDestination DATA/ -diskGroupName DATA \
	            -characterset AL32UTF8 -nationalCharacterSet UTF8 -memoryPercentage 40 -silent"
	        elif [ $iscdb = 'true' ]; then
	            su - oracle -c "dbca -createDatabase -templateName General_Purpose.dbc -gdbName orcl -sid orcl \
	            -createAsContainerDatabase true -numberOfPDBs 1 -pdbName orclpdb \
	            -sysPassword Welcome1 -systemPassword Welcome1 -pdbAdminPassword Welcome1 -dbsnmpPassword Welcome1 \
	            -emExpressPort 5500 -omsPort 0 -memoryPercentage 40 -automaticMemoryManagement false \
	            -datafileJarLocation \$ORACLE_HOME/assistants/dbca/templates \
	            -storageType ASM -datafileDestination DATA/ -diskGroupName DATA \
	            -characterset AL32UTF8 -obfuscatedPasswords false -sampleSchema true -silent"
	        fi
	        if [ $? -eq 0 ]; then
	            echo "dbca suc....................."
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
else
    echo grid installation with failure
    exit 1
fi
```

## setupOracle12cEnv.sh

```sh
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


```

## setupOracle12cASMEnv.sh

```sh
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


####################### prepare related system account and packages ###############################

groupadd oinstall
groupadd dba
groupadd asmdba
groupadd asmadmin
groupadd asmoper
groupadd oper
groupadd backupdba
groupadd dgdba
groupadd kmdba
useradd -g oinstall -G asmadmin,asmdba,asmoper,oper,dba grid
useradd -g oinstall -G dba,asmdba,oper,backupdba,dgdba,kmdba oracle

mkfs.xfs /dev/sdd
mkdir /u01
mount /dev/sdd /u01
echo "/dev/sdd /u01 ext4 defaults 0 0" >> /etc/fstab

mkdir -p /u01/app/oracle/product/12/db_1
mkdir -p /u01/app/grid/product/12/grid_1
chown -R grid:oinstall /u01
chown -R grid:oinstall /u01/app/grid


####################### prepare related  packages ###############################

yum -y install binutils compat-libcap1 compat-libstdc++-33 compat-libstdc++-33*i686 compat-libstdc++-33*.devel gcc gcc-c++ glibc glibc*i686 glibc-devel glibc-devel*.i686 ksh libaio libaio*.i686 libaio-devel libaio-devel*.devel libgcc libgcc*.i686 libstdc++ libstdc++*.i686 libstdc++-devel libstdc++-devel*.devel libXi libXi*.i686  libXtst libXtst*.i686  make sysstat unixODBC unixODBC*.i686 unixODBC-devel unixODBC-devel*.i686

####################### adjust related system seting ###############################

sed -i "s|#RemoveIPC.*|RemoveIPC=no|g" /etc/systemd/logind.conf
systemctl daemon-reload
systemctl restart systemd-logind

echo "
session required pam_limits.so
">>/etc/pam.d/login

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
oracle soft nproc 16384
oracle hard nproc 16384
oracle soft nofile 1024
oracle hard nofile 65536
oracle  soft  stack  10240
oracle  hard stack  32768
grid   soft   nofile    1024
grid   hard   nofile    65536
grid   soft   nproc    16384
grid   hard   nproc    16384
grid   soft   stack    10240
grid   hard   stack    32768
">> /etc/security/limits.conf


echo "
export ORACLE_BASE=/u01/app/grid
export ORACLE_HOME=\$ORACLE_BASE/product/12/grid_1
export ORACLE_SID=+ASM
export NLS_DATE_FORMAT='yyyy-mm-dd hh24:mi:ss'
export TNS_ADMIN=\$ORACLE_HOME/network/admin
export LD_LIBRARY_PATH=\$ORACLE_HOME/lib
export CLASSPATH=\$ORACLE_HOME/JRE:\$ORACLE_HOME/jlib:\$ORACLE_HOME/rdbms/jlib
export PATH=\$ORACLE_HOME/bin:$PATH
export TEMP=/tmp
export TMP=/tmp
export TMPDIR=/tmp
">>/home/grid/.bash_profile
source /home/grid/.bash_profile

echo "
export NLS_LANG=AMERICAN_AMERICA.UTF8
export LANG=en_US.UTF-8
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=\$ORACLE_BASE/product/12/db_1
export ORACLE_SID=orcl
export ORACLE_TERM=xterm
export PATH=/usr/sbin:\$PATH
export PATH=\$ORACLE_HOME/bin:\$PATH
export LD_LIBRARY_PATH=\$ORACLE_HOME/lib
export CLASSPATH=\$ORACLE_HOME/JRE:\$ORACLE_HOME/jlib:\$ORACLE_HOME/rdbms/jlib
">> /home/oracle/.bash_profile
source /home/oracle/.bash_profile
chmod -R 755 /home/oracle;chown -R oracle:oinstall /home/oracle/

echo "
export NLS_LANG=AMERICAN_AMERICA.UTF8
export LANG=en_US.UTF-8
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=\$ORACLE_BASE/product/12/db_1
export ORACLE_SID=orcl
export ORACLE_TERM=xterm
export PATH=/usr/sbin:\$PATH
export PATH=\$ORACLE_HOME/bin:\$PATH
export LD_LIBRARY_PATH=\$ORACLE_HOME/lib
export CLASSPATH=\$ORACLE_HOME/JRE:\$ORACLE_HOME/jlib:\$ORACLE_HOME/rdbms/jlib
">> /root/.bash_profile
source /root/.bash_profile

echo "n



34953898
n



69905748
n




w" | fdisk /dev/sde


####################### prepare grid response file ###############################
if [ $dbVersion = '12.1.0.2' ]
then
        unzip $dbSoftPath/12.1.0.2_Linux_x86.64/linuxamd64_12102_grid_1of2.zip -d /u01/app/grid/product/12/grid_1
        unzip $dbSoftPath/12.1.0.2_Linux_x86.64/linuxamd64_12102_grid_2of2.zip -d /u01/app/grid/product/12/grid_1
        unzip $dbSoftPath/12.1.0.2_Linux_x86.64/linuxamd64_12102_database_1of2.zip -d /u01/
        unzip $dbSoftPath/12.1.0.2_Linux_x86.64/linuxamd64_12102_database_2of2.zip -d /u01/
        cd /u01/app/grid/product/12/grid_1/grid/rpm
        rpm -ivh cvuqdisk-1.0.9-1.rpm
        
        echo "write configToolAllCommands response file.........................."
        echo "oracle.assistants.asm|S_ASMPASSWORD=Welcome1
oracle.assistants.asm|S_ASMMONITORPASSWORD=Welcome1
oracle.crs|S_BMCPASSWORD=Welcome1
        " > /u01/cfgrsp.properties
        
        echo "write grid response file.........................."
        cp /u01/app/grid/product/12/grid_1/grid/response/grid_install.rsp /u01/grid.rsp
        sed -i "s|ORACLE_HOSTNAME=|ORACLE_HOSTNAME=$(hostname -s)|g" /u01/grid.rsp
        sed -i "s|ORACLE_HOME=|ORACLE_HOME=/u01/app/grid/product/12/grid_1|g" /u01/grid.rsp
        
        echo "write db response file............................"
        cp /u01/database/response/db_install.rsp /u01/dbinstall.rsp
        sed -i "s|oracle.install.db.DBA_GROUP.*|oracle.install.db.DBA_GROUP=dba|g" /u01/dbinstall.rsp
        sed -i "s|oracle.install.db.OPER_GROUP.*|oracle.install.db.OPER_GROUP=oper|g" /u01/dbinstall.rsp
        sed -i "s|oracle.install.db.BACKUPDBA_GROUP.*|oracle.install.db.BACKUPDBA_GROUP=backupdba|g" /u01/dbinstall.rsp
        sed -i "s|oracle.install.db.DGDBA_GROUP.*|oracle.install.db.DGDBA_GROUP=dgdba|g" /u01/dbinstall.rsp
        sed -i "s|oracle.install.db.KMDBA_GROUP.*|oracle.install.db.KMDBA_GROUP=kmdba|g" /u01/dbinstall.rsp
        sed -i "s|ORACLE_HOSTNAME.*|ORACLE_HOSTNAME=$(hostname -s)|g" /u01/dbinstall.rsp
fi
if [ $dbVersion = '12.2.0.1' ]
then
        unzip $dbSoftPath/12.2.0.1_Linux_x86.64/linuxx64_12201_grid_home.zip -d /u01/app/grid/product/12/grid_1
        unzip $dbSoftPath/12.2.0.1_Linux_x86.64/linuxx64_12201_database.zip -d /u01/
        cd /u01/app/grid/product/12/grid_1/cv/rpm
        rpm -ivh cvuqdisk-1.0.10-1.rpm

        echo "write grid response file.........................."
        cp /u01/app/grid/product/12/grid_1/install/response/gridsetup.rsp /u01/grid.rsp
        sed -i "s|oracle.install.asm.storageOption.*|oracle.install.asm.storageOption=ASM|g" /u01/grid.rsp
        sed -i "s|oracle.install.asm.gimrDG.AUSize.*|oracle.install.asm.gimrDG.AUSize=1|g" /u01/grid.rsp
        
        echo "write db response file............................"
        cp /u01/database/response/db_install.rsp /u01/dbinstall.rsp
        sed -i "s|oracle.install.db.OSDBA_GROUP.*|oracle.install.db.OSDBA_GROUP=dba|g" /u01/dbinstall.rsp
        sed -i "s|oracle.install.db.OSOPER_GROUP.*|oracle.install.db.OSOPER_GROUP=oper|g" /u01/dbinstall.rsp
        sed -i "s|oracle.install.db.OSBACKUPDBA_GROUP.*|oracle.install.db.OSBACKUPDBA_GROUP=backupdba|g" /u01/dbinstall.rsp
        sed -i "s|oracle.install.db.OSDGDBA_GROUP.*|oracle.install.db.OSDGDBA_GROUP=dgdba|g" /u01/dbinstall.rsp
        sed -i "s|oracle.install.db.OSKMDBA_GROUP.*|oracle.install.db.OSKMDBA_GROUP=kmdba|g" /u01/dbinstall.rsp
        sed -i "s|oracle.install.db.OSRACDBA_GROUP.*|oracle.install.db.OSRACDBA_GROUP=dba|g" /u01/dbinstall.rsp
fi

echo "write grid response file.........................."
sed -i "s|INVENTORY_LOCATION.*|INVENTORY_LOCATION=/u01/app/oraInventory|g" /u01/grid.rsp
sed -i "s|oracle.install.option.*|oracle.install.option=HA_CONFIG|g" /u01/grid.rsp
sed -i "s|ORACLE_BASE.*|ORACLE_BASE=/u01/app/grid|g" /u01/grid.rsp
sed -i "s|oracle.install.asm.OSDBA.*|oracle.install.asm.OSDBA=asmdba|g" /u01/grid.rsp
sed -i "s|oracle.install.asm.OSOPER.*|oracle.install.asm.OSOPER=asmoper|g" /u01/grid.rsp
sed -i "s|oracle.install.asm.OSASM.*|oracle.install.asm.OSASM=asmadmin|g" /u01/grid.rsp
sed -i "s|oracle.install.asm.SYSASMPassword.*|oracle.install.asm.SYSASMPassword=Welcome1|g" /u01/grid.rsp
sed -i "s|oracle.install.asm.diskGroup.name.*|oracle.install.asm.diskGroup.name=DATA|g" /u01/grid.rsp
sed -i "s|oracle.install.asm.diskGroup.redundancy.*|oracle.install.asm.diskGroup.redundancy=NORMAL|g" /u01/grid.rsp
sed -i "s|oracle.install.asm.diskGroup.AUSize.*|oracle.install.asm.diskGroup.AUSize=4|g" /u01/grid.rsp
sed -i "s|oracle.install.asm.diskGroup.disks=|oracle.install.asm.diskGroup.disks=/dev/sde1,/dev/sde2,/dev/sde3|g" /u01/grid.rsp
sed -i "s|oracle.install.asm.diskGroup.diskDiscoveryString.*|oracle.install.asm.diskGroup.diskDiscoveryString=/dev/sde*|g" /u01/grid.rsp
sed -i "s|oracle.install.asm.monitorPassword.*|oracle.install.asm.monitorPassword=Welcome1|g" /u01/grid.rsp

echo "write db response file.........................."
sed -i "s|oracle.install.option.*|oracle.install.option=INSTALL_DB_SWONLY|g" /u01/dbinstall.rsp
sed -i "s|UNIX_GROUP_NAME.*|UNIX_GROUP_NAME=oinstall|g" /u01/dbinstall.rsp
sed -i "s|INVENTORY_LOCATION.*|INVENTORY_LOCATION=/u01/app/oraInventory|g" /u01/dbinstall.rsp
sed -i "s|ORACLE_HOME.*|ORACLE_HOME=/u01/app/oracle/product/12/db_1|g" /u01/dbinstall.rsp
sed -i "s|ORACLE_BASE.*|ORACLE_BASE=/u01/app/oracle|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.InstallEdition.*|oracle.install.db.InstallEdition=EE|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.config.starterdb.type.*|oracle.install.db.config.starterdb.type=GENERAL_PURPOSE|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.config.starterdb.memoryLimit.*|oracle.install.db.config.starterdb.memoryLimit=512|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.config.starterdb.password.ALL.*|oracle.install.db.config.starterdb.password.ALL=Welcome1|g" /u01/dbinstall.rsp
sed -i "s|SECURITY_UPDATES_VIA_MYORACLESUPPORT.*|SECURITY_UPDATES_VIA_MYORACLESUPPORT=false|g" /u01/dbinstall.rsp
sed -i "s|DECLINE_SECURITY_UPDATES.*|DECLINE_SECURITY_UPDATES=true|g" /u01/dbinstall.rsp

chown -R grid:oinstall /u01
chown -R grid:oinstall /u01/app/grid
chown -R oracle:oinstall /u01/app/oracle
chmod -R 775 /u01/

chown -R grid:asmadmin /dev/sde1
chown -R grid:asmadmin /dev/sde2
chown -R grid:asmadmin /dev/sde3

if [ $dbVersion = '12.1.0.2' ]
then
        su - grid -c "yes | \$ORACLE_HOME/grid/runInstaller -silent -responseFile /u01/grid.rsp"
        echo $?
        if [ $? -eq 0 ]; then
                echo "Execute Configuration Scripts............................."
                /u01/app/oraInventory/orainstRoot.sh
                /u01/app/grid/product/12/grid_1/root.sh
                su - grid -c "\$ORACLE_HOME/cfgtoollogs/configToolAllCommands RESPONSE_FILE=/u01/cfgrsp.properties"
                echo "grid install suc ........................."
                
                echo "db install start..........................."
                su - oracle -c "/u01/database/runInstaller -ignoreSysPrereqs -ignorePrereq -invPtrLoc /u01/app/oraInventory/oraInst.loc -force -silent -waitforcompletion -responseFile /u01/dbinstall.rsp"
                if [ $? -eq 0 ]; then
                        /u01/app/oracle/product/12/db_1/root.sh
                        echo "db install suc................."
                        echo "dbca.................."
                        if [ $iscdb = 'false' ]; then
                                su - oracle -c "dbca -createDatabase -gdbName orcl -sid orcl -templateName General_Purpose.dbc -datafileJarLocation \$ORACLE_HOME/assistants/dbca/templates -datafileDestination DATA/ -storageType ASM -diskGroupName DATA -sysPassword Welcome1 -systemPassword Welcome1 -asmsnmpPassword Welcome1 -responseFile NO_VALUE -characterset AL32UTF8 -nationalCharacterSet UTF8 -memoryPercentage 40 -silent"
                        elif [ $iscdb = 'true' ]; then
                                su - oracle -c "dbca -createDatabase -gdbName orcl -sid orcl -templateName General_Purpose.dbc -createAsContainerDatabase true -numberOfPDBs 1 -pdbName orclpdb \
                                -pdbAdminPassword Welcome1 -dbsnmpPassword Welcome1 -sysPassword Welcome1 -systemPassword Welcome1 -asmsnmpPassword Welcome1 \
                                -emExpressPort 5500 -omsPort 0 \
                                -datafileJarLocation \$ORACLE_HOME/assistants/dbca/templates -datafileDestination DATA/ -storageType ASM -diskGroupName DATA \
                                -characterset AL32UTF8 -nationalCharacterSet UTF8 -memoryPercentage 40 -silent"
                        fi
                        if [ $? -eq 0 ]; then
                                echo "dbca suc....................."
                        else
                                echo "dbca fail......................"
                                exit 1
                        fi
                else
                        echo "db install fail................."
                        exit 1
                fi
        else
                echo "grid install fail ........................."
                exit 1
        fi
fi

if [ $dbVersion = '12.2.0.1' ]
then
        su - grid -c "\$ORACLE_HOME/gridSetup.sh -silent -responseFile /u01/grid.rsp"
        echo $?
        if [ $? -eq 0 ]; then
                echo "Execute Configuration Scripts............................."
                /u01/app/oraInventory/orainstRoot.sh
                /u01/app/grid/product/12/grid_1/root.sh
                su - grid -c "\$ORACLE_HOME/gridSetup.sh -executeConfigTools -responseFile /u01/grid.rsp -silent"
                echo "grid install suc ........................."
                
                echo "db install start..........................."
                su - oracle -c "/u01/database/runInstaller -ignoreSysPrereqs -ignorePrereq -invPtrLoc /u01/app/oraInventory/oraInst.loc -force -silent -waitforcompletion -responseFile /u01/dbinstall.rsp"
                if [ $? -eq 0 ]; then
                        /u01/app/oracle/product/12/db_1/root.sh
                        echo "db install suc................."
                        echo "dbca.................."
                        if [ $iscdb = 'false' ]; then
                                su - oracle -c "dbca -createDatabase -gdbName orcl -sid orcl -templateName General_Purpose.dbc -datafileJarLocation \$ORACLE_HOME/assistants/dbca/templates -datafileDestination DATA/ -storageType ASM -diskGroupName DATA -sysPassword Welcome1 -systemPassword Welcome1 -asmsnmpPassword Welcome1 -responseFile NO_VALUE -characterset AL32UTF8 -nationalCharacterSet UTF8 -memoryPercentage 40 -silent"
                        elif [ $iscdb = 'true' ]; then
                                su - oracle -c "dbca -createDatabase -gdbName orcl -sid orcl -templateName General_Purpose.dbc -createAsContainerDatabase true -numberOfPDBs 1 -pdbName orclpdb \
                                -pdbAdminPassword Welcome1 -dbsnmpPassword Welcome1 -sysPassword Welcome1 -systemPassword Welcome1 -asmsnmpPassword Welcome1 \
                                -emExpressPort 5500 -omsPort 0 \
                                -datafileJarLocation \$ORACLE_HOME/assistants/dbca/templates -datafileDestination DATA/ -storageType ASM -diskGroupName DATA \
                                -characterset AL32UTF8 -nationalCharacterSet UTF8 -memoryPercentage 40 -silent"
                        fi

                        if [ $? -eq 0 ]; then
                                echo "dbca suc....................."
                        else
                                echo "dbca fail......................"
                                exit 1
                        fi
                else
                        echo "db install fail................."
                        exit 1
                fi
        else
                echo "grid install fail ........................."
                exit 1
        fi
fi
```

## setupOracle11gWinEnv.bat

```sh
@echo off

set dbSoftPath=%1
set dbVersion=%2

echo %dbSoftPath%
echo %dbVersion%


::####################### define related 11g installation destination and layer ###############################
set dbTopDir=D:
set oracleSid=orcl
set oracleBase=%dbTopDir%\\app
set oracleHome=%oracleBase%\\product\\%oracleSid%
set oracleInventory=%oracleBase%\\inventory
set oracleData=%oracleBase%\\oradata
set OH=%oracleHome:\\=\%


::####################### prepare 11g binary and response file ###############################
echo xcopy Z:\resources\windowstools\*.* C:\Windows\System32
echo "A" | xcopy Z:\resources\windowstools\*.* C:\Windows\System32
md D:\sxs
echo xcopy Z:\resources\active\sxs\*.* D:\sxs
xcopy Z:\resources\active\sxs\*.* D:\sxs
echo dism.exe /online /enable-feature /featurename:NetFX3 /Source:D:\sxs
dism.exe /online /enable-feature /featurename:NetFX3 /Source:D:\sxs

echo copy /Y %dbSoftPath%\win64_11gR2_database_1of2.zip %dbTopDir%
copy /Y %dbSoftPath%\win64_11gR2_database_1of2.zip %dbTopDir%

echo copy /Y %dbSoftPath%\win64_11gR2_database_2of2.zip %dbTopDir%
copy /Y %dbSoftPath%\win64_11gR2_database_2of2.zip %dbTopDir%

echo unzip %dbTopDir%\win64_11gR2_database_1of2.zip -d %dbTopDir%
unzip %dbTopDir%\win64_11gR2_database_1of2.zip -d %dbTopDir% 

echo unzip %dbTopDir%\win64_11gR2_database_2of2.zip -d %dbTopDir%
unzip %dbTopDir%\win64_11gR2_database_2of2.zip -d %dbTopDir%

echo copy /Y %dbTopDir%\database\response\db_install.rsp %dbTopDir%\dbinstall.rsp
copy /Y %dbTopDir%\database\response\db_install.rsp %dbTopDir%\dbinstall.rsp

echo sed -i "s|oracle.install.option.*|oracle.install.option=INSTALL_DB_SWONLY|g" %dbTopDir%\dbinstall.rsp
cd /D D: && sed -i "s|oracle.install.option.*|oracle.install.option=INSTALL_DB_SWONLY|g" %dbTopDir%\dbinstall.rsp

for /f  %%a in  ('hostname') do set hostName=%%a
echo sed -i "s|ORACLE_HOSTNAME.*|ORACLE_HOSTNAME=%hostName%|g" %dbTopDir%\dbinstall.rsp
cd /D D: && sed -i "s|ORACLE_HOSTNAME.*|ORACLE_HOSTNAME=%hostName%|g" %dbTopDir%\dbinstall.rsp

echo sed -i "s|INVENTORY_LOCATION.*|INVENTORY_LOCATION=%oracleInventory:\=\\%|g" %dbTopDir%\dbinstall.rsp
cd /D D: && sed -i "s|INVENTORY_LOCATION.*|INVENTORY_LOCATION=%oracleInventory:\=\\%|g" %dbTopDir%\dbinstall.rsp

echo sed -i "s|SELECTED_LANGUAGES.*|SELECTED_LANGUAGES=en,zh_CN|g" %dbTopDir%\dbinstall.rsp
cd /D D: && sed -i "s|SELECTED_LANGUAGES.*|SELECTED_LANGUAGES=en,zh_CN|g" %dbTopDir%\dbinstall.rsp

echo sed -i "s|ORACLE_HOME.*|ORACLE_HOME=%oracleHome:\=\\%|g" %dbTopDir%\dbinstall.rsp
cd /D D: && sed -i "s|ORACLE_HOME.*|ORACLE_HOME=%oracleHome:\=\\%|g" %dbTopDir%\dbinstall.rsp

echo sed -i "s|ORACLE_BASE.*|ORACLE_BASE=%oracleBase:\=\\%|g" %dbTopDir%\dbinstall.rsp
cd /D D: && sed -i "s|ORACLE_BASE.*|ORACLE_BASE=%oracleBase:\=\\%|g" %dbTopDir%\dbinstall.rsp

echo sed -i "s|oracle.install.db.InstallEdition.*|oracle.install.db.InstallEdition=EE|g" %dbTopDir%\dbinstall.rsp
cd /D D: && sed -i "s|oracle.install.db.InstallEdition.*|oracle.install.db.InstallEdition=EE|g" %dbTopDir%\dbinstall.rsp

echo sed -i "s|DECLINE_SECURITY_UPDATES.*|DECLINE_SECURITY_UPDATES=true|g" %dbTopDir%\dbinstall.rsp
cd /D D: && sed -i "s|DECLINE_SECURITY_UPDATES.*|DECLINE_SECURITY_UPDATES=true|g" %dbTopDir%\dbinstall.rsp


::####################### setup and configure 11g db ###############################
echo Trying to install oracle 11g...............
echo %dbTopDir%\database\setup.exe -ignoreSysPrereqs -ignorePrereq -invPtrLoc %oracleInventory%\oraInst.loc -force -silent -waitforcompletion -responseFile %dbTopDir%\dbinstall.rsp -nowait
%dbTopDir%\database\setup.exe -ignoreSysPrereqs -ignorePrereq -invPtrLoc %oracleInventory%\oraInst.loc -force -silent -waitforcompletion -responseFile %dbTopDir%\dbinstall.rsp -nowait

if errorlevel 0 (
    echo Trying to netca...............
    echo %OH%\bin\netca /orahome %OH% /orahnam %oracleSid% /instype typical /inscomp client,oraclenet,javavm,server,ano /insprtcl tcp /cfg local /authadp NO_VALUE /responseFile %OH%\NETWORK\install\netca_typ.rsp /silent
    %OH%\BIN\netca /orahome %OH% /orahnam %oracleSid% /instype typical /inscomp client,oraclenet,javavm,server,ano /insprtcl tcp /cfg local /authadp NO_VALUE /responseFile %OH%\NETWORK\install\netca_typ.rsp /silent
    if errorlevel 0 (
        echo Trying to dbca...............
        %oracleHome%\bin\dbca -createDatabase -templateName General_Purpose.dbc -gdbName %oracleSid% -sid %oracleSid% -sysPassword welcome1 -systemPassword welcome1 -emConfiguration LOCAL -dbsnmpPassword welcome1 -sysmanPassword welcome1 -datafileJarLocation %oracleHome%\assistants\dbca\templates -storageType FS -datafileDestination %oracleData% -responseFile NO_VALUE -characterset AL32UTF8 -totalMemory 1638 -obfuscatedPasswords false -sampleSchema true -oratabLocation ORATAB -recoveryAreaDestination NO_VALUE -silent
    )
)

echo setx /m ORACLE_HOME "D:\app\product\orcl"
setx /m ORACLE_HOME "D:\app\product\orcl"
echo setx /m ORACLE_SID "orcl"
setx /m ORACLE_SID "orcl"
echo setx -m path "%path%;D:\app\product\orcl\BIN"
setx -m path "%path%;D:\app\product\orcl\BIN"
echo net localgroup ora_dba Administrator /add
net localgroup ora_dba Administrator /add

```

## setupOracle11gEnv.sh

```sh
#!/bin/bash

dbSoftPath=$1
dbVersion=$2

echo $dbSoftPath
echo $dbVersion
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


####################### define related 11g installation destination and layer ###############################
dbTopDir=/u01
oracleSid=orcl
oracleBase=/u01/app/oracle
oracleHome=/u01/app/oracle/product/11/db_1
oracleInventory=/u01/app/oraInventory
oracleData=/u01/app/oracle/oradata


####################### prepare related system account and packages ###############################
groupadd oinstall
groupadd dba
useradd -g oinstall -G dba -d /home/oracle -s /bin/bash -c "Oracle Software Owner" -m oracle
#yum -y install binutils compat-libcap1 compat-libstdc++-33 gcc gcc-c++ glibc glibc-devel ksh libaio libaio-devel libgcc libstdc++ libstdc++-devel libXi libXtst make sysstat unixODBC unixODBC-devel
###centos7.6 have installed above depended libs,but centos7.5 still lack following lib
#if ! rpm -qa|grep -E 'compat-libcap1|compat-libstdc++-33|gcc-c++|ksh|libaio-devel|libstdc++-devel' ;then
#   yum -y install compat-libcap1 compat-libstdc++-33 gcc-c++ ksh libaio-devel  libstdc++-devel
#fi

####################### adjust related system seting ###############################
echo "
fs.aio-max-nr = 1048576
fs.file-max = 6815744
kernel.shmall = 2097152
kernel.shmmax  = 536870912
kernel.shmmni = 4096
kernel.sem = 250 32000 100 128
net.ipv4.ip_local_port_range = 9000 65500
net.core.rmem_default = 262144
net.core.rmem_max = 4194304
net.core.wmem_default = 262144
net.core.wmem_max = 1048576
">> /etc/sysctl.conf
sysctl -p
echo "
oracle soft nproc 131072
oracle hard nproc 131072
oracle soft nofile 131072
oracle hard nofile 131072
oracle soft core unlimited
oracle hard core unlimited
oracle soft memlock 50000000
oracle hard memlock 50000000
">> /etc/security/limits.conf
echo "
if [ \$USER = "oracle" ]; then
   if [ $SHELL = "/bin/ksh" ]; then
       ulimit -p 16384
       ulimit -n 65536
    else
       ulimit -u 16384 -n 65536
   fi
   umask 022
fi
">> /etc/profile

echo "
export ORACLE_BASE=$oracleBase
export ORACLE_HOME=$oracleHome
export ORACLE_SID=$oracleSid
export PATH=\$ORACLE_HOME/bin:/usr/sbin:$PATH
export LD_LIBRARY_PATH=\$ORACLE_HOME/lib
">> /home/oracle/.bash_profile
source /home/oracle/.bash_profile
chmod -R 755 /home/oracle;chown -R oracle:oinstall /home/oracle/

echo "
export ORACLE_BASE=$oracleBase
export ORACLE_HOME=$oracleHome
export ORACLE_SID=$oracleSid
export PATH=\$ORACLE_HOME/bin:/usr/sbin:$PATH
export LD_LIBRARY_PATH=\$ORACLE_HOME/lib
">> /root/.bash_profile
source /root/.bash_profile

useradd -g oinstall -G dba -m renl

cp /root/.bash_profile /home/renl
source /home/renl/.bash_profile

####################### prepare 11g binary and response file ###############################
mkfs.xfs /dev/sdd
mkdir $dbTopDir
mount /dev/sdd $dbTopDir
if [ $dbVersion = '11.2.0.1' ]
then
	unzip "$dbSoftPath/oracle$dbVersion"\ "64bit"/linux.x64_11gR2_database_1of2.zip -d $dbTopDir 
	unzip "$dbSoftPath/oracle$dbVersion"\ "64bit"/linux.x64_11gR2_database_2of2.zip -d $dbTopDir
elif [ $dbVersion = '11.2.0.3' ]
then
	unzip "$dbSoftPath/oracle$dbVersion"\ "64bit"/p10404530_112030_Linux-x86-64_1of7.zip -d $dbTopDir
	unzip "$dbSoftPath/oracle$dbVersion"\ "64bit"/p10404530_112030_Linux-x86-64_2of7.zip -d $dbTopDir
elif [ $dbVersion = '11.2.0.4' ]
then
	unzip "$dbSoftPath/oracle$dbVersion"\ "64bit"/p13390677_112040_Linux-x86-64_1of7.zip -d $dbTopDir
	unzip "$dbSoftPath/oracle$dbVersion"\ "64bit"/p13390677_112040_Linux-x86-64_2of7.zip -d $dbTopDir
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
sed -i "s|oracle.install.db.DBA_GROUP.*|oracle.install.db.DBA_GROUP=dba|g" $dbTopDir/dbinstall.rsp
sed -i "s|oracle.install.db.OPER_GROUP.*|oracle.install.db.OPER_GROUP=dba|g" $dbTopDir/dbinstall.rsp
sed -i "s|oracle.install.db.config.starterdb.type.*|oracle.install.db.config.starterdb.type=GENERAL_PURPOSE|g" $dbTopDir/dbinstall.rsp
sed -i "s|oracle.install.db.config.starterdb.globalDBName.*|oracle.install.db.config.starterdb.globalDBName=${oracleSid}.info2soft.com|g" $dbTopDir/dbinstall.rsp
sed -i "s|oracle.install.db.config.starterdb.SID.*|oracle.install.db.config.starterdb.SID=$oracleSid|g" $dbTopDir/dbinstall.rsp
sed -i "s|oracle.install.db.config.starterdb.memoryLimit.*|oracle.install.db.config.starterdb.memoryLimit=512|g" $dbTopDir/dbinstall.rsp
sed -i "s|oracle.install.db.config.starterdb.password.ALL.*|oracle.install.db.config.starterdb.password.ALL=welcome1|g" $dbTopDir/dbinstall.rsp
sed -i "s|oracle.install.db.config.starterdb.storageType.*|oracle.install.db.config.starterdb.storageType=FILE_SYSTEM_STORAGE|g" $dbTopDir/dbinstall.rsp
sed -i "s|oracle.install.db.config.starterdb.fileSystemStorage.dataLocation.*|oracle.install.db.config.starterdb.fileSystemStorage.dataLocation=$oracleData|g" $dbTopDir/dbinstall.rsp
sed -i "s|SECURITY_UPDATES_VIA_MYORACLESUPPORT.*|SECURITY_UPDATES_VIA_MYORACLESUPPORT=false|g" $dbTopDir/dbinstall.rsp
sed -i "s|DECLINE_SECURITY_UPDATES.*|DECLINE_SECURITY_UPDATES=true|g" $dbTopDir/dbinstall.rsp

chown -R oracle:oinstall $dbTopDir
chmod 755 -R $dbTopDir


####################### setup and configure 11g db ###############################
echo "Trying to install oracle 11g..............."
su - oracle -c "$dbTopDir/database/runInstaller -ignoreSysPrereqs  -ignorePrereq -invPtrLoc $oracleInventory/oraInst.loc -force -silent -waitforcompletion -responseFile $dbTopDir/dbinstall.rsp"
if [ $? -eq 0 ]; then
    echo "Trying to run $oracleHome/root.sh..............."
    $oracleHome/root.sh
    echo "$oracleSid:$oracleHome:Y" >/etc/oratab
    echo "Trying to netca..............."
    su - oracle -c "netca /orahome $oracleHome /orahnam $oracleSid /instype typical /inscomp client,oraclenet,javavm,server,ano /insprtcl tcp /cfg local /authadp NO_VALUE /responseFile \$ORACLE_HOME/network/install/netca_typ.rsp /silent"
    if [ $? -eq 0 ]; then
        echo "Trying to dbca..............."
        su - oracle -c "dbca -createDatabase -templateName General_Purpose.dbc -gdbName $oracleSid -sid $oracleSid -sysPassword welcome1 -systemPassword welcome1 -emConfiguration LOCAL -dbsnmpPassword welcome1 -sysmanPassword welcome1 -datafileJarLocation \$ORACLE_HOME/assistants/dbca/templates -storageType FS -datafileDestination $oracleData -responseFile NO_VALUE -characterset AL32UTF8 -totalMemory 1638 -obfuscatedPasswords false -sampleSchema true -oratabLocation ORATAB -recoveryAreaDestination NO_VALUE -silent"
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


```

## setupOracle11gASMEnv.sh

```sh
#!/bin/bash

dbSoftPath=$1
dbVersion=$2

echo $dbSoftPath
echo $dbVersion

####################### prepare related system account and packages ###############################

groupadd oinstall
groupadd dba
groupadd asmdba
groupadd asmadmin
groupadd asmoper
groupadd oper

useradd -g oinstall -G asmadmin,asmdba,asmoper,oper,dba grid
useradd -g oinstall -G dba,asmdba,oper oracle

mkfs.xfs /dev/sdd
mkdir /u01
mount /dev/sdd /u01
echo "/dev/sdd /u01 ext4 defaults 0 0" >> /etc/fstab

mkdir -p /u01/app/oracle/product/11/db_1
mkdir -p /u01/app/grid/product/11/grid_1
chown -R grid:oinstall /u01
chown -R grid:oinstall /u01/app/grid

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

echo "n



34953898
n



69905748
n




w" | fdisk /dev/sde

localip=$(cat /etc/sysconfig/network-scripts/ifcfg-ens160 | grep IPADDR | tr -d "IPADDR=")
echo $localip

lsblk
yum -y install targetcli
systemctl enable target
systemctl restart target

targetcli /backstores/block create serversde1 /dev/sde1
targetcli /backstores/block create serversde2 /dev/sde2
targetcli /backstores/block create serversde3 /dev/sde3

targetcli /iscsi create iqn.2020-12.info2soft.com:racasm
targetcli /iscsi/iqn.2020-12.info2soft.com:racasm/tpg1/acls create iqn.2020-12.info2soft.com:rac1

targetcli /iscsi/iqn.2020-12.info2soft.com:racasm/tpg1/luns create /backstores/block/serversde1
targetcli /iscsi/iqn.2020-12.info2soft.com:racasm/tpg1/luns create /backstores/block/serversde2
targetcli /iscsi/iqn.2020-12.info2soft.com:racasm/tpg1/luns create /backstores/block/serversde3

targetcli / saveconfig

sed -i "s/InitiatorName=.*/InitiatorName=iqn.2020-12.info2soft.com:rac1/g" /etc/iscsi/initiatorname.iscsi
systemctl restart iscsi
systemctl status iscsi
iscsiadm -m discovery -t st -p $localip
iscsiadm -m node -T iqn.2020-12.info2soft.com:racasm -p $localip:3260 -l
lsscsi -ds

echo "
KERNEL==\"sd*\", SUBSYSTEM==\"block\", PROGRAM==\"/usr/lib/udev/scsi_id --whitelisted --replace-whitespace --device=/dev/\$name\", RESULT==\"$(/usr/lib/udev/scsi_id -g -u -d /dev/sdf)\", SYMLINK+=\"asmdisk/DATADISK01\", OWNER=\"grid\", GROUP=\"asmadmin\", MODE=\"0660\"
KERNEL==\"sd*\", SUBSYSTEM==\"block\", PROGRAM==\"/usr/lib/udev/scsi_id --whitelisted --replace-whitespace --device=/dev/\$name\", RESULT==\"$(/usr/lib/udev/scsi_id -g -u -d /dev/sdg)\", SYMLINK+=\"asmdisk/DATADISK02\", OWNER=\"grid\", GROUP=\"asmadmin\", MODE=\"0660\"
KERNEL==\"sd*\", SUBSYSTEM==\"block\", PROGRAM==\"/usr/lib/udev/scsi_id --whitelisted --replace-whitespace --device=/dev/\$name\", RESULT==\"$(/usr/lib/udev/scsi_id -g -u -d /dev/sdh)\", SYMLINK+=\"asmdisk/DATADISK03\", OWNER=\"grid\", GROUP=\"asmadmin\", MODE=\"0660\"
">> /etc/udev/rules.d/99-oracle-asmdevices.rules

/sbin/udevadm control --reload-rules
/sbin/udevadm trigger --type=devices --action=change

f1="/dev/asmdisk/DATADISK01"
f2="/dev/asmdisk/DATADISK02"
f3="/dev/asmdisk/DATADISK03"

for var in $f1 $f2 $f3
do
	if [ ! -L "$var" ]
	then
		/sbin/udevadm control --reload-rules
		/sbin/udevadm trigger --type=devices --action=change
	fi
done

str=`ls -lh /dev/sdf`
str=${str//" "/ }
arr=($str)
echo ${arr[2]}
until [ "${arr[2]}" = "grid" ]
do
	/sbin/udevadm control --reload-rules
	/sbin/udevadm trigger --type=devices --action=change
	str=`ls -lh /dev/sdf`
	str=${str//" "/ }
	arr=($str)
done
echo ${arr[2]}

####################### prepare related  packages ###############################
yum -y install binutils compat-libcap1 compat-libstdc++-33 compat-libstdc++-33*i686 compat-libstdc++-33*.devel gcc gcc-c++ glibc glibc*i686 glibc-devel glibc-devel*.i686 ksh libaio libaio*.i686 libaio-devel libaio-devel*.devel libgcc libgcc*.i686 libstdc++ libstdc++*.i686 libstdc++-devel libstdc++-devel*.devel libXi libXi*.i686  libXtst libXtst*.i686  make sysstat unixODBC unixODBC*.i686 unixODBC-devel unixODBC-devel*.i686

####################### adjust related system seting ###############################

sed -i "s|#RemoveIPC.*|RemoveIPC=no|g" /etc/systemd/logind.conf
systemctl daemon-reload
systemctl restart systemd-logind

echo "
session required pam_limits.so
">>/etc/pam.d/login

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
oracle soft nproc 16384
oracle hard nproc 16384
oracle soft nofile 1024
oracle hard nofile 65536
oracle  soft  stack  10240
oracle  hard stack  32768
grid   soft   nofile    1024
grid   hard   nofile    65536
grid   soft   nproc    16384
grid   hard   nproc    16384
grid   soft   stack    10240
grid   hard   stack    32768
">> /etc/security/limits.conf


echo "
export NLS_LANG=AMERICAN_AMERICA.UTF8
export LANG=en_US.UTF-8
export ORACLE_BASE=/u01/app/grid
export ORACLE_HOME=\$ORACLE_BASE/product/11/grid_1
export ORACLE_SID=+ASM
export NLS_DATE_FORMAT='yyyy-mm-dd hh24:mi:ss'
export TNS_ADMIN=\$ORACLE_HOME/network/admin
export LD_LIBRARY_PATH=\$ORACLE_HOME/lib
export CLASSPATH=\$ORACLE_HOME/JRE:\$ORACLE_HOME/jlib:\$ORACLE_HOME/rdbms/jlib
export PATH=\$ORACLE_HOME/bin:$PATH
export TEMP=/tmp
export TMP=/tmp
export TMPDIR=/tmp
">>/home/grid/.bash_profile
source /home/grid/.bash_profile

echo "
export NLS_LANG=AMERICAN_AMERICA.UTF8
export LANG=en_US.UTF-8
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=\$ORACLE_BASE/product/11/db_1
export ORACLE_SID=orcl
export ORACLE_TERM=xterm
export PATH=/usr/sbin:\$PATH
export PATH=\$ORACLE_HOME/bin:\$PATH
export LD_LIBRARY_PATH=\$ORACLE_HOME/lib
export CLASSPATH=\$ORACLE_HOME/JRE:\$ORACLE_HOME/jlib:\$ORACLE_HOME/rdbms/jlib
">> /home/oracle/.bash_profile
source /home/oracle/.bash_profile
chmod -R 755 /home/oracle;chown -R oracle:oinstall /home/oracle/

echo "
export NLS_LANG=AMERICAN_AMERICA.UTF8
export LANG=en_US.UTF-8
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=\$ORACLE_BASE/product/11/db_1
export ORACLE_SID=orcl
export ORACLE_TERM=xterm
export PATH=/usr/sbin:\$PATH
export PATH=\$ORACLE_HOME/bin:\$PATH
export LD_LIBRARY_PATH=\$ORACLE_HOME/lib
export CLASSPATH=\$ORACLE_HOME/JRE:\$ORACLE_HOME/jlib:\$ORACLE_HOME/rdbms/jlib
">> /root/.bash_profile
source /root/.bash_profile

####################### prepare grid response file ###############################
if [ $dbVersion = '11.2.0.1' ]
then
        unzip "$dbSoftPath/oracle$dbVersion"\ "64bit"/linux.x64_11gR2_grid.zip -d /u01/app/grid/product/11/grid_1
        unzip "$dbSoftPath/oracle$dbVersion"\ "64bit"/linux.x64_11gR2_database_1of2.zip -d /u01/
        unzip "$dbSoftPath/oracle$dbVersion"\ "64bit"/linux.x64_11gR2_database_2of2.zip -d /u01/

        cd /u01/app/grid/product/11/grid_1/grid/rpm
        rpm -ivh cvuqdisk-1.0.7-1.rpm
        
        cp /u01/app/grid/product/11/grid_1/grid/response/crs_install.rsp /u01/grid.rsp
fi
if [ $dbVersion = '11.2.0.3' ]
then
        unzip "$dbSoftPath/oracle$dbVersion"\ "64bit"/p10404530_112030_Linux-x86-64_1of7.zip -d /u01/
        unzip "$dbSoftPath/oracle$dbVersion"\ "64bit"/p10404530_112030_Linux-x86-64_2of7.zip -d /u01/
        unzip "$dbSoftPath/oracle$dbVersion"\ "64bit"/p10404530_112030_Linux-x86-64_3of7.zip -d /u01/app/grid/product/11/grid_1

        cd /u01/app/grid/product/11/grid_1/grid/rpm
        rpm -ivh cvuqdisk-1.0.9-1.rpm
        
        cp /u01/app/grid/product/11/grid_1/grid/response/grid_install.rsp /u01/grid.rsp
fi
if [ $dbVersion = '11.2.0.4' ]
then
        unzip "$dbSoftPath/oracle$dbVersion"\ "64bit"/p13390677_112040_Linux-x86-64_1of7.zip -d /u01/
        unzip "$dbSoftPath/oracle$dbVersion"\ "64bit"/p13390677_112040_Linux-x86-64_2of7.zip -d /u01/
        unzip "$dbSoftPath/oracle$dbVersion"\ "64bit"/p13390677_112040_Linux-x86-64_3of7.zip -d /u01/app/grid/product/11/grid_1

        cd /u01/app/grid/product/11/grid_1/grid/rpm
        rpm -ivh cvuqdisk-1.0.9-1.rpm
        
        cp /u01/app/grid/product/11/grid_1/grid/response/grid_install.rsp /u01/grid.rsp
fi
echo "write grid response file.........................."
sed -i "s|ORACLE_HOSTNAME=|ORACLE_HOSTNAME=$(hostname -s)|g" /u01/grid.rsp
sed -i "s|ORACLE_HOME=|ORACLE_HOME=/u01/app/grid/product/11/grid_1|g" /u01/grid.rsp
sed -i "s|INVENTORY_LOCATION.*|INVENTORY_LOCATION=/u01/app/oraInventory|g" /u01/grid.rsp
sed -i "s|oracle.install.option.*|oracle.install.option=HA_CONFIG|g" /u01/grid.rsp
sed -i "s|ORACLE_BASE.*|ORACLE_BASE=/u01/app/grid|g" /u01/grid.rsp
sed -i "s|oracle.install.asm.OSDBA.*|oracle.install.asm.OSDBA=asmdba|g" /u01/grid.rsp
sed -i "s|oracle.install.asm.OSOPER.*|oracle.install.asm.OSOPER=asmoper|g" /u01/grid.rsp
sed -i "s|oracle.install.asm.OSASM.*|oracle.install.asm.OSASM=asmadmin|g" /u01/grid.rsp
sed -i "s|oracle.install.asm.SYSASMPassword.*|oracle.install.asm.SYSASMPassword=Welcome1|g" /u01/grid.rsp
sed -i "s|oracle.install.asm.diskGroup.name.*|oracle.install.asm.diskGroup.name=DATA|g" /u01/grid.rsp
sed -i "s|oracle.install.asm.diskGroup.redundancy.*|oracle.install.asm.diskGroup.redundancy=NORMAL|g" /u01/grid.rsp
sed -i "s|oracle.install.asm.diskGroup.disks=|oracle.install.asm.diskGroup.disks=/dev/asmdisk/DATADISK01,/dev/asmdisk/DATADISK02,/dev/asmdisk/DATADISK03|g" /u01/grid.rsp
sed -i "s|oracle.install.asm.diskGroup.diskDiscoveryString=|oracle.install.asm.diskGroup.diskDiscoveryString=/dev/asmdisk/|g" /u01/grid.rsp
sed -i "s|oracle.install.asm.monitorPassword.*|oracle.install.asm.monitorPassword=Welcome1|g" /u01/grid.rsp

echo "write db response file.........................."
cp /u01/database/response/db_install.rsp /u01/dbinstall.rsp
sed -i "s|oracle.install.db.DBA_GROUP.*|oracle.install.db.DBA_GROUP=dba|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.OPER_GROUP.*|oracle.install.db.OPER_GROUP=oper|g" /u01/dbinstall.rsp
sed -i "s|ORACLE_HOSTNAME.*|ORACLE_HOSTNAME=$(hostname -s)|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.option.*|oracle.install.option=INSTALL_DB_SWONLY|g" /u01/dbinstall.rsp
sed -i "s|UNIX_GROUP_NAME.*|UNIX_GROUP_NAME=oinstall|g" /u01/dbinstall.rsp
sed -i "s|INVENTORY_LOCATION.*|INVENTORY_LOCATION=/u01/app/oraInventory|g" /u01/dbinstall.rsp
sed -i "s|ORACLE_HOME.*|ORACLE_HOME=/u01/app/oracle/product/11/db_1|g" /u01/dbinstall.rsp
sed -i "s|ORACLE_BASE.*|ORACLE_BASE=/u01/app/oracle|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.InstallEdition.*|oracle.install.db.InstallEdition=EE|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.config.starterdb.type.*|oracle.install.db.config.starterdb.type=GENERAL_PURPOSE|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.config.starterdb.memoryLimit.*|oracle.install.db.config.starterdb.memoryLimit=512|g" /u01/dbinstall.rsp
sed -i "s|oracle.install.db.config.starterdb.password.ALL.*|oracle.install.db.config.starterdb.password.ALL=welcome1|g" /u01/dbinstall.rsp
sed -i "s|SECURITY_UPDATES_VIA_MYORACLESUPPORT.*|SECURITY_UPDATES_VIA_MYORACLESUPPORT=false|g" /u01/dbinstall.rsp
sed -i "s|DECLINE_SECURITY_UPDATES.*|DECLINE_SECURITY_UPDATES=true|g" /u01/dbinstall.rsp

echo "write configToolAllCommands response file.........................."
echo "oracle.assistants.asm|S_ASMPASSWORD=Welcome1
oracle.assistants.asm|S_ASMMONITORPASSWORD=Welcome1
oracle.crs|S_BMCPASSWORD=Welcome1
        " > /u01/cfgrsp.properties

chown -R grid:oinstall /u01
chown -R grid:oinstall /u01/app/grid
chown -R oracle:oinstall /u01/app/oracle
chmod -R 775 /u01/

####################### install grid and db software ###############################
su - grid -c "yes | \$ORACLE_HOME/grid/runInstaller -silent -responseFile /u01/grid.rsp"
echo $?
if [ $? -eq 0 ]; then
        echo "Execute Configuration Scripts............................."
        /u01/app/oraInventory/orainstRoot.sh
        echo "
while true
do
        if [ -e "/var/tmp/.oracle/npohasd" ]
        then
                break;
        fi
done
dd if=/var/tmp/.oracle/npohasd of=/dev/nullbs=1024 count=1
        " > /root/1.sh
                
        touch /root/out.txt
        echo "
while true
do
		ps -ef | grep root.sh | grep -v grep > /root/out.txt
        if [ \$? -eq 0 ]
        then
                continue
        else
                break
        fi
done
kill -9 \$(ps -ef | grep \"dd if\" | grep -v grep | awk '{print \$2}')
        " > /root/2.sh
				
        chmod +x /root/1.sh /root/2.sh
        /u01/app/grid/product/11/grid_1/root.sh & bash /root/1.sh & bash /root/2.sh
        sleep 10s
        su - grid -c "\$ORACLE_HOME/cfgtoollogs/configToolAllCommands RESPONSE_FILE=/u01/cfgrsp.properties"
        echo "grid install suc ........................."
                
        echo "db install start..........................."
        su - oracle -c "/u01/database/runInstaller -ignoreSysPrereqs -ignorePrereq -invPtrLoc /u01/app/oraInventory/oraInst.loc -force -silent -waitforcompletion -responseFile /u01/dbinstall.rsp"
        if [ $? -eq 0 ]; then
                /u01/app/oracle/product/11/db_1/root.sh
                echo "db install suc................."
                if [ $dbVersion = '11.2.0.1' ]; then
                        echo "
su - grid -c \"sqlplus / as sysasm<<EOF
shutdown immediate
startup
EOF
\" " > /root/3.sh
                        chmod +x /root/3.sh
                        bash /root/3.sh
                fi
                echo "dbca.................."
                su - oracle -c "dbca -createDatabase -gdbName orcl -sid orcl -templateName General_Purpose.dbc -datafileDestination DATA/ -storageType ASM -diskGroupName DATA -sysPassword Welcome1 -systemPassword Welcome1 -asmsnmpPassword Welcome1 -responseFile NO_VALUE -characterset AL32UTF8 -nationalCharacterSet UTF8 -memoryPercentage 40 -silent"
                if [ $? -eq 0 ]; then
                        echo "dbca suc....................."
                else
                        echo "dbca fail......................"
                        exit 1
                fi
        else
                echo "db install fail................."
                exit 1
        fi
else
        echo "grid install fail ........................."
        exit 1
fi
```

## setupOracle11gADGEnv2.sh

```sh
#!/bin/bash

node1=$1
node2=$2
flag=$3

echo $flag
echo $node1
echo $node2

####################### define related 11g installation destination and layer ###############################
dbTopDir=/u01
oracleSid=orcl
oracleBase=/u01/app/oracle
oracleHome=/u01/app/oracle/product/11/db_1
oracleInventory=/u01/app/oraInventory
oracleData=/u01/app/oracle/oradata

####################### setup and configure 11g db ###############################
if [ $flag -eq 1 ]; then
    su - oracle -c "dbca -createDatabase -templateName General_Purpose.dbc -gdbName $oracleSid -sid $oracleSid -sysPassword Welcome1 -systemPassword Welcome1 -emConfiguration LOCAL -dbsnmpPassword Welcome1 -sysmanPassword Welcome1 -datafileJarLocation \$ORACLE_HOME/assistants/dbca/templates -storageType FS -datafileDestination $oracleData -responseFile NO_VALUE -characterset AL32UTF8 -totalMemory 1638 -obfuscatedPasswords false -sampleSchema true -oratabLocation ORATAB -recoveryAreaDestination NO_VALUE -silent"
    su - oracle -c "sqlplus / as sysdba <<\"EOF\"
select name,log_mode,force_logging from v\$database;
alter database force logging;
select name,log_mode,force_logging from v\$database;
exit;
EOF"
    su - oracle -c "cd $ORACLE_HOME/dbs;orapwd file=orapworcl password=oracle force=y;"
    sshpass -p Welcome1 scp -o StrictHostKeyChecking=no /u01/app/oracle/product/11/db_1/dbs/orapworcl oracle@$node2:/u01/app/oracle/product/11/db_1/dbs/orapwstd
    
    su - oracle -c "mkdir -p /u01/app/oracle/oradata/standbylog"
    su - oracle -c "sqlplus / as sysdba <<\"EOF\"
col member for a50
select group#,member from v\$logfile;
alter database add standby logfile group 4 '/u01/app/oracle/oradata/standbylog/std_redo04.log' size 50m;
alter database add standby logfile group 5 '/u01/app/oracle/oradata/standbylog/std_redo05.log' size 50m;
alter database add standby logfile group 6 '/u01/app/oracle/oradata/standbylog/std_redo06.log' size 50m;
alter database add standby logfile group 7 '/u01/app/oracle/oradata/standbylog/std_redo07.log' size 50m;
select group#,sequence#,status, bytes/1024/1024 from v\$standby_log;
set pagesize 100
col member for a60
select group#,member from v\$logfile order by group#;
EOF"
    su - oracle -c "sqlplus / as sysdba <<\"EOF\"
show parameter spfile;
create pfile from spfile;
EOF"
    echo "*.db_unique_name='orcl'
*.log_archive_config='dg_config=(orcl,std)'
*.log_archive_dest_1='location=/u01/app/oracle/arch valid_for=(all_logfiles,all_roles) db_unique_name=orcl'
*.log_archive_dest_2='service=std valid_for=(online_logfiles,primary_role) db_unique_name=std'
*.log_archive_dest_state_1=enable
*.log_archive_dest_state_2=enable
*.log_archive_max_processes=4
*.fal_server='std'
*.fal_client='orcl'
*.db_file_name_convert='/u01/app/oracle/oradata/std','/u01/app/oracle/oradata/orcl'
*.log_file_name_convert='/u01/app/oracle/oradata/std','/u01/app/oracle/oradata/orcl'
*.standby_file_management='auto'
    " >> /u01/app/oracle/product/11/db_1/dbs/initorcl.ora
    
    su - oracle -c "mkdir -p /u01/app/oracle/arch"
    su - oracle -c "sqlplus / as sysdba <<\"EOF\"
shutdown immediate;
create spfile from pfile;
startup mount;
alter database archivelog;
alter database open;
archive log list;
show parameter spfile;
select name,log_mode,force_logging from v\$database;
EOF"

    echo "
# listener.ora Network Configuration File: /u01/app/oracle/product/11/db_1/network/admin/listener.ora
# Generated by Oracle configuration tools.

LISTENER =
  (DESCRIPTION_LIST =
    (DESCRIPTION =
      (ADDRESS = (PROTOCOL = TCP)(HOST = $node1)(PORT = 1521))
      (ADDRESS = (PROTOCOL = IPC)(KEY = EXTPROC1521))
    )
  )

SID_LIST_LISTENER =
  (SID_LIST =
    (SID_DESC =
      (GLOBAL_DBNAME = orcl)
      (ORACLE_HOME = /u01/app/oracle/product/11/db_1)
      (SID_NAME = orcl)
    )
  )

ADR_BASE_LISTENER = /u01/app/oracle
    " >> /u01/app/oracle/product/11/db_1/network/admin/listener.ora
    
    sshpass -p Welcome1 scp -o StrictHostKeyChecking=no /u01/app/oracle/product/11/db_1/network/admin/listener.ora oracle@$node2:/u01/app/oracle/product/11/db_1/network/admin/listener.ora
    su - oracle -c "lsnrctl stop;lsnrctl start"
    
    echo "
# tnsnames.ora Network Configuration File: /u01/app/oracle/product/11/db_1/network/admin/tnsnames.ora
# Generated by Oracle configuration tools.

orcl =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = $node1)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = orcl)
    )
  )

std =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = $node2)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = std)
    )
  )
    " >> /u01/app/oracle/product/11/db_1/network/admin/tnsnames.ora 
    
    sshpass -p Welcome1 scp -o StrictHostKeyChecking=no /u01/app/oracle/product/11/db_1/network/admin/tnsnames.ora oracle@$node2:/u01/app/oracle/product/11/db_1/network/admin/tnsnames.ora
    sshpass -p Welcome1 scp -o StrictHostKeyChecking=no /u01/app/oracle/product/11/db_1/dbs/initorcl.ora oracle@$node2:/u01/app/oracle/product/11/db_1/dbs/initstd.ora

else
    sed -i "s|HOST =.*|HOST = $node2)(PORT = 1521))|g" /u01/app/oracle/product/11/db_1/network/admin/listener.ora
    sed -i "s|GLOBAL_DBNAME = orcl|GLOBAL_DBNAME = std|g" /u01/app/oracle/product/11/db_1/network/admin/listener.ora
    sed -i "s|SID_NAME = orcl|SID_NAME = std|g" /u01/app/oracle/product/11/db_1/network/admin/listener.ora
    su - oracle -c "lsnrctl start"
    
    sed -i "s|audit_file_dest.*|audit_file_dest='/u01/app/oracle/admin/std/adump'|g" /u01/app/oracle/product/11/db_1/dbs/initstd.ora
    sed -i "s|control_files.*|control_files='/u01/app/oracle/oradata/std/control01.ctl','/u01/app/oracle/fast_recovery_area/std/control02.ctl'|g" /u01/app/oracle/product/11/db_1/dbs/initstd.ora
    sed -i "s|SERVICE=.*|SERVICE=stdXDB)'|g" /u01/app/oracle/product/11/db_1/dbs/initstd.ora
    sed -i "s|db_unique_name='orcl'|db_unique_name='std'|g" /u01/app/oracle/product/11/db_1/dbs/initstd.ora
    sed -i "s|db_unique_name=orcl'|db_unique_name=std'|g" /u01/app/oracle/product/11/db_1/dbs/initstd.ora
    sed -i "s|log_archive_dest_2=.*|log_archive_dest_2='service=orcl valid_for=(online_logfiles,primary_role) db_unique_name=orcl'|g" /u01/app/oracle/product/11/db_1/dbs/initstd.ora
    sed -i "s|fal_server='std'|fal_server='orcl'|g" /u01/app/oracle/product/11/db_1/dbs/initstd.ora
    sed -i "s|fal_client='orcl'|fal_client='std'|g" /u01/app/oracle/product/11/db_1/dbs/initstd.ora
    sed -i "s|db_file_name_convert=.*|db_file_name_convert='/u01/app/oracle/oradata/orcl','/u01/app/oracle/oradata/std'|g" /u01/app/oracle/product/11/db_1/dbs/initstd.ora
    sed -i "s|log_file_name_convert=.*|log_file_name_convert='/u01/app/oracle/oradata/orcl','/u01/app/oracle/oradata/std'|g" /u01/app/oracle/product/11/db_1/dbs/initstd.ora

    su - oracle -c "mkdir -pv /u01/app/oracle/admin/std/adump"
    su - oracle -c "mkdir -pv /u01/app/oracle/diag/rdbms/std/std/trace"
    su - oracle -c "mkdir -pv /u01/app/oracle/arch"
    su - oracle -c "mkdir -pv /u01/app/oracle/oradata/std"
    su - oracle -c "mkdir -pv /u01/app/oracle/oradata/standbylog"
    su - oracle -c "mkdir -pv /u01/app/oracle/fast_recovery_area/std"
    
    su - oracle -c "sqlplus / as sysdba <<\"EOF\"
create spfile from pfile;
startup nomount;
quit;
EOF"

fi

```

## setupOracle11gADGEnv.sh

```sh
#!/bin/bash

dbSoftPath=$1
dbVersion=$2
flag=$3

echo $dbSoftPath
echo $dbVersion
echo $flag

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


####################### define related 11g installation destination and layer ###############################
dbTopDir=/u01
oracleSid=orcl
oracleBase=/u01/app/oracle
oracleHome=/u01/app/oracle/product/11/db_1
oracleInventory=/u01/app/oraInventory
oracleData=/u01/app/oracle/oradata


####################### prepare related system account and packages ###############################
groupadd oinstall
groupadd -g 502 dba
groupadd -g 503 oper
useradd -u 502 -g oinstall -G dba,oper oracle
echo Welcome1|passwd --stdin oracle

yum -y install binutils compat-libcap1 compat-libstdc++-33 gcc gcc-c++ glibc glibc-devel ksh libaio libaio-devel libgcc libstdc++ libstdc++-devel libXi libXtst make sysstat unixODBC unixODBC-devel


####################### adjust related system seting ###############################
echo "
fs.aio-max-nr = 1048576
fs.file-max = 6815744
kernel.shmall = 2097152
kernel.shmmax  = 536870912
kernel.shmmni = 4096
kernel.sem = 250 32000 100 128
net.ipv4.ip_local_port_range = 9000 65500
net.core.rmem_default = 262144
net.core.rmem_max = 4194304
net.core.wmem_default = 262144
net.core.wmem_max = 1048576
">> /etc/sysctl.conf
sysctl -p
echo "
oracle    soft    nproc    2047
oracle    hard    nproc    16384
oracle    soft    nofile    1024
oracle    hard    nofile    65536
oracle    soft    stack    10240
">> /etc/security/limits.conf
echo "
if [ \$USER = "oracle" ]; then
   if [ $SHELL = "/bin/ksh" ]; then
       ulimit -p 16384
       ulimit -n 65536
    else
       ulimit -u 16384 -n 65536
   fi
   umask 022
fi
">> /etc/profile

echo "
export ORACLE_BASE=$oracleBase
export ORACLE_HOME=$oracleHome
export ORACLE_SID=
export PATH=\$ORACLE_HOME/bin:/usr/sbin:\$PATH
export LD_LIBRARY_PATH=\$ORACLE_HOME/lib:\$ORACLE_HOME/bin:/bin:/usr/bin:/usr/local/bin
export CLASSPATH=\$ORACLE_HOME/JRE:\$ORACLE_HOME/jlib:\$ORACLE_HOME/rdbms/jlib
">> /home/oracle/.bash_profile

if [ $flag -eq 1 ]; then
    sed -i "s|ORACLE_SID.*|ORACLE_SID=orcl|g" /home/oracle/.bash_profile
else
    sed -i "s|ORACLE_SID.*|ORACLE_SID=std|g" /home/oracle/.bash_profile
fi

source /home/oracle/.bash_profile
chmod -R 755 /home/oracle;chown -R oracle:oinstall /home/oracle/

echo "
export ORACLE_BASE=$oracleBase
export ORACLE_HOME=$oracleHome
export ORACLE_SID=$oracleSid
export PATH=\$ORACLE_HOME/bin:/usr/sbin:$PATH
export LD_LIBRARY_PATH=\$ORACLE_HOME/lib
">> /root/.bash_profile
source /root/.bash_profile

useradd -g oinstall -G dba,oper -m renl

cp /root/.bash_profile /home/renl
source /home/renl/.bash_profile

####################### prepare 11g binary and response file ###############################
mkfs.xfs /dev/sdd
mkdir $dbTopDir
mount /dev/sdd $dbTopDir
echo "/dev/sdd /u01 ext4 defaults 0 0" >> /etc/fstab

if [ $dbVersion = '11.2.0.4' ]; then
    unzip "$dbSoftPath/oracle$dbVersion"\ "64bit"/p13390677_112040_Linux-x86-64_1of7.zip -d $dbTopDir
    unzip "$dbSoftPath/oracle$dbVersion"\ "64bit"/p13390677_112040_Linux-x86-64_2of7.zip -d $dbTopDir
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
sed -i "s|oracle.install.db.DBA_GROUP.*|oracle.install.db.DBA_GROUP=dba|g" $dbTopDir/dbinstall.rsp
sed -i "s|oracle.install.db.OPER_GROUP.*|oracle.install.db.OPER_GROUP=oper|g" $dbTopDir/dbinstall.rsp
sed -i "s|oracle.install.db.config.starterdb.type.*|oracle.install.db.config.starterdb.type=GENERAL_PURPOSE|g" $dbTopDir/dbinstall.rsp
sed -i "s|SECURITY_UPDATES_VIA_MYORACLESUPPORT.*|SECURITY_UPDATES_VIA_MYORACLESUPPORT=false|g" $dbTopDir/dbinstall.rsp
sed -i "s|DECLINE_SECURITY_UPDATES.*|DECLINE_SECURITY_UPDATES=true|g" $dbTopDir/dbinstall.rsp
sed -i "s|oracle.installer.autoupdates.option.*|oracle.installer.autoupdates.option=SKIP_UPDATES|g" $dbTopDir/dbinstall.rsp

chown -R oracle:oinstall $dbTopDir
chmod 755 -R $dbTopDir


####################### setup and configure 11g db ###############################
echo "Trying to install oracle 11g..............."
su - oracle -c "$dbTopDir/database/runInstaller -ignoreSysPrereqs -ignorePrereq -invPtrLoc $oracleInventory/oraInst.loc -force -silent -waitforcompletion -responseFile $dbTopDir/dbinstall.rsp"
if [ $? -eq 0 ]; then
    echo "Trying to run $oracleHome/root.sh..............."
    $oracleHome/root.sh
else
    echo db installation with failure
    exit 1
fi

```

## setupOracle10gEnv.sh

```sh
#!/bin/bash

dbSoftPath=$1
dbVersion=$2

echo $dbSoftPath
echo $dbVersion
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


####################### prepare related system account and packages ###############################
groupadd -g 1000 oinstall
groupadd -g 1001 dba
useradd -g oinstall -G dba -d /home/oracle -s /bin/bash -c "Oracle Software Owner" -m oracle

mkfs.xfs /dev/sdd
mkdir /u01
mount /dev/sdd /u01
echo "/dev/sdd /u01 ext4 defaults 0 0" >> /etc/fstab

mkdir -p /u01/app/oracle/product/10/db_1

##yum -y install binutils compat-libstdc++-33 compat-libstdc++-33.i686 elfutils-libelf elfutils-libelf-devel gcc gcc-c++ glibc glibc.i686 glibc-common glibc-devel glibc-devel.i686 glibc-headers ksh libaio libaio.i686 libaio-devel libaio-devel.i686 libgcc libgcc.i686 libstdc++ libstdc++.i686 libstdc++-devel make sysstat  libXp libXt.i686 libXtst.i686 libXp.i686

####################### adjust related system seting ###############################
echo "
net.ipv4.icmp_echo_ignore_broadcasts = 1
net.ipv4.conf.all.rp_filter = 1
fs.file-max = 6815744
fs.aio-max-nr = 1048576
kernel.shmall = 2097152
kernel.shmmax = 2061584302
kernel.shmmni = 4096
kernel.sem = 250 32000 100 128
net.ipv4.ip_local_port_range = 9000 65500
net.core.rmem_default = 262144
net.core.rmem_max= 4194304
net.core.wmem_default= 262144
net.core.wmem_max= 1048576
vm.hugetlb_shm_group=1001
">> /etc/sysctl.conf
sysctl -p

echo "
oracle soft nproc 2047
oracle hard nproc 16384
oracle soft nofile 1024
oracle hard nofile 65536
" >> /etc/security/limits.conf

echo "
session required /lib64/security/pam_limits.so
session required pam_limits.so
" >> /etc/pam.d/login

echo "
if [ $USER = "oracle" ]; then
    if [ $SHELL = "/bin/ksh" ]; then
        ulimit -p 16384
        ulimit -n 65536
    else
        ulimit -u 16384 -n 65536
    fi
fi
">> /etc/profile

echo "
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=\$ORACLE_BASE/product/10/db_1
export ORACLE_SID=orcl
export LD_LIBRARY_PATH=\$ORACLE_HOME/lib
export PATH=\$PATH:\$ORACLE_HOME/bin:\$HOME/bin
">> /home/oracle/.bash_profile
source /home/oracle/.bash_profile
chmod -R 755 /home/oracle
chown -R oracle:oinstall /home/oracle/

echo "
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=\$ORACLE_BASE/product/10/db_1
export ORACLE_SID=orcl
export LD_LIBRARY_PATH=\$ORACLE_HOME/lib
export PATH=\$PATH:\$ORACLE_HOME/bin:\$HOME/bin
">> /root/.bash_profile
source /root/.bash_profile

useradd -g oinstall -G dba -m renl
mkdir -p /home/renl
cp /root/.bash_profile /home/renl
source /home/renl/.bash_profile

####################### prepare 10g binary and response file ###############################
gunzip -c $dbSoftPath/10201_database_linux_x86_64.cpio.gz > /u01/10201_database_linux_x86_64.cpio
cd /u01
cpio -idmv </u01/10201_database_linux_x86_64.cpio

unzip $dbSoftPath/12.2.0.1_Linux_x86.64/instantclient-basic-linux.x64-12.2.0.1.0.zip -d /u01

if [ $dbVersion = '10.2.0.5' ]
then
    unzip $dbSoftPath/p8202632_10205_Linux-x86-64.zip -d /u01
    cp /u01/Disk1/response/patchset.rsp /u01/patchset.rsp
    sed -i "s|UNIX_GROUP_NAME.*|UNIX_GROUP_NAME=oinstall|g" /u01/patchset.rsp
    sed -i "s|ORACLE_HOME=.*|ORACLE_HOME=/u01/app/oracle/product/10/db_1|g" /u01/patchset.rsp
    sed -i "s|ORACLE_HOME_NAME.*|ORACLE_HOME_NAME=OraDb10g_home1|g" /u01/patchset.rsp
    sed -i "s|ORACLE_HOSTNAME.*|ORACLE_HOSTNAME=$(hostname -s)|g" /u01/patchset.rsp
    sed -i "s|SECURITY_UPDATES_VIA_MYORACLESUPPORT.*|SECURITY_UPDATES_VIA_MYORACLESUPPORT=false|g" /u01/patchset.rsp
    sed -i "s|DECLINE_SECURITY_UPDATES.*|DECLINE_SECURITY_UPDATES=true|g" /u01/patchset.rsp
    echo "INSTALL_TYPE=\"EE\"" >> /u01/patchset.rsp
fi
cp /u01/database/response/enterprise.rsp /u01/dbinstall.rsp

sed -i "s|UNIX_GROUP_NAME.*|UNIX_GROUP_NAME=oinstall|g" /u01/dbinstall.rsp
sed -i "s|ORACLE_HOME=.*|ORACLE_HOME=/u01/app/oracle/product/10/db_1|g" /u01/dbinstall.rsp
sed -i "s|ORACLE_HOME_NAME.*|ORACLE_HOME_NAME=OraDb10g_home1|g" /u01/dbinstall.rsp
sed -i "s|ORACLE_HOSTNAME.*|ORACLE_HOSTNAME=$(hostname -s)|g" /u01/dbinstall.rsp
sed -i "s|s_nameForDBAGrp.*|s_nameForDBAGrp=dba|g" /u01/dbinstall.rsp
sed -i "s|s_nameForOPERGrp.*|s_nameForOPERGrp=dba|g" /u01/dbinstall.rsp
sed -i "s|s_dbRetChar.*|s_dbRetChar=AL32UTF8|g" /u01/dbinstall.rsp
sed -i "s|n_configurationOption.*|n_configurationOption=3|g" /u01/dbinstall.rsp

chown -R oracle:oinstall /u01
chmod 755 -R /u01

####################### setup and configure 10g db ###############################
echo "Trying to install oracle 10g client..............."

echo "Trying to install oracle 10g..............."
su - oracle -c "/u01/database/runInstaller -ignoresysprereqs -force -silent -waitforcompletion -responseFile /u01/dbinstall.rsp > /u01/out.txt"
echo $?
if [ $? -eq 0 ]; then
    echo "db install suc..............."
    /u01/app/oracle/oraInventory/orainstRoot.sh
    /u01/app/oracle/product/10/db_1/root.sh
    echo "Trying to dbca..............."

    su - oracle -c "dbca -silent -createDatabase -templateName General_Purpose.dbc -gdbName orcl -sid orcl \
    -sysPassword Welcome1 -systemPassword Welcome1 -sysmanPassword Welcome1 -dbsnmpPassword Welcome1 \
    -emConfiguration LOCAL -datafileJarLocation \$ORACLE_HOME/assistants/dbca/templates \
    -storageType FS -datafileDestination /u01/app/oracle/oradata \
    -characterset AL32UTF8 -obfuscatedPasswords false -sampleSchema true \
    -oratabLocation \$ORACLE_HOME/install/oratab"
    
    if [ $? -eq 0 ]; then
        su - oracle -c "lsnrctl start"
        echo "dbca suc....................."
        if [ $dbVersion = '10.2.0.1' ]; then
            exit 0
        elif [ $dbVersion = '10.2.0.5' ]; then
            echo "Trying to close oracle....................."
            su - oracle -c "emctl stop dbconsole;isqlplusctl stop;lsnrctl stop"
            su - oracle -c "sqlplus / as sysdba<<EOF
shutdown immediate;
EOF"
            sleep 5s
            echo "Trying to install 10.2.0.5................."
            su - oracle -c "/u01/Disk1/runInstaller -ignoreSysPrereqs -force -silent -waitforcompletion -responseFile /u01/patchset.rsp"
            echo $?
            if [ $? -eq 0 ]; then
                echo "Trying to run scripts......................"
                echo "



" | /u01/app/oracle/product/10/db_1/root.sh
                su - oracle -c "sqlplus / as sysdba<<EOF
startup upgrade
SPOOL upgrade_info.log
@?/rdbms/admin/utlu102i.sql
SPOOL OFF
update registry\\\$ set prv_version='10.2.0.5' where cid='CATPROC';
commit;
EOF"
                su - oracle -c "sqlplus / as sysdba<<EOF
SPOOL patch.log
@?/rdbms/admin/catupgrd.sql
SPOOL OFF
@?/rdbms/admin/utlrp.sql
COL COMP_NAME FOR A50
COL VERSION FOR A12
COL STATUS FOR A12
SELECT COMP_NAME, VERSION, STATUS FROM SYS.DBA_REGISTRY;
EOF"
                su - oracle -c "sqlplus / as sysdba<<EOF
SELECT COMP_NAME, VERSION, STATUS FROM SYS.DBA_REGISTRY;
EOF" > /root/out2.txt

                count=$(cat /root/out2.txt |grep "VALID" |wc -l)
                if [ $count -eq 17 ]; then
                    echo "upgrade suc..........."
                    su - oracle -c "sqlplus / as sysdba<<EOF
shutdown immediate;
startup;
EOF"
                    su - oracle -c "lsnrctl start"
                    exit 0
                else
                    echo upgrade with failures
                    exit 1
                fi
            else
                echo oracle10.2.0.5 install with failures
            fi
        fi
    else
        echo dbca with failures
        exit 1
    fi
else
    echo db installation with failure
    exit 1
fi
```

## setupOracle10gASMEnv.sh

```sh
#!/bin/bash

dbSoftPath=$1
dbVersion=$2

echo $dbSoftPath
echo $dbVersion

groupadd -g 1000 oinstall
groupadd -g 1001 dba
useradd -g oinstall -G dba -d /home/oracle -s /bin/bash -c "Oracle Software Owner" -m oracle

mkfs.xfs /dev/sdd
mkdir /u01
mount /dev/sdd /u01
echo "/dev/sdd /u01 ext4 defaults 0 0" >> /etc/fstab

mkdir -p /u01/app/oracle/product/10/db_1


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

echo "n



34952988
n



69904156
n



104855324
w" | fdisk /dev/sde


localip=$(cat /etc/sysconfig/network-scripts/ifcfg-ens160 | grep IPADDR | tr -d "IPADDR=")
echo $localip

lsblk
yum -y install targetcli
systemctl enable target
systemctl restart target

targetcli /backstores/block create serversde1 /dev/sde1
targetcli /backstores/block create serversde2 /dev/sde2
targetcli /backstores/block create serversde3 /dev/sde3

targetcli /iscsi create iqn.2020-12.info2soft.com:racasm
targetcli /iscsi/iqn.2020-12.info2soft.com:racasm/tpg1/acls create iqn.2020-12.info2soft.com:rac1

targetcli /iscsi/iqn.2020-12.info2soft.com:racasm/tpg1/luns create /backstores/block/serversde1
targetcli /iscsi/iqn.2020-12.info2soft.com:racasm/tpg1/luns create /backstores/block/serversde2
targetcli /iscsi/iqn.2020-12.info2soft.com:racasm/tpg1/luns create /backstores/block/serversde3

targetcli / saveconfig

sed -i "s/InitiatorName=.*/InitiatorName=iqn.2020-12.info2soft.com:rac1/g" /etc/iscsi/initiatorname.iscsi
systemctl restart iscsi
systemctl status iscsi
iscsiadm -m discovery -t st -p $localip
iscsiadm -m node -T iqn.2020-12.info2soft.com:racasm -p $localip:3260 -l
lsscsi -ds

echo "
KERNEL==\"sd*\", SUBSYSTEM==\"block\", PROGRAM==\"/usr/lib/udev/scsi_id --whitelisted --replace-whitespace --device=/dev/\$name\", RESULT==\"$(/usr/lib/udev/scsi_id -g -u -d /dev/sdf)\", SYMLINK+=\"asmdisk/DATADISK01\", OWNER=\"oracle\", GROUP=\"dba\", MODE=\"0660\"
KERNEL==\"sd*\", SUBSYSTEM==\"block\", PROGRAM==\"/usr/lib/udev/scsi_id --whitelisted --replace-whitespace --device=/dev/\$name\", RESULT==\"$(/usr/lib/udev/scsi_id -g -u -d /dev/sdg)\", SYMLINK+=\"asmdisk/DATADISK02\", OWNER=\"oracle\", GROUP=\"dba\", MODE=\"0660\"
KERNEL==\"sd*\", SUBSYSTEM==\"block\", PROGRAM==\"/usr/lib/udev/scsi_id --whitelisted --replace-whitespace --device=/dev/\$name\", RESULT==\"$(/usr/lib/udev/scsi_id -g -u -d /dev/sdh)\", SYMLINK+=\"asmdisk/DATADISK03\", OWNER=\"oracle\", GROUP=\"dba\", MODE=\"0660\"
">> /etc/udev/rules.d/99-oracle-asmdevices.rules

/sbin/udevadm control --reload-rules
/sbin/udevadm trigger --type=devices --action=change

count=`ls /dev/asmdisk/ | wc -w`
until [ $count -eq 3 ]
do
    /sbin/udevadm control --reload-rules
    /sbin/udevadm trigger --type=devices --action=change
    count=`ls /dev/asmdisk/ | wc -w`
done
echo $count

str=`ls -lh /dev/sdf`
str=${str//" "/ }
arr=($str)
echo ${arr[2]}
until [ "${arr[2]}" = "oracle" ]
do
	/sbin/udevadm control --reload-rules
	/sbin/udevadm trigger --type=devices --action=change
	str=`ls -lh /dev/sdf`
	str=${str//" "/ }
	arr=($str)
done
echo ${arr[2]}


####################### prepare related system account and packages ###############################

yum -y install binutils compat-libstdc++-33 compat-libstdc++-33.i686 elfutils-libelf elfutils-libelf-devel gcc gcc-c++ glibc glibc.i686 glibc-common glibc-devel glibc-devel.i686 glibc-headers ksh libaio libaio.i686 libaio-devel libaio-devel.i686 libgcc libgcc.i686 libstdc++ libstdc++.i686 libstdc++-devel make sysstat  libXp libXt.i686 libXtst.i686 libXp.i686

####################### adjust related system seting ###############################
echo "
net.ipv4.icmp_echo_ignore_broadcasts = 1
net.ipv4.conf.all.rp_filter = 1
fs.file-max = 6815744
fs.aio-max-nr = 1048576
kernel.shmall = 2097152
kernel.shmmax = 2061584302
kernel.shmmni = 4096
kernel.sem = 250 32000 100 128
net.ipv4.ip_local_port_range = 9000 65500
net.core.rmem_default = 262144
net.core.rmem_max= 4194304
net.core.wmem_default= 262144
net.core.wmem_max= 1048576
vm.hugetlb_shm_group=1001
">> /etc/sysctl.conf
sysctl -p

echo "
oracle soft nproc 2047
oracle hard nproc 16384
oracle soft nofile 1024
oracle hard nofile 65536
" >> /etc/security/limits.conf

echo "
session required /lib64/security/pam_limits.so
session required pam_limits.so
" >> /etc/pam.d/login

echo "
if [ $USER = "oracle" ]; then
    if [ $SHELL = "/bin/ksh" ]; then
        ulimit -p 16384
        ulimit -n 65536
    else
        ulimit -u 16384 -n 65536
    fi
fi
">> /etc/profile

echo "
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=\$ORACLE_BASE/product/10/db_1
export ORACLE_SID=orcl
export LD_LIBRARY_PATH=\$ORACLE_HOME/lib
export PATH=\$PATH:\$ORACLE_HOME/bin:\$HOME/bin
">> /home/oracle/.bash_profile
source /home/oracle/.bash_profile
chmod -R 755 /home/oracle
chown -R oracle:oinstall /home/oracle/

echo "
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=\$ORACLE_BASE/product/10/db_1
export ORACLE_SID=orcl
export LD_LIBRARY_PATH=\$ORACLE_HOME/lib
export PATH=\$PATH:\$ORACLE_HOME/bin:\$HOME/bin
">> /root/.bash_profile
source /root/.bash_profile

useradd -g oinstall -G dba -m renl
mkdir -p /home/renl
cp /root/.bash_profile /home/renl
source /home/renl/.bash_profile

####################### prepare 10g binary and response file ###############################
gunzip -c $dbSoftPath/10201_database_linux_x86_64.cpio.gz > /u01/10201_database_linux_x86_64.cpio
cd /u01
cpio -idmv </u01/10201_database_linux_x86_64.cpio

if [ $dbVersion = '10.2.0.5' ]
then
    unzip $dbSoftPath/p8202632_10205_Linux-x86-64.zip -d /u01
    cp /u01/Disk1/response/patchset.rsp /u01/patchset.rsp
    sed -i "s|UNIX_GROUP_NAME.*|UNIX_GROUP_NAME=oinstall|g" /u01/patchset.rsp
    sed -i "s|ORACLE_HOME=.*|ORACLE_HOME=/u01/app/oracle/product/10/db_1|g" /u01/patchset.rsp
    sed -i "s|ORACLE_HOME_NAME.*|ORACLE_HOME_NAME=OraDb10g_home1|g" /u01/patchset.rsp
    sed -i "s|ORACLE_HOSTNAME.*|ORACLE_HOSTNAME=$(hostname -s)|g" /u01/patchset.rsp
    sed -i "s|SECURITY_UPDATES_VIA_MYORACLESUPPORT.*|SECURITY_UPDATES_VIA_MYORACLESUPPORT=false|g" /u01/patchset.rsp
    sed -i "s|DECLINE_SECURITY_UPDATES.*|DECLINE_SECURITY_UPDATES=true|g" /u01/patchset.rsp
    echo "INSTALL_TYPE=\"EE\"" >> /u01/patchset.rsp
fi
cp /u01/database/response/enterprise.rsp /u01/dbinstall.rsp

sed -i "s|UNIX_GROUP_NAME.*|UNIX_GROUP_NAME=oinstall|g" /u01/dbinstall.rsp
sed -i "s|ORACLE_HOME=.*|ORACLE_HOME=/u01/app/oracle/product/10/db_1|g" /u01/dbinstall.rsp
sed -i "s|ORACLE_HOME_NAME.*|ORACLE_HOME_NAME=OraDb10g_home1|g" /u01/dbinstall.rsp
sed -i "s|ORACLE_HOSTNAME.*|ORACLE_HOSTNAME=$(hostname -s)|g" /u01/dbinstall.rsp
sed -i "s|s_nameForDBAGrp.*|s_nameForDBAGrp=dba|g" /u01/dbinstall.rsp
sed -i "s|s_nameForOPERGrp.*|s_nameForOPERGrp=dba|g" /u01/dbinstall.rsp
sed -i "s|s_dbRetChar.*|s_dbRetChar=AL32UTF8|g" /u01/dbinstall.rsp
sed -i "s|n_configurationOption.*|n_configurationOption=3|g" /u01/dbinstall.rsp

chown -R oracle:oinstall /u01
chmod 755 -R /u01

####################### setup and configure 10g db ###############################
echo "Trying to install oracle 10g..............."
su - oracle -c "/u01/database/runInstaller -ignoresysprereqs -force -silent -waitforcompletion -responseFile /u01/dbinstall.rsp > /u01/out.txt"
echo $?
if [ $? -eq 0 ]; then
    echo "db install suc..............."
    /u01/app/oracle/oraInventory/orainstRoot.sh
    /u01/app/oracle/product/10/db_1/root.sh

    echo "
while true
do
    if [ -e "/etc/init.d/init.cssd" ]
    then
        break;
    fi
done
/etc/init.d/init.cssd run &
    " > /root/1.sh
    bash /root/1.sh & /u01/app/oracle/product/10/db_1/bin/localconfig add

    su - oracle -c "cat>>/u01/app/oracle/product/10/db_1/dbs/init+ASM.ora<<EOF
*.asm_diskstring='/dev/asmdisk/*'
*.background_dump_dest='/u01/app/oracle/admin/+ASM/bdump'
*.core_dump_dest='/u01/app/oracle/admin/+ASM/cdump'
*.instance_type='asm' 
*.large_pool_size=24M
*.remote_login_passwordfile='SHARED'
*.user_dump_dest='/u01/app/oracle/admin/+ASM/udump'
EOF"
    su - oracle -c "mkdir -p /u01/app/oracle/admin/+ASM/udump;mkdir -p /u01/app/oracle/admin/+ASM/bdump;mkdir -p /u01/app/oracle/admin/+ASM/cdump"
    su - oracle -c "orapwd file=/u01/app/oracle/product/10/db_1/dbs/orapw+ASM password=Welcome1"
    su - oracle -c "export ORACLE_SID=+ASM;sqlplus / as sysdba<<EOF
startup;
alter system set asm_diskstring='/dev/asmdisk/*';
EOF"
    su - oracle -c "export ORACLE_SID=+ASM;sqlplus / as sysdba<<EOF
alter system set asm_diskstring='/dev/asmdisk/*';
create diskgroup DATA normal redundancy disk '/dev/asmdisk/DATADISK01' NAME DATA01,'/dev/asmdisk/DATADISK02' NAME DATA02,'/dev/asmdisk/DATADISK03' NAME DATA03;
EOF"
    su - oracle -c "export ORACLE_SID=+ASM;sqlplus / as sysdba<<EOF
select name from v\\\$asm_disk;
select name from v\\\$asm_diskgroup;
EOF"

grep "no rows selected" /root/out2.txt > /dev/null
    if [ $? -eq 0 ]; then
        su - oracle -c "export ORACLE_SID=+ASM;sqlplus / as sysdba<<EOF
alter system set asm_diskstring='/dev/asmdisk/*';
alter system set asm_diskgroups='DATA';
alter diskgroup DATA mount;
EOF"
    else
        echo "DATA is mounted.........."
    fi

    echo "Trying to dbca..............."
    su - oracle -c "dbca -silent -createDatabase -templateName General_Purpose.dbc -gdbName orcl -sid orcl \
    -sysPassword Welcome1 -systemPassword Welcome1 -storageType ASM -asmSysPassword Welcome1 \
    -diskGroupName DATA -redundancy NORMAL -datafileDestination 'DATA/' -characterset AL32UTF8"
    until [ $? -eq 0 ]
    do
        su - oracle -c "export ORACLE_SID=+ASM;sqlplus / as sysdba<<EOF
startup;
alter system set asm_diskstring='/dev/asmdisk/*';
alter system set asm_diskgroups='DATA';
alter diskgroup DATA mount;
EOF"
        su - oracle -c "dbca -silent -createDatabase -templateName General_Purpose.dbc -gdbName orcl -sid orcl \
        -sysPassword Welcome1 -systemPassword Welcome1 -storageType ASM -asmSysPassword Welcome1 \
        -diskGroupName DATA -redundancy NORMAL -datafileDestination 'DATA/' -characterset AL32UTF8"
    done
    echo $?
    if [ $? -eq 0 ]; then
        su - oracle -c "lsnrctl start"
        sleep 15s
        su - oracle -c "lsnrctl status"
        kill -9 $(ps -ef | grep ocssd | grep -v grep | awk '{print $2}')
        echo "dbca suc..............."
        if [ $dbVersion = '10.2.0.1' ]; then
            exit 0
        elif [ $dbVersion = '10.2.0.5' ]; then
            echo "Trying to close oracle....................."
            su - oracle -c "emctl stop dbconsole;isqlplusctl stop;lsnrctl stop"
            echo "Trying to install 10.2.0.5................."
            su - oracle -c "/u01/Disk1/runInstaller -ignoreSysPrereqs -force -silent -waitforcompletion -responseFile /u01/patchset.rsp"
            echo $?
            if [ $? -eq 0 ]; then
                echo "Trying to run scripts......................"
                bash /root/1.sh & echo "



" | /u01/app/oracle/product/10/db_1/root.sh 
                su - oracle -c "export ORACLE_SID=+ASM;sqlplus / as sysdba<<EOF
startup
EOF"
                su - oracle -c "export ORACLE_SID=orcl;sqlplus / as sysdba<<EOF
startup upgrade
SPOOL upgrade_info.log
@?/rdbms/admin/utlu102i.sql
SPOOL OFF
update registry\\\$ set prv_version='10.2.0.5' where cid='CATPROC';
commit;
EOF"
                su - oracle -c "sqlplus / as sysdba<<EOF
SPOOL patch.log
@?/rdbms/admin/catupgrd.sql
SPOOL OFF
@?/rdbms/admin/utlrp.sql
COL COMP_NAME FOR A50
COL VERSION FOR A12
COL STATUS FOR A12
SELECT COMP_NAME, VERSION, STATUS FROM SYS.DBA_REGISTRY;
EOF"
                su - oracle -c "sqlplus / as sysdba<<EOF
SELECT COMP_NAME, VERSION, STATUS FROM SYS.DBA_REGISTRY;
EOF" > /root/out2.txt
                count=$(cat /root/out2.txt |grep "VALID" |wc -l)
                if [ $count -eq 17 ]; then
                    echo "upgrade suc..........."
                    kill -9 $(ps -ef | grep ocssd | grep -v grep | awk '{print $2}')
                    exit 0
                else
                    echo upgrade with failures
                    exit 1
                fi
            else
                echo oracle10.2.0.5 install with failures
            fi
        fi
    else
        echo dbca with failure
        exit 1
    fi
else
    echo db installation with failure
    exit 1
fi
```

## setupNdbMgmd.sh

```sh
#!/bin/bash

ndbd1=$1
ndbd2=$2

echo $ndbd1
echo $ndbd2

######################### prepare disk #########################
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


mkfs.xfs /dev/sdd
mkdir /u01
mount /dev/sdd /u01
echo "/dev/sdd /u01 ext4 defaults 0 0" >> /etc/fstab


#########################remove mariadb#########################
rpm -e postfix-2:2.10.1-6.el7.x86_64
rpm -e mariadb-libs-5.5.56-2.el7.x86_64

#########################install mysql cluster#########################
tar -xvf /mnt/share/software/MySQL/mysql-cluster-gpl-7.5.10-linux-glibc2.12-x86_64.tar.gz -C /usr/local/
cd /usr/local/
mv mysql-cluster-gpl-7.5.10-linux-glibc2.12-x86_64 mysql

cp /usr/local/mysql/bin/ndb_mgm* /usr/local/bin
chmod +x /usr/local/bin/ndb_mgm*

mkdir -p /u01/mgmd/data/

#########################setup config.ini#########################
echo "
[NDBD DEFAULT]
NoOfReplicas=2

[NDB_MGMD]
hostname=$ndbd1
datadir=/u01/mgmd/data

[NDBD]
hostname=$ndbd1
datadir=/u01/ndbd/data

[NDBD]
hostname=$ndbd2
datadir=/u01/ndbd/data

[MYSQLD]
[MYSQLD]
" >> /u01/mgmd/data/config.ini

/usr/local/bin/ndb_mgmd -f /u01/mgmd/data/config.ini --initial

```

## setupMySQLClusterEnv.sh

```sh
#!/bin/bash

mgmd=$1
echo $mgmd

######################### prepare disk #########################

grep "/dev/sdc1 swap swap defaults 0 0" /etc/fstab >> /dev/null
if [ $? -eq 0 ]; then
    echo "the swap disk is existed"
else
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
fi

grep "/dev/sdd /u01 ext4 defaults 0 0" /etc/fstab >> /dev/null
if [ $? -eq 0 ]; then
    echo "the /u01 is existed"
else
    mkfs.xfs /dev/sdd
    mkdir /u01
    mount /dev/sdd /u01
    echo "/dev/sdd /u01 ext4 defaults 0 0" >> /etc/fstab
fi


######################### remove mariadb #########################
rpm -e postfix-2:2.10.1-6.el7.x86_64
rpm -e mariadb-libs-5.5.56-2.el7.x86_64


######################### add user and group #########################
groupadd mysql
useradd -g mysql -s /bin/false mysql

mkdir -p /u01/ndbd/data/
chown root:mysql /u01/ndbd/data/

######################### install mysql-cluster #########################
if [ -d "/usr/local/mysql" ]; then
    echo "the directory is existed"
    echo "the directory is existed" > /root/out.txt
else
    tar -xvf /root/mysql-cluster-gpl-7.5.10-linux-glibc2.12-x86_64.tar.gz -C /usr/local/
    cd /usr/local/
    mv mysql-cluster-gpl-7.5.10-linux-glibc2.12-x86_64 mysql
fi

######################### mysql initialize #########################
/usr/local/mysql/bin/mysqld --initialize 2>&1 | tee /u01/pswd.txt

cd /usr/local/mysql
chown -R root .
chown -R mysql data
chgrp -R mysql .
cp support-files/mysql.server /etc/rc.d/init.d/
chmod +x /etc/rc.d/init.d/mysql.server
chkconfig --add mysql.server


######################### set my.cnf #########################
echo "
[mysqld]
ndbcluster
ndb-connectstring=$mgmd

[mysql_cluster]
ndb-connectstring=$mgmd
" >> /etc/my.cnf

######################### start mysql #########################
/etc/rc.d/init.d/mysql.server start

echo "export PATH=\$PATH:/usr/local/mysql/bin" >> /root/.bash_profile
source /root/.bash_profile

######################### login and modify password #########################
passwd1=`cat /u01/pswd.txt | grep -n password | awk '{print $11}'`
echo $passwd1

touch /u01/out.txt
mysql --connect-expired-password -u root --password=$passwd1 -e "
set password=password('123456');
" >> /u01/out.txt

######################### start ndbd #########################
/usr/local/mysql/bin/ndbd --initial

killall mysqld
exit 0
```

## setupMySQL5Env.sh

```sh
#!/bin/bash

dbSoftPath=$1
dbVersion=$2

echo $dbSoftPath
echo $dbVersion
####################### prepare disk ###############################
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


mkfs.xfs /dev/sdd
mkdir /u01
mount /dev/sdd /u01
echo "/dev/sdd /u01 ext4 defaults 0 0" >> /etc/fstab

####################### install mysql ###############################
rpm -e mariadb-libs-5.5.56-2.el7.x86_64 --nodeps
if [ $dbVersion == '5.6.48' ];then
    cp $dbSoftPath/MySQL-5.6.48-1.el7.x86_64.rpm-bundle.tar /u01
    tar -xvf /u01/MySQL-5.6.48-1.el7.x86_64.rpm-bundle.tar
    
    yum install -y  perl-Data-Dumper
    rpm -ivh MySQL-server-5.6.48-1.el7.x86_64.rpm
    rpm -ivh MySQL-client-5.6.48-1.el7.x86_64.rpm
    
    cp /usr/share/mysql/my-default.cnf /etc/my.cnf
elif [ $dbVersion == '5.7.28' ];then
    cp $dbSoftPath/mysql-5.7.28-1.el7.x86_64.rpm-bundle.tar /u01
    tar -xvf /u01/mysql-5.7.28-1.el7.x86_64.rpm-bundle.tar

    rpm -ivh mysql-community-common-5.7.28-1.el7.x86_64.rpm
    rpm -ivh mysql-community-libs-5.7.28-1.el7.x86_64.rpm
    rpm -ivh mysql-community-libs-compat-5.7.28-1.el7.x86_64.rpm
    rpm -ivh mysql-community-client-5.7.28-1.el7.x86_64.rpm
    rpm -ivh mysql-community-server-5.7.28-1.el7.x86_64.rpm

elif [ $dbVersion == '8.0.17' ]; then
    cp $dbSoftPath/mysql-8.0.17-1.el7.x86_64.rpm-bundle.tar /u01
    tar -xvf /u01/mysql-8.0.17-1.el7.x86_64.rpm-bundle.tar

    rpm -ivh mysql-community-common-8.0.17-1.el7.x86_64.rpm
    rpm -ivh mysql-community-libs-8.0.17-1.el7.x86_64.rpm
    rpm -ivh mysql-community-libs-compat-8.0.17-1.el7.x86_64.rpm
    rpm -ivh mysql-community-client-8.0.17-1.el7.x86_64.rpm
    rpm -ivh mysql-community-server-8.0.17-1.el7.x86_64.rpm
fi

mkdir -p /u01/mysql_data/mysql
chown -R mysql:mysql /u01/mysql_data/mysql

if [ $dbVersion == '5.6.48' ]; then
    echo "
datadir=/u01/mysql_data/mysql
socket=/var/lib/mysql/mysql.sock

character-set-server=utf8
log-bin=mysql-bin
log-bin-index=mysql-bin.index
binlog-format=row
binlog-row-image=full
sync_binlog=1
innodb_flush_log_at_trx_commit=2
innodb_flush_method=O_DIRECT
max_allowed_packet=52m
open_files_limit=65535
server-id=1
sync_binlog=1

[client]
default-character-set=utf8
    " >> /etc/my.cnf
    cp -rp /var/lib/mysql /u01/mysql_data/
    systemctl enable mysql
    systemctl start mysql
    systemctl status mysql
else
    sed -i "s|datadir=.*|datadir=/u01/mysql_data/mysql|g" /etc/my.cnf
    echo "
character-set-server=utf8
log-bin=mysql-bin
log-bin-index=mysql-bin.index
binlog-format=row
binlog-row-image=full
sync_binlog=1
innodb_flush_log_at_trx_commit=2
innodb_flush_method=O_DIRECT
max_allowed_packet=52m
open_files_limit=65535
server-id=1
sync_binlog=1

[client]
default-character-set=utf8
    " >> /etc/my.cnf

    systemctl enable mysqld
    systemctl start mysqld
    systemctl status mysqld
fi

if [ $dbVersion == '5.6.48' ]; then
    passwd1=`cat /root/.mysql_secret |  awk '{print $18}'`
    echo $passwd1
    mysql --connect-expired-password -u root --password=$passwd1 -e "
set password=password('123456');
        " >> /u01/out.txt
    
    echo "**************" >> /u01/out.txt
mysql -uroot -p123456 -e "
select @@datadir;
    " >> /u01/out.txt
    
    echo "**************" >> /u01/out.txt
    mysql -uroot -p123456 -e "
use mysql;
select database();
select host,user from user;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '123456' WITH GRANT OPTION;
FLUSH PRIVILEGES;
select host,user from user;
    " >> /u01/out.txt

elif [ $dbVersion == '5.7.28' ]; then
    passwd1=`cat /var/log/mysqld.log | grep -n password |  awk '{print $11}'`
    echo $passwd1
    
    mysql --connect-expired-password -u root --password=$passwd1 -e "
set global validate_password_policy=0;
set global validate_password_length=6;
set password=password('123456');
    " >> /u01/out.txt

    echo "**************" >> /u01/out.txt
    mysql -uroot -p123456 -e "
select @@datadir;
    " >> /u01/out.txt

    echo "**************" >> /u01/out.txt
    mysql -uroot -p123456 -e "
use mysql;
select database();
select host,user from user;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '123456' WITH GRANT OPTION;
FLUSH PRIVILEGES;
select host,user from user;
    " >> /u01/out.txt

elif [ $dbVersion == '8.0.17' ]; then
    passwd1=`cat /var/log/mysqld.log | grep -n password |  awk '{print $13}'`
    echo $passwd1

    mysql --connect-expired-password -u root --password=$passwd1 -e "
set global validate_password.policy=LOW;
set global validate_password.length=6;
ALTER USER 'root'@'localhost' IDENTIFIED BY '123456';
    " >> /u01/out.txt

    echo "**************" >> /u01/out.txt
    mysql -uroot -p123456 -e "
use mysql;
select database();
select host,user from user;
create user 'root'@'%' identified by '123456';
grant all privileges on *.* to 'root'@'%';
flush privileges;
select host,user from user;
    " >> /u01/out.txt
fi

```

## setupDttEnv.sh

```sh
#!/bin/bash

nasMountDir="/home/i2auto"
dttHomeDir="$nasMountDir/DTT"

var=$1
var=${var//,/ }
for element in $var
do
    userArray=(${element//:/ })
    sshCmd="sshpass -p ${userArray[2]} ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${userArray[1]}@${userArray[0]}"
    
    isMounted=0
    timeOut=60
    interval=10
    time=0
    if $sshCmd ls /|grep "root"; then
        echo "no ssh ready on ${userArray[0]}"
        break
    fi
    echo "$sshCmd ls $dttHomeDir"
    $sshCmd ls $dttHomeDir
    while [ $? -ne 0 -a $time -le $timeOut ]
    do
        echo "$sshCmd ls $nasMountDir"
        $sshCmd ls $nasMountDir
        if [ $? -ne 0 ]; then
            echo "$sshCmd mkdir -p $nasMountDir"
            $sshCmd mkdir -p $nasMountDir
        fi
        if [ $isMounted -eq 0 ];then
            echo "$sshCmd mount -t nfs 172.20.64.100:/nfs/auto_package $nasMountDir"
            $sshCmd mount -t nfs 172.20.64.100:/nfs/auto_package $nasMountDir
            isMounted=1
        fi
        let time+=$interval
        echo "wait ${interval}s....."
        sleep $interval
        echo "$sshCmd ls $dttHomeDir"
        $sshCmd ls $dttHomeDir
    done
    
    echo "$sshCmd $nasMountDir/script/dttenv.sh"
    $sshCmd $nasMountDir/script/dttenv.sh
done

```

## setupCustNode.sh

```sh
#!/bin/bash

softPath=$1
autoWork=$2
srcDir="/mnt/share"
srcFileServer="172.20.64.7"

#if [[ ! $softPath =~ rpm$ ]]; then
#    echo "The customized node soft package must be ended with suffix rpm"
#    exit
#fi
if [[ ! $softPath =~ ^/ ]]; then
    ###mount product file server
    echo "! test -e $srcDir && mkdir -p $srcDir;! df|grep $srcFileServer && mount -r -t nfs $srcFileServer:/rd-data/FileServer/rd $srcDir"
    ! test -e $srcDir && mkdir -p $srcDir;! df|grep $srcFileServer && mount -r -t nfs $srcFileServer:/rd-data/FileServer/rd $srcDir

    ###download node soft
    echo "! test -e $autoWork && mkdir -p $autoWork;cp $srcDir/i2soft/$softPath $autoWork"
    ! test -e $autoWork && mkdir -p $autoWork;cp $srcDir/i2soft/$softPath $autoWork
    
    softPath=$autoWork/${softPath##*/}
fi

srcDir="/home/i2auto"
srcFileServer="172.20.64.100"
###mount dtt file server
echo "! test -e $srcDir && mkdir -p $srcDir;! df|grep $srcFileServer && mount -r -t nfs $srcFileServer:/nfs/auto_package $srcDir"
! test -e $srcDir && mkdir -p $srcDir;! df|grep $srcFileServer && mount -r -t nfs $srcFileServer:/nfs/auto_package $srcDir

###cleanup old node soft
#echo "rpm -qa|grep i2"
#oldNodeSoft=`rpm -qa|grep i2`
#if [[ $oldNodeSoft =~ i2node ]]; then
#    echo "rpm -e $oldNodeSoft"
#    rpm -e $oldNodeSoft
#fi

###install node soft
if [[ $softPath =~ rpm$ ]]; then
    echo "expect $srcDir/DTT/script/nodeInstall.exp $softPath"
    expect $srcDir/DTT/script/nodeInstall.exp $softPath
fi

if [[ $softPath =~ deb$ ]]; then
    echo "expect $srcDir/DTT/script/nodeInstalldeb.exp $softPath"
    expect $srcDir/DTT/script/nodeInstalldeb.exp $softPath
fi

if [ $? -eq 0 ]; then
    echo "verify node installation"
    echo "lsmod | grep -w sfs && ps -ef | grep -v grep | grep sdata && netstat -anop | grep tcp | grep -E '26821|26831|26832|26833|26871|26873'"
    lsmod | grep -w sfs && ps -ef | grep -v grep | grep sdata && netstat -anop | grep tcp | grep -E '26821|26831|26832|26833|26871|26873'
    if [ $? -ne 0 ]; then
        echo "Failed to verify node installation"
        exit 1
    fi
else
    echo "Failed to node installation"
    exit 1
fi


```

## setupCustI2up.sh

```sh
#!/bin/bash

softPath=$1
libSoftPath=$2
autoWork=$3
srcDir="/mnt/share"
srcFileServer="172.20.64.7"

if [[ ! $softPath =~ rpm$ ]]; then
    echo "The customized node soft package must be ended with suffix rpm"
    exit
fi
if [[ ! $softPath =~ ^/ ]]; then
    ###mount product file server
    echo "! test -e $srcDir && mkdir -p $srcDir;! df|grep $srcFileServer && mount -r -t nfs $srcFileServer:/rd-data/FileServer/rd $srcDir"
    ! test -e $srcDir && mkdir -p $srcDir;! df|grep $srcFileServer && mount -r -t nfs $srcFileServer:/rd-data/FileServer/rd $srcDir

    ###download i2up soft
    echo "! test -e $autoWork && mkdir -p $autoWork;cp $srcDir/i2soft/$softPath $autoWork"
    ! test -e $autoWork && mkdir -p $autoWork;cp $srcDir/i2soft/$softPath $autoWork

    ###download libs soft
    echo "test -e $srcDir/i2soft/$libSoftPath;cp $srcDir/i2soft/$libSoftPath $autoWork"
    test -e $srcDir/i2soft/$libSoftPath;cp $srcDir/i2soft/$libSoftPath $autoWork
        
    softPath=$autoWork/${softPath##*/}
    libSoftPath=$autoWork/${libSoftPath##*/}
fi

srcDir="/home/i2auto"
srcFileServer="172.20.64.100"
###mount dtt file server
echo "! test -e $srcDir && mkdir -p $srcDir;! df|grep $srcFileServer && mount -r -t nfs $srcFileServer:/nfs/auto_package $srcDir"
! test -e $srcDir && mkdir -p $srcDir;! df|grep $srcFileServer && mount -r -t nfs $srcFileServer:/nfs/auto_package $srcDir

###cleanup old i2up soft
echo "rpm -qa|grep info2soft"
oldNodeSoft=`rpm -qa|grep info2soft`
if [[ $oldNodeSoft =~ webconsole ]]; then
    echo "rpm -e $oldNodeSoft"
    rpm -e $oldNodeSoft
fi

###install libs soft
###w/a start
echo "! rpm -qa|grep gtk3 && yum install -y gtk3>$autoWork/yumgtk3.log 2>&1"
! rpm -qa|grep gtk3 && yum install -y gtk3>$autoWork/yumgtk3.log 2>&1

echo "! rpm -qa|grep libicu && yum install -y libicu>$autoWork/yumlibicu.log 2>&1"
! rpm -qa|grep libicu && yum install -y libicu>$autoWork/yumlibicu.log 2>&1
###w/a end

echo "test -e $libSoftPath && rpm -ivh --nodeps $libSoftPath"
test -e $libSoftPath && rpm -ivh --nodeps $libSoftPath

###w/a start
echo "! ldconfig -v|grep libssl.so.1.1 && test -e /etc/ld.so.conf.d/i2ssl.conf.rpm && mv /etc/ld.so.conf.d/i2ssl.conf.rpm /etc/ld.so.conf.d/i2ssl.conf"
! ldconfig -v|grep libssl.so.1.1 && test -e /etc/ld.so.conf.d/i2ssl.conf.rpm && mv /etc/ld.so.conf.d/i2ssl.conf.rpm /etc/ld.so.conf.d/i2ssl.conf
###w/a end

###install i2up soft
echo "test -e $softPath && expect $srcDir/DTT/script/i2upInstall.exp $softPath"
test -e $softPath && expect $srcDir/DTT/script/i2upInstall.exp $softPath

if [ $? -ne 0 ]; then
    echo "Failed to i2up installation"
    exit 1
fi


```

## setNewIpForNewNetCard.sh

```sh
#!/bin/bash

oldMacaddress=$1
newMacaddress=$2
targetIp=$3
netMask="255.255.0.0"
gateWay=""

#if echo $targetIp | grep 172.20; then
#  netMask="255.255.240.0"
#  gateWay="172.20.64.1"
#else
#  netMask="255.255.0.0"
#  gateWay="10.1.0.1"
#fi
ip a >/root/ipdetail.txt
oldNetCardName=$(grep -B1 -i $oldMacaddress /root/ipdetail.txt | awk '{print $2}' | head -1)
oldNetCardName=${oldNetCardName%%:}
newNetCardName=$(grep -B1 -i $newMacaddress /root/ipdetail.txt | awk '{print $2}' | head -1)
newNetCardName=${newNetCardName%%:}
echo $oldNetCardName
echo $newNetCardName
#for centos,uek,el'[0-9]'
if uname -a | grep el'[0-9]' || uname -a | grep -i aarch64 || uname -a|grep -i yhkylin || uname -a|grep -i neokylin; then
  cp /etc/sysconfig/network-scripts/ifcfg-$oldNetCardName /etc/sysconfig/network-scripts/ifcfg-$newNetCardName
  sed -i "s|IPADDR.*|IPADDR=$targetIp|g" /etc/sysconfig/network-scripts/ifcfg-$newNetCardName
  sed -i "s|NETMASK.*|NETMASK=$netMask|g" /etc/sysconfig/network-scripts/ifcfg-$newNetCardName
  sed -i "s|PREFIX.*|PREFIX=24|g" /etc/sysconfig/network-scripts/ifcfg-$newNetCardName
  sed -i "/^UUID/d" /etc/sysconfig/network-scripts/ifcfg-$newNetCardName
  sed -i "/GATEWAY.*/d" /etc/sysconfig/network-scripts/ifcfg-$newNetCardName
  sed -i "s|NAME.*|NAME=$newNetCardName|g" /etc/sysconfig/network-scripts/ifcfg-$newNetCardName
  sed -i "s|DEVICE.*|DEVICE=$newNetCardName|g" /etc/sysconfig/network-scripts/ifcfg-$newNetCardName
  sed -i "s|HWADDR.*|HWADDR=$newMacaddress|g" /etc/sysconfig/network-scripts/ifcfg-$newNetCardName
  
  if uname -a | grep -i el7;then
  echo "ACTION==\"add\", SUBSYSTEM==\"net\", DRIVERS==\"?*\", ATTR{type}==\"1\", ATTR{address}==\"$oldMacaddress\", NAME=\"$oldNetCardName\""> /usr/lib/udev/rules.d/60-net.rules
  echo "ACTION==\"add\", SUBSYSTEM==\"net\", DRIVERS==\"?*\", ATTR{type}==\"1\", ATTR{address}==\"$newMacaddress\", NAME=\"$newNetCardName\"">> /usr/lib/udev/rules.d/60-net.rules
  fi

  if uname -a|grep -i openeuler ; then
    nmcli c reload
    nmcli c up $newNetCardName
  else
    reboot
  fi
fi
#for ubuntu,debian,uos
if uname -a | grep -i ubuntu || uname -a | grep -i debian || uname -a | grep -i dtt-PC ||grep -n uos /etc/os-release ; then
  if grep -n 18.04 /etc/os-release; then
    sed -i '$a\  ethernets:' /etc/netplan/*.yaml
    sed -i '$a\    '$newNetCardName':' /etc/netplan/*.yaml
    sed -i '$a\      addresses:' /etc/netplan/*.yaml
    sed -i '$a\      - '$targetIp/24 /etc/netplan/*.yaml
    #sed -i '$a\      gateway4: '$gateWay /etc/netplan/00-installer-config.yaml
    netplan apply
  else
    sed -i '$a\\n' /etc/network/interfaces
    sed -i '$a\auto '$newNetCardName /etc/network/interfaces
    sed -i '$a\iface '$newNetCardName' inet static' /etc/network/interfaces
    sed -i '$a\address '$targetIp /etc/network/interfaces
    sed -i '$a\netmask '$netMask /etc/network/interfaces
    if uname -a | grep -i ubuntu || grep -n uos /etc/os-release ; then
        reboot
    else
        /etc/init.d/networking restart
    fi
  fi
fi
#for suse
if grep -n sles /etc/os-release|| zypper se yast ; then
  cp /etc/sysconfig/network/ifcfg-$oldNetCardName /etc/sysconfig/network/ifcfg-$newNetCardName
  sed -i "/^UUID/d" /etc/sysconfig/network/ifcfg-$newNetCardName
  sed -i "/GATEWAY.*/d" /etc/sysconfig/network/ifcfg-$newNetCardName
  sed -i "s|PREFIX.*|PREFIX=24|g" /etc/sysconfig/network/ifcfg-$newNetCardName
  sed -i "s|NETMASK.*|NETMASK=$netMask|g" /etc/sysconfig/network/ifcfg-$newNetCardName
  sed -i "s|DEVICE.*|DEVICE=$newNetCardName|g" /etc/sysconfig/network/ifcfg-$newNetCardName
  sed -i "s|IPADDR.*|IPADDR=$targetIp|g" /etc/sysconfig/network/ifcfg-$newNetCardName
  reboot
fi
#for 	proxmox
if uname -a | grep -i pve ; then
   sed -i '$a\\n' /etc/network/interfaces
   sed -i '$a\auto vmbr1' /etc/network/interfaces
   sed -i '$a\iface vmbr1 inet static' /etc/network/interfaces
   sed -i '$a\        address  '$targetIp /etc/network/interfaces
   sed -i '$a\        netmask '$netMask /etc/network/interfaces
   sed -i '$a\        bridge_ports '$newNetCardName /etc/network/interfaces
   sed -i '$a\        bridge_stp off' /etc/network/interfaces
   sed -i '$a\        bridge_fd 0' /etc/network/interfaces
   service networking restart
fi
rm -rf /root/ipdetail.txt

```

## setDtoDefaultPasswd.exp

```sh
#!/usr/bin/expect

set timeout 300

spawn /usr/local/i2dto/jdk/bin/java -jar /usr/local/i2dto/dto/lib/dto.jar --resetPasswd

set newPasswd [lindex $argv 0]
expect {
"new" {send "$newPasswd\r";exp_continue}
"confirm" {send "$newPasswd\r";exp_continue}
"SUCCESS!"
}
expect eof
```

## set170IpForNetCard.sh

```sh
#!/bin/bash

macaddress=$1
vmIp=$2
targetIp=$3
netMask="255.255.240.0"
gateWay="172.20.64.1"

ip a >/root/ipdetail.txt
netCardName=$(grep -B1 -i $macaddress /root/ipdetail.txt | awk '{print $2}' | head -1)
netCardName=${netCardName%%:}
echo $netCardName
while true
do
  #for centos,uek,el'[0-9]'
  if uname -a | grep el'[0-9]' || uname -a | grep -i aarch64 || uname -a | grep -i yhkylin || uname -a | grep -i neokylin || uname -a | grep -i oe2203; then
    sed -i "s/$vmIp/$targetIp/g" /etc/sysconfig/network-scripts/ifcfg-$netCardName
    sed -i "s/255.255.0.0/$netMask/g" /etc/sysconfig/network-scripts/ifcfg-$netCardName
    sed -i "s|PREFIX.*|PREFIX=20|g" /etc/sysconfig/network-scripts/ifcfg-$netCardName
    sed -i "/^UUID/d" /etc/sysconfig/network-scripts/ifcfg-$netCardName
    sed -i "s/10.1.0.1/$gateWay/g" /etc/sysconfig/network-scripts/ifcfg-$netCardName

    break
  fi
  #for ubuntu,debian,uos
  if uname -a | grep -i ubuntu || uname -a | grep -i debian || uname -a | grep -i dtt-PC || grep -n uos /etc/os-release; then
    if grep -n 18.04 /etc/os-release; then
      sed -i "s/$vmIp/$targetIp/g" /etc/netplan/*.yaml
      sed -i "s/255.255.0.0/$netMask/g" /etc/netplan/*.yaml
      sed -i "s/10.1.0.1/$gateWay/g" /etc/netplan/*.yaml
    else
      sed -i "s/$vmIp/$targetIp/g" /etc/network/interfaces
      sed -i "s/255.255.0.0/$netMask/g" /etc/network/interfaces
      sed -i "s/10.1.0.1/$gateWay/g" /etc/network/interfaces
    fi
    break
  fi
  #for suse
  if grep -n sles /etc/os-release || zypper se yast; then
    sed -i "/^UUID/d" /etc/sysconfig/network/ifcfg-$netCardName
    sed -i "s/10.1.0.1/$gateWay/g" /etc/sysconfig/network/ifcfg-$netCardName
    sed -i "s|PREFIX.*|PREFIX=20|g" /etc/sysconfig/network/ifcfg-$netCardName
    sed -i "s/255.255.0.0/$netMask/g" /etc/sysconfig/network/ifcfg-$netCardName
    sed -i "s/$vmIp/$targetIp/g" /etc/sysconfig/network/ifcfg-$netCardName

    break
  fi
  #for 	proxmox
  if uname -a | grep -i pve; then
    sed -i "s/$vmIp/$targetIp/g" /etc/network/interfaces
    sed -i "s/255.255.0.0/$netMask/g" /etc/network/interfaces
    sed -i "s/10.1.0.1/$gateWay/g" /etc/network/interfaces

    break
  fi
done
rm -rf /root/ipdetail.txt

```

## resetDtoPasswd.exp

```sh
#!/usr/bin/expect

set timeout 300

spawn /usr/local/i2dto/jdk/bin/java -jar /usr/local/i2dto/dto/lib/dto.jar --resetPasswd

set oldPasswd [lindex $argv 0]
set newPasswd [lindex $argv 1]
expect {
"old" {send "$oldPasswd\r";exp_continue}
"new" {send "$newPasswd\r";exp_continue}
"confirm" {send "$newPasswd\r";exp_continue}
"SUCCESS!"
}
expect eof
```

## nodeInstallWithNormal.exp

```sh
#!/usr/bin/expect

set timeout 300

set FILE    [lindex $argv 0]
set MODE    [lindex $argv 1]

spawn rpm -ivh  $FILE

expect "mode"
send "$MODE\r"

expect "successfully"
expect eof
```

## nodeInstalldeb.exp

```sh
#!/usr/bin/expect

set timeout 60

set FILE    [lindex $argv 0]
spawn dpkg -i $FILE

expect "mode"
send "1\r"

expect "Modify"
send "n\r"

expect "exit"
send "\r"
expect "successfully"
expect eof
```

## nodeInstall.exp

```sh
#!/usr/bin/expect

set timeout 600

set FILE    [lindex $argv 0]

spawn rpm -ivh  $FILE

expect "mode"
send "1\r"

expect "Modify"
send "n\r"

expect "exit"
send "\r"
expect "successfully"
expect eof
```

## mountRcCmd.sh

```sh
#!/bin/bash

echo 'mount -r -t nfs 10.1.0.9:/share/autoPackage /home/i2auto'>>/etc/rc.local
chmod +x /etc/rc.local
```

## ldapLogin.sh

```sh
#!/bin/bash


#LDAP环境配置
hdbAddr="/etc/openldap/slapd.d/cn=config/olcDatabase={2}hdb.ldif"
monitorAddr="/etc/openldap/slapd.d/cn=config/olcDatabase={1}monitor.ldif"
baseLDIFAddr="/etc/openldap/base.ldif"

basePwd="Dtt@2021"
localIP=$(hostname -i)
source /etc/profile
#source /usr/cntlcenter/etc/env.source
#安装LDAP服务器和客户端
yum install -y openldap-servers openldap-clients migrationtools

echo "管理员相关配置"
isExist=$(cat ${hdbAddr} | grep dc=info2soft)
if [ ${#isExist} -eq 0 ]; then
 echo "管理员配置"
 #设置openLDAP管理员密码
 pwd=$(slappasswd -s $basePwd)
 echo $pwd
 #修改openLDAP设置,dc、cn均为自定义内容
 sed -i 's/olcSuffix:.*/olcSuffix: dc=info2soft,dc=com/g' ${hdbAddr}
 sed -i 's/olcRootDN:.*/olcRootDN: cn=Manager,dc=info2soft,dc=com/g' ${hdbAddr}
 sed -i "9aolcRootPW: $pwd" ${hdbAddr}

 #更改监控认证配置，dc、cn均为自定义内容
 sed -i 's/dc=my-domain,dc=com/dc=info2soft,dc=com/g' ${monitorAddr}

 #设置DB Cache
 cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG
 chown -R ldap:ldap /var/lib/ldap/
else
 echo "已经完成配置，无需配置"
fi

#测试文件配置
slaptest -u
echo "-----------------------------使用source-----------------------------"
#yum install 之后用，不然执行导致python、GCC版本变更使得yum失效
source /usr/cntlcenter/etc/env.source
echo "-------------------------------------------------------------------"
#启动OpenLDAP 并设置开机自启
systemctl start slapd.service
systemctl enable slapd.service

#导入模板
ls /etc/openldap/schema/*.ldif | xargs -I {} sudo ldapadd -Y EXTERNAL -H ldapi:/// -f {}

#创建base.ldif，dc、cn均为自定义内容
if [ -e "${baseLDIFAddr}" ]; then
  echo "base基础框架搭建完毕"
else
  echo "创建base基本框架"
  touch ${baseLDIFAddr}
  echo "dn: dc=info2soft,dc=com" >> $baseLDIFAddr
  echo "dc: info2soft" >> $baseLDIFAddr
  echo "objectClass: top" >> $baseLDIFAddr
  echo -e "objectClass: domain\n" >> $baseLDIFAddr

  echo "dn: cn=Manager,dc=info2soft,dc=com" >> $baseLDIFAddr
  echo "objectClass: organizationalRole" >> $baseLDIFAddr
  echo "cn: Manager" >> $baseLDIFAddr
  echo -e "description: LDAP Manager\n" >> $baseLDIFAddr

  echo "dn: ou=People,dc=info2soft,dc=com" >> $baseLDIFAddr
  echo "objectClass: organizationalUnit" >> $baseLDIFAddr
  echo -e "ou: People\n" >> $baseLDIFAddr

  echo "dn: ou=Group,dc=info2soft,dc=com" >> $baseLDIFAddr
  echo "objectClass: organizationalUnit" >> $baseLDIFAddr
  echo -e "ou: Group\n" >> $baseLDIFAddr

  ldapadd -x -D cn=Manager,dc=info2soft,dc=com -w $basePwd -f  ${baseLDIFAddr}
fi


#创建组
echo "创建organizational unit"
#可自定义
ouBase="/etc/openldap/ou.ldif"
if [ -e "${ouBase}" ]; then
  echo "该组已经存在"
else
  touch ${ouBase}
  echo "dn: ou=info2user,dc=info2soft,dc=com" >> $ouBase
  echo "objectClass: organizationalUnit" >> $ouBase
  echo "ou: info2user" >> $ouBase
  ldapadd -H ldap://"${localIP}" -x -D "cn=Manager,dc=info2soft,dc=com" -w $basePwd -f $ouBase
fi

#创建用户
function uidNumRandom() {
  thoursPlace="1"
  hunsPlace=$[$RANDOM%10]
  tensPlace=$[$RANDOM%10]
  unitsPlace=$[$RANDOM%10]
  echo "${thoursPlace}${hunsPlace}${tensPlace}${unitsPlace}"
}

uidNum=$(uidNumRandom)
echo "创建用户"
userBase="/etc/openldap/user.ldif"
if [ -e "$userBase" ]; then
  echo "用户已经存在"
else
  touch ${userBase}
  echo "dn: uid=test_admin,ou=info2user,dc=info2soft,dc=com" >> $userBase
  echo "objectClass: inetOrgPerson" >> $userBase
  echo "objectClass: posixAccount" >> $userBase
  echo "objectClass: top" >> $userBase
  echo "objectClass: shadowAccount" >> $userBase
  echo "homeDirectory: /home/test_admin" >> $userBase
  echo "givenName: test_admin" >> $userBase
  echo "uid: test_admin" >> $userBase
  echo "cn: test_admin" >> $userBase
  echo "sn: b" >> $userBase
  echo "shadowWarning: 0" >> $userBase
  echo "shadowMin: 0" >> $userBase
  echo "shadowMax: 99999" >> $userBase
  echo "shadowLastChange: 12011" >> $userBase
  echo "shadowInactive: 99999" >> $userBase
  echo "shadowFlag: 0" >> $userBase
  echo "shadowExpire: 99999" >> $userBase
  echo "userPassword: ${basePwd}" >> $userBase
  echo "gidNumber: 0" >> $userBase
  echo "uidNumber: ${uidNum}" >> $userBase

  ldapadd -H ldap://${localIP} -x -D "cn=Manager,dc=info2soft,dc=com" -w $basePwd -f $userBase
fi

#AES加密
encryptionFile="/usr/cntlcenter/tmp/passwd"
#创建需要加密的文件，并写入需要加密的密码
encryptionPwd="nothing"
if [ -e "$encryptionFile" ]; then
  echo "加密文件路径已经存在"
else
  touch $encryptionFile
  echo $basePwd >> $encryptionFile
  #加密
  encryptionPwd=$(php /usr/cntlcenter/data/wwwroot/default/public/api/index.php Util str_encrypt $encryptionFile)
fi

#修改LDAP配置，建立连接，需要修改的配置与之前自定义的dc、cn、dn一致
### ldap.php LDAP_BIND_PW使用aes加密
# 判断变量的内容是否等于指定字符
if [ "$encryptionPwd" = "nothing" ]; then
  echo "已加密"
else
  ldapServiceAddr=/usr/cntlcenter/data/wwwroot/default/public/api/
  echo "### ldap.php LDAP_BIND_PW使用aes加密" >> $ldapServiceAddr/.env
  echo "LDAP_BIND_USER=cn=Manager,dc=info2soft,dc=com" >> $ldapServiceAddr/.env
  echo "LDAP_BASE_DN=dc=info2soft,dc=com" >> $ldapServiceAddr/.env
  echo "LDAP_BIND_PW=${encryptionPwd}" >> $ldapServiceAddr/.env
  echo "LDAP_SERVER_ADDRESS=${localIP}" >> $ldapServiceAddr/.env
  echo "LDAP_SERVER_PORT=389" >> $ldapServiceAddr/.env
  echo "LDAP_TIMEOUT=5" >> $ldapServiceAddr/.env
  echo "LDAP_ROLE=operator" >> $ldapServiceAddr/.env
  echo "LDAP_SEARCH_FILTER=(|(sn=\$username)(givenname=\$username)(uid=\$username))" >> $ldapServiceAddr/.env
fi

```

## installXtrabackup.sh

```sh
#!/bin/bash
pkgPath=/home/i2auto/soft
pkgVersion=$1
pkgName=percona-xtrabackup-2.4.26-Linux-x86_64.glibc2.12.tar.gz
if [ $pkgVersion = '5.7' ];then
    pkgName=percona-xtrabackup-2.4.26-Linux-x86_64.glibc2.12.tar.gz
elif [ $pkgVersion = '8.0' ];then
     pkgName=percona-xtrabackup-8.0.13-Linux-x86_64.el7.libgcrypt153.tar.gz
 fi

echo "xtrabackup 全路径为：$pkgPath/$pkgName"
if [ -e $pkgPath/$pkgName ];then
    echo "*****从共享上拷贝xtrabackup安装包*****"
    cp $pkgPath/$pkgName /root/
else
    mount -t nfs 10.1.0.9:/share/autoPackage /home/i2auto
    cp $pkgPath/$pkgName /root/
fi

echo "****解压到指定目录，然后重命名目录,创建软链接*****"
    tar xzvf  $pkgName -C /usr/local/
if [ $pkgVersion == '5.7' ];then
    echo " **** mv /usr/local/percona-xtrabackup-2.4.26-Linux-x86_64.glibc2.12/ /usr/local/xtrabackup **"
    mv /usr/local/percona-xtrabackup-2.4.26-Linux-x86_64.glibc2.12/ /usr/local/xtrabackup
    echo "****  ln -s /usr/local/xtrabackup/bin/innobackupex /usr/bin/innobackupex ***"
    ln -s /usr/local/xtrabackup/bin/innobackupex /usr/bin/innobackupex
    echo "*** ***"
    ln -s /usr/local/xtrabackup/bin/xbstream /usr/bin/xbstream
elif [ $pkgVersion == '8.0' ];then
    echo "*** mv /usr/local/percona-xtrabackup-8.0.13-Linux-x86_64/ /usr/local/xtrabackup ***"
    mv /usr/local/percona-xtrabackup-8.0.13-Linux-x86_64/ /usr/local/xtrabackup
    echo "***  ln -s /usr/local/xtrabackup/bin/xtrabackup /usr/bin/xtrabackup ***"
    ln -s /usr/local/xtrabackup/bin/xtrabackup /usr/bin/xtrabackup
    echo "*** ln -s /usr/local/xtrabackup/bin/xbstream /usr/bin/xbstream ***"
    ln -s /usr/local/xtrabackup/bin/xbstream /usr/bin/xbstream
fi

```

## installPHP.sh

```sh
#!/bin/bash
#PHP7.4.33环境配置
pkgPath="/home/i2auto/package"
pkgName="php-7.4.33.tar.gz"
tarPath="/usr/local/src"
envName="php-7.4.33"
if [ -e $pkgPath/$pkgName ];then
    echo "*****从共享上拷贝PHP安装包*****"
    cp $pkgPath/$pkgName /root/
else
    mount -t nfs 10.1.0.9:/share/autoPackage /home/i2auto
    cp $pkgPath/$pkgName /root/
fi

function installPhp() {

    #解压
    cp /root/${pkgName} $tarPath
    cd $tarPath
    tar -xzf $tarPath/$pkgName

    #前置环境准备
    cd $tarPath/$envName
    yum -y install libxml2 libxml2-devel openssl openssl-devel curl-devel libjpeg-devel libpng-devel freetype-devel libmcrypt-devel libzip-devel pcre-devel
    yum install sqlite-devel -y
    yum install libcurl-devel -y
    yum install oniguruma-devel -y
    yum -y install gmp-devel -y
    #yum install openldap openldap-devel  -y
    #cp -frp /usr/lib64/libldap* /usr/lib/
    yum  install net-snmp-devel -y
    yum  install libxslt-devel -y

    cd /usr/local/src/php-7.4.33
    #环境配置
    ./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --enable-fpm --with-fpm-user=www --with-fpm-group=www --with-mysqli --with-pdo-mysql --with-openssl --with-zlib --with-curl --with-gd --with-jpeg-dir --with-png-dir --with-freetype-dir --with-mcrypt --with-gettext --with-xmlrpc --with-xsl --with-curl --enable-mbstring --enable-sockets --enable-zip --enable-soap --enable-xml --enable-rtmp --enable-inline-optimization --with-intl=en_US.UTF-8 --with-mcrypt --enable-bcmath --enable-calendar --enable-ftp --enable-ftp --enable-shmop --enable-sysvsem --enable-sysvshm --enable-wddx --enable-wddx --enable-shmop --enable-shmop --enable-wddx --enable-wddx --enable-shmop --enable-shmop

    #编译
    make
    make install

    #配置环境变量
    echo export PHP_HOME=/usr/local/php >> /etc/profile
    echo PATH=\$PATH:\$PHP_HOME/bin >> /etc/profile
    source /etc/profile

    php -v

    #配置php fp
    cp /usr/local/php/etc/php-fpm.d/www.conf.default /usr/local/php/etc/php-fpm.conf
    #cp /usr/local/src/php-7.4.33/php.ini-production /usr/local/php/etc/php.ini
    cp ${tarPath}/${envName}/php.ini-production /usr/local/php/etc/php.ini
    cp ${tarPath}/${envName}/sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm

    if cat /usr/local/php/etc/php-fpm.conf | grep "user = www" > /dev/null
    then
    sed -i "s/user = www/user = nobody/g" /usr/local/php/etc/php-fpm.conf
    fi

    if cat /usr/local/php/etc/php-fpm.conf | grep "group = www" > /dev/null
    then
    sed -i "s/group = www/group = nobody/g" /usr/local/php/etc/php-fpm.conf
    fi

    chmod +x /etc/init.d/php-fpm
    chkconfig --add php-fpm
    chkconfig php-fpm on
    systemctl start php-fpm.service
    systemctl enable php-fpm.service
    systemctl status php-fpm.service
}

#判断本地是否已经安装了php7.4
PHP_VERSION=$(php -v | awk '{print $2}')
if [[ "$PHP_VERSION" == "7.4"* ]]; then
    echo "PHP 7.4.* is installed."
else
    echo "PHP 7.4.* is not installed."
    installPhp
fi

```

## installMysql.sh

```sh
#!/bin/bash
pkgPath=/home/i2auto/soft
pkgName=mysql-5.7.32-1.el7.x86_64.rpm-bundle.tar
if [ -e $pkgPath/$pkgName ];then
    echo "*****从共享上拷贝mysql安装包*****"
    cp $pkgPath/$pkgName /root/
else
    mount -t nfs 10.1.0.9:/share/autoPackage /home/i2auto
    cp $pkgPath/$pkgName /root/
fi

if [ -e /root/$pkgName ];then
    mkdir /root/mysql5.7
    tar -xvf /root/mysql-5.7.32-1.el7.x86_64.rpm-bundle.tar -C /root/mysql5.7
    cd /root/mysql5.7
    rm -f mysql-community-test-5.7.32-1.el7.x86_64.rpm
    rpm -e postfix.x86_64 mariadb-libs.x86_64
    echo "*****安装mysql数据库*****"
    rpm -ivh *
fi
echo "*****启动mysql*****"
service mysqld start
sleep 15s

echo "*****修改mysql数据库密码*****"
password=`cat /var/log/mysqld.log | grep 'temporary password' | awk -F"root@localhost: " '{print $NF}'`
mysql -uroot -p$password --connect-expired-password -N -e "alter user root@localhost identified by 'Info_1234';set global validate_password_length=4;set global validate_password_policy=0;alter user root@localhost identified by '123456';"
echo "配置mysql远程登录"
mysql -uroot -p123456 --connect-expired-password -N -e "use mysql;update user set host = '%' where user = 'root';flush privileges;"

```

## installMinio.sh

```sh
#!/bin/bash

pkgName=minio
pkgPath=/home/i2auto/soft/minio/linux
workPath=$1

function copyMinioPackages() {
  echo "*****从共享目录上拷贝Minio安装包*****"
  if [ -e $pkgPath/$pkgName ]; then
    if [ ! -e /root/$pkgName ]; then
      echo "cp $pkgPath/$pkgName /root/ "
      cp $pkgPath/$pkgName /root/
    fi
  else
    mount -t nfs 10.1.0.9:/share/product /mnt/share
    cp $pkgPath/$pkgName /root/
  fi
}

function createUserAndPass() {
  echo "*****修改Minio默认用户和密码*****"
  echo "1. export MINIO_ROOT_USER=admin"
  export MINIO_ROOT_USER=admin
  echo "2. export MINIO_ROOT_PASSWORD=Dtt@2021"
  export MINIO_ROOT_PASSWORD=Dtt@2021
}

function startMinio() {
  echo "*****启动Minio服务*****"
  echo "1. chmod +x /root/$pkgName"
  chmod +x /root/$pkgName
  echo "2. mkdir -p $workPath"
  mkdir -p $workPath
  echo "3. nohup /root/$pkgName server $workPath > $workPath/minio.log 2>&1 &"
  nohup /root/$pkgName server $workPath > $workPath/minio.log 2>&1 &
}

copyMinioPackages
if [ $? == 0 ]; then
  createUserAndPass
  startMinio
fi

```

## installMariadb.sh

```sh
#!/bin/bash
pkgPath=/home/i2auto/soft/mariadb10.4.8
pkgNum=`cd $pkgPath && ls -l | wc -l`

echo "*****卸载旧版本*****"
oldMariadb=`rpm -qa | grep mariadb`
rpm -e --nodeps $oldMariadb
existOldMariadb=`rpm -qa | grep mariadb`
if [ -z "$existOldMariadb" ];then
	echo "*****旧版本已被卸载*****"
	if [ $pkgNum -eq 15 ];then
		echo "*****从共享上拷贝mariadb安装包*****"
		mkdir /root/mariadb10_packages
		cp $pkgPath/* /root/mariadb10_packages/
	else
		mount -t nfs 10.1.0.9:/share/autoPackage /home/i2auto
		cp $pkgPath/* /root/mariadb10_packages/
	fi

	if [ $pkgNum -eq 15 ];then
		cd /root/mariadb10_packages/
		echo "*****安装mariadb数据库*****"
		rpm -ivh *
	fi
fi
echo "*****启动mariadb*****"
service mariadb start
sleep 10s
echo "*****配置mariadb远程登录*****"
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '123456';flush privileges;"
echo "*****配置完成*****"
```

## installDM8InCentOS7.sh

```sh
#!/bin/bash
filePath=/root/dm8
pkgPath=/home/i2auto/soft/DMDB/DM8/
pkgName=dm8_20220525_x86_rh6_64.zip
installPath=/root/dmdba/dmdbms
function  copyDM8PackagesAndAutoInstallFile(){
  echo "*****从共享上拷贝dm8安装包*****"
  if [ -e $pkgPath/$pkgName ];then
    cp $pkgPath/$pkgName /root/
  else
    mount -t nfs 10.1.0.9:/share/autoPackage /home/i2auto
    cp $pkgPath/$pkgName /root/
  fi
  if [ ! -f $filePath/auto_install.xml ]; then
      mkdir -p $filePath
      cp /root/auto/script/auto_install.xml  $filePath/
  fi
}
function unzipDMPackages() {
  echo "***************解压DM8****************"
  if [ -e $pkgPath/$pkgName ];then
     unzip -d /root/dm8  dm8_20220525_x86_rh6_64.zip
  else
    echo "****************dm8安装包不存在********************"
  fi
}

function createUserAndGroup(){
  groupadd dinstall
  useradd -g dinstall -m -d /home/dmdba -s /bin/bash dmdba
  echo "Dtt@2021" | passwd --stdin dmdba &> /dev/null
}
function configSystemEnvironment(){
 echo "
 dmdba soft core unlimited
 dmdba hard core unlimited
 dmdba soft nofile 65536
 dmdba hard nofile 65536
 dmdba soft nproc 65536
 dmdba hard nproc 65536
 dmdba soft stack 65536
 dmdba hard stack 65536
 " >> /etc/security/limits.conf
 su - dmdba -c "ulimit -a"
 chown dmdba:dinstall -R /root/
 chmod -R 755 /root
 mkdir -p /root/tmp
 sed -i '$aexport DM_INSTALL_TMPDIR=/root/tmp' /home/dmdba/.bash_profile
 su dmdba -c 'source /home/dmdba/.bash_profile'
 chown -R dmdba:dinstall /root/tmp
 chown -R dmdba:dinstall /root/tmp
}
function installDM8(){
#判断文件夹是否存在
  if [ ! -d "$installPath" ];then
    mkdir -p $installPath
    echo "安装文件夹创建完成"
   else
    echo "安装文件夹已经存在，删除文件重新创建"
    rm -rf $installPath/*
  fi
  echo "创建/mnt/cdrom/的目录作为挂载点"
  if [ ! -d "/mnt/cdrom" ]; then
      mkdir -p /mnt/cdrom
  fi
  mount /root/dm8/dm8_20220525_x86_rh6_64_ent/dm8_20220525_x86_rh6_64.iso /mnt/cdrom/
  echo "复制安装启动文件"
  cp /mnt/cdrom/DMInstall.bin .
  echo "指定组权限，少指定一层文件夹dmdbms，方便.bash_profile环境变量写入"
  chown -R dmdba:dinstall /root/dmdba
  chown -R dmdba:dinstall DMInstall.bin
  echo "切换用户并安装(静默安装，选定生成好的xml配置文件)"
  su dmdba -c './DMInstall.bin -q /root/dm8/auto_install.xml'
  echo "切换到root用户，开始初始化数据库，创建DmAPService服务"
  su root -c "/root/dmdba/dmdbms/script/root/root_installer.sh"
}

function startDMDataBaseInstanceAndConfigDisqlTool() {
    su - dmdba -c 'nohup /root/dmdba/dmdbms/bin/dmserver path=/root/dmdba/dmdbms/data/DAMENG/dm.ini -noconsole >dm.log 2>&1 &'
    sed -i '$aexport PATH=$PATH:$DM_HOME/bin:$DM_HOME/tool' /home/dmdba/.bash_profile
}

echo "开始拷贝 copyDM8PackagesAndAutoInstallFile********************************"

copyDM8PackagesAndAutoInstallFile
if [ $? == 0 ]; then
  echo "****************copyDM8PackagesAndAutoInstallFile*******************************"
  unzipDMPackages
  echo "***************unzipDMPackages***************"
  createUserAndGroup
  echo "***************configSystemEnvironment***************"
  configSystemEnvironment
  echo "***************createUserAndGroup***************"
  installDM8
  echo "***************installDM8***************"
  startDMDataBaseInstanceAndConfigDisqlTool
  echo "****************startDMDataBaseInstanceAndConfigDisqlTool*************************************"
fi
```
## auto_install.xml
```xml
<?xml version='1.0'?>  
<DATABASE>  
    <!--安装数据库的语言配置，安装中文版配置 ZH，英文版配置 EN，不区分大小写。不允许为空。-->  
    <LANGUAGE>zh</LANGUAGE>  
    <!--安装程序的时区配置，默认值为+08:00，范围：-12:59 ~ +14:00 -->  
    <TIME_ZONE>+08:00</TIME_ZONE>  
    <!-- key 文件路径 -->  
    <KEY></KEY>  
    <!--安装程序组件类型，取值 0、1、2，0 表示安装全部，1 表示安装服务器，2 表示安装客户端。默认为 0。 -->  
    <INSTALL_TYPE>0</INSTALL_TYPE>  
    <!--安装路径，不允许为空。 -->  
    <INSTALL_PATH>/root/dmdba/dmdbms</INSTALL_PATH>  
    <!--是否初始化库，取值 Y/N、y/n，不允许为空。 -->  
    <DM_INSTALL_TMPDIR>/dmtmp</DM_INSTALL_TMPDIR>  
    <INIT_DB>Y</INIT_DB>  
    <!--数据库实例参数 -->  
    <DB_PARAMS>  
        <!--初始数据库存放的路径，不允许为空 -->  
        <PATH>/root/dmdba/dmdbms/data</PATH>  
        <!--初始化数据库名字，默认是 DAMENG，不超过 128 个字符 -->  
        <DB_NAME>DAMENG</DB_NAME>  
        <!--初始化数据库实例名字，默认是 DMSERVER，不超过 128 个字符 -->  
        <INSTANCE_NAME>DMSERVER</INSTANCE_NAME>  
        <!--初始化时设置 dm.ini 中的 PORT_NUM，默认 5236，取值范围：1024~65534 -->  
        <PORT_NUM>5236</PORT_NUM>  
        <!--初始数据库控制文件的路径，文件路径长度最大为 256 -->        <CTL_PATH></CTL_PATH>  
        <!--初始数据库日志文件的路径，文件路径长度最大为 256 -->        <LOG_PATHS>  
            <LOG_PATH></LOG_PATH>  
        </LOG_PATHS>  
        <!--数据文件使用的簇大小，只能是 16 页或 32 页之一，缺省使用 16 页 -->  
        <EXTENT_SIZE>16</EXTENT_SIZE>  
        <!--数据文件使用的页大小，缺省使用 8K，只能是 4K、8K、16K 或 32K 之一 -->  
        <PAGE_SIZE>8</PAGE_SIZE>  
        <!--日志文件使用的簇大小，默认是 256，取值范围 64 和 2048 之间的整数 -->  
        <LOG_SIZE>256</LOG_SIZE>  
        <!--标识符大小写敏感，默认值为 Y。只能是’Y’, ’y’, ’N’, ’n’, ’1’, ’0’之一 -->  
        <CASE_SENSITIVE>Y</CASE_SENSITIVE>  
        <!--字符集选项，默认值为 0。0 代表 GB18030,1 代表 UTF-8,2 代表韩文字符集 EUC-KR -->        <CHARSET>0</CHARSET>  
        <!--设置为 1 时，所有 VARCHAR 类型对象的长度以字符为单位，否则以字节为单位。默认值为 0。 -->  
        <LENGTH_IN_CHAR>0</LENGTH_IN_CHAR>  
        <!--字符类型在计算 HASH 值时所采用的 HASH 算法类别。0：原始 HASH 算法；1：改进的HASH 算法。默认值为 1。 -->  
        <USE_NEW_HASH>1</USE_NEW_HASH>  
        <!--初始化时设置 SYSDBA 的密码，默认为 SYSDBA，长度在 9 到 48 个字符之间 -->  
        <SYSDBA_PWD></SYSDBA_PWD>  
        <!--初始化时设置 SYSAUDITOR 的密码，默认为 SYSAUDITOR，长度在 9 到 48 个字符之间 -->  
        <SYSAUDITOR_PWD></SYSAUDITOR_PWD>  
        <!--初始化时设置 SYSSSO 的密码，默认为 SYSSSO，长度在 9 到 48 个字符之间，仅在安全版本下可见和可设置 -->  
        <SYSSSO_PWD></SYSSSO_PWD>  
        <!--初始化时设置 SYSDBO 的密码，默认为 SYSDBO，长度在 9 到 48 个字符之间，仅在安全版本下可见和可设置 -->  
        <SYSDBO_PWD></SYSDBO_PWD>  
        <!--初始化时区，默认是东八区。格式为：正负号小时：分钟，范围：-12:59 ~ +14:00 -->  
        <TIME_ZONE>+08:00</TIME_ZONE>  
        <!--是否启用页面内容校验，0：不启用；1：简单校验；2：严格校验(使用 CRC16 算法生成校验码)。默认 0 -->        <PAGE_CHECK>0</PAGE_CHECK>  
        <!--设置默认加密算法，不超过 128 个字符 -->  
        <EXTERNAL_CIPHER_NAME></EXTERNAL_CIPHER_NAME>  
        <!--设置默认 HASH 算法，不超过 128 个字符 -->  
        <EXTERNAL_HASH_NAME></EXTERNAL_HASH_NAME>  
        <!--设置根密钥加密引擎，不超过 128 个字符 -->  
        <EXTERNAL_CRYPTO_NAME></EXTERNAL_CRYPTO_NAME>  
        <!--全库加密密钥使用的算法名。算法可以是 DM 内部支持的加密算法，或者是第三方的加密算法。默认使用'AES256_ECB'算法加密，最长为 128 个字节 -->  
        <ENCRYPT_NAME></ENCRYPT_NAME>  
        <!--指定日志文件是否加密。默认值 N。取值 Y/N，y/n，1/0 -->  
        <RLOG_ENC_FLAG>N</RLOG_ENC_FLAG>  
        <!--用于加密服务器根密钥，最长为 48 个字节 -->  
        <USBKEY_PIN></USBKEY_PIN>  
        <!--设置空格填充模式，取值 0 或 1，默认为 0 -->        <BLANK_PAD_MODE>0</BLANK_PAD_MODE>  
        <!--指定 system.dbf 文件的镜像路径，默认为空 -->  
        <SYSTEM_MIRROR_PATH></SYSTEM_MIRROR_PATH>  
        <!--指定 main.dbf 文件的镜像路径，默认为空 -->  
        <MAIN_MIRROR_PATH></MAIN_MIRROR_PATH>  
        <!--指定 roll.dbf 文件的镜像路径，默认为空 -->  
        <ROLL_MIRROR_PATH></ROLL_MIRROR_PATH>  
        <!--是否是四权分立，默认值为 0(不使用)。仅在安全版本下可见和可设置。只能是 0 或 1 -->        <PRIV_FLAG>0</PRIV_FLAG>  
        <!--指定初始化过程中生成的日志文件所在路径。合法的路径，文件路径长度最大为 257(含结束符)，不包括文件名-->  
        <ELOG_PATH></ELOG_PATH>  
    </DB_PARAMS>  
    <!--是否创建数据库实例的服务，值 Y/N y/n，不允许为空，不初始化数据库将忽略此节点。非 root 用户不能创建数据库服务。 -->  
    <CREATE_DB_SERVICE>n</CREATE_DB_SERVICE>  
    <!--是否启动数据库，值 Y/N y/n，不允许为空，不创建数据库服务将忽略此节点。 -->  
    <STARTUP_DB_SERVICE>y</STARTUP_DB_SERVICE>  
</DATABASE>
```
## installDb2.sh

```sh
#!/bin/bash
pkgPath=/home/i2auto/soft/DB2/11.5/
pkgName=v11.5_linuxx64_dec.tar.gz
unzipDir=/root/db2v11.5

function copyDb2Packages(){
  echo "*****从共享上拷贝db2安装包*****"
  if [ -e $pkgPath/$pkgName ];then
    cp $pkgPath/$pkgName /root/
  else
    mount -t nfs 10.1.0.9:/share/autoPackage /home/i2auto
    cp $pkgPath/$pkgName /root/
  fi
}

function unzipDb2Package() {
  if [ -e /root/$pkgName ];then
    ! test -e aa && mkdir $unzipDir
    tar -xzvf /root/$pkgName -C $unzipDir
  fi
}

function installDb2() {
  /usr/bin/expect <<EOF
    set timeout 600
    spawn bash $unzipDir/server_dec/db2_install -f sysreq
    expect {
    "install process." {send "yes\r";exp_continue}
    "Install into default directory" {send "yes\r";exp_continue}
    "to exit." {send "SERVER\r";exp_continue}
    "install the DB2 pureScale Feature?" {send "no\r";exp_continue}
    "要接受这些条款，请输入“是”。否则，输入“否”以取消安装过程" {send "是\r";exp_continue}
    "是否安装到缺省目录" {send "是\r";exp_continue}
    "以退出" {send "SERVER\r";exp_continue}
    "要安装 DB2 pureScale Feature 吗" {send "否\r";exp_continue}
    }
    sleep 10
EOF
}

function createUserAndGroup() {
  groupadd -g 2000 db2iadm1
  groupadd -g 2001 db2fadm1
  # 创建用户，密码默认为: Dtt@2021
  useradd -m -g db2iadm1 -d /home/db2inst1 db2inst1 -p `openssl passwd Dtt@2021`
  useradd -m -g db2fadm1 -d /home/db2fenc1 db2fenc1 -p `openssl passwd Dtt@2021`
}

function createDb2Instance() {
  # 安装实例
  /opt/ibm/db2/V11.5/instance/db2icrt -p 50000 -u db2fenc1 db2inst1
  # 允许分页
  /opt/ibm/db2/V11.5/cfg/db2ln
  # 配置端口号
  echo 'db2inst1 50000/tcp' >> /etc/services
}

function configDb2() {
  su - db2inst1 <<EOF
    db2set DB2_EXTENDED_OPTIMIZATION=ON
    db2set DB2_DISABLE_FLUSH_LOG=ON
    db2set AUTOSTART=YES
    db2set DB2_HASH_JOIN=Y
    db2set DB2COMM=tcpip
    db2set DB2_PARALLEL_IO=*
    db2set DB2CODEPAGE=819
    db2start
EOF
}

function createDasManager() {
  groupadd -g 2002 db2asgrp
  useradd -m -g db2asgrp -d /home/db2as db2as -p `openssl passwd Dtt@2021`
  /opt/ibm/db2/V11.5/instance/dascrt -u db2as
  su - db2as -c "db2admin start"
}

echo "***************copyDb2Packages***************"
copyDb2Packages
if [ $? == 0 ]; then
  echo "***************unzipDb2Package***************"
  unzipDb2Package
  echo "***************installDb2***************"
  installDb2
  echo "***************createUserAndGroup***************"
  createUserAndGroup
  echo "***************createDb2Instance***************"
  createDb2Instance
  echo "***************configDb2***************"
  configDb2
  echo "***************createDasManager***************"
  createDasManager
fi
```

