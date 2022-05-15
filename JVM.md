### java 指令集

**由于跨平台性的设计，Java的指令都是根据栈来设计的。** 不同平台CPU架构不同，所以不能设计基于寄存器的指令集

* **优点** 跨平台性 、指令集小 、指令多
* **缺点** 执行性能比寄存器指令差

 ### JVM的生命周期

#### 虚拟机的启动 

Java虚拟机的启动是通过引导类加载器(**bootstrap class loader**) 创建一个初始类(**initial class** ) 来完成的，

这个类是由虚拟机的具体实现指定的。

#### 虚拟机的执行

* 一个运行中的Java虚拟机有着一个清晰的任务：执行Java程序
* 程序开始执行他才运行，程序结束时他就停止
* 执行一个所谓的Java程序的时候，真真正正在执行的是一个叫做Java虚拟机的进程

#### 虚拟机的退出

有如下的几种情况

1. 程序正常执行结束
2. 程序在执行过程中遇到了异常或错误而异常终止
3. 由于操做系统出现错误而导致Java虚拟机进程终止
4. 某线程调用Runtime类或System类的exit方法，或Runtime类的halt方法，并且Java安全管理器也允许这次exit操作或halt操作
5. 除此之外，JNI(java  Native Interface)规范描述了用JNI  Invocation API来加载或卸载 Java虚拟机是，Java虚拟机出现退出情况。

### [JVM发展历程](https://youthlql.gitee.io/javayouth/#/)



###  java.lang.OutOfMemoryError

1. 表示堆的内存不够
2. java虚拟机的堆内存设置不够，可以通过-Xms  -Xmx来调整
3. 代码中创建了大量的对象，并且长时间不能被垃圾收集器来收集(存在被引用)

