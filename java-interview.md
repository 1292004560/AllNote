

### jvm 字节码



### JUC (java.util.concurrent)

1.1  进程/线程

1.2 并发/并行

### 三个包

java.util.concurrent

java.util.concurrent.atomic

java.util.concurrent.locks





### volatile关键字

* 是 `java` 虚拟机提供的轻量级同步机制
  * `保证可见性`
  * `不保证原子性`
  * `禁止指令重排序`

思考  如何解决线程拷贝过多



CAS--> Unsafe --> CAS底层思想 --> ABA --> 原子应用更新 --> 如何规避ABA问题

### 为什么说Java是跨平台的

java文件编译后生成class文件，运行在jvm上，在不同平台不需要重新编译，只需要部署jvm

### Thread类

