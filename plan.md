### 将对象查出来就是持久化状态
### 如果对他进行事务的处理，是可以同步到数据库中去的

### springboot单元测试时测试类一定要和启动类在同一模块中，并且包名要一致

### springboot的启动类需要以下两个注解

### @SpringBootApplication

### @EnableTransactionManagement

### 单元测试时单元测试类要用	@SpringBootTest(classes = "springboot启动类")

### @RunWith(SpringJUnit4ClassRunner.class)

### 还要开启session与数据库会话，最后关闭事务用@Before 和   @After两个注解

### 为什么一对多都是set集合的方式

### 什么时候不使用消息队列：调用方实时依赖执行结果的业务场景，请使用调用，而不是MQ。（比如说登录服务）

### 对任意字符串处理时要防止出现空的字符串，要对空的字符串进行特殊处理

### transient static不能被序列化

### 被所有对象共享

### 动态代理和静态代理的意思

### 序列化多个对象的问题

### 数据库原理

### 操作系统

### 计算机网络

### linux操作系统

### 设计模式

### C语言

### leetcode

### 多线程

### 项目

### spring

### Java IO包 NIO包AIO包

### List，Set，Hashmap，Hashtable, 

### ConcurrentHashMap,BlockingQueue,ConcurrentLinkedQueue,CopyOnWriteArraylist，Arraylist，TreeSet，T

### reeMap,LinkedList,Vector,String,StringBuilder,StringBuffer源码

### Semaphore  Exchanger  StampedLock

### 锁降级和锁升级的问题

### 锁降级

1. 锁降级就是指写锁降级为读锁
2. 在写锁没有释放的时候获取读锁，获取读锁在释放写锁

### 锁升级

1. 锁降级就是指写锁降级为读锁
2. 在写锁没有释放的时候获取读锁，获取读锁在释放写锁

### 锁

1. “锁
2. 偏向锁
3. 轻量级锁
4. 重量级锁
5. 重入锁
6. 自旋锁
7. 共享锁
8. 独占锁
9. 排他锁
10. 读写锁
11. 公平锁
12. 非公平锁
13. 死锁
14. 活锁

### String、Integer、Long、Enum、BigDecimal、ThreadLocal、ClassLoader & URLClassLoader、ArrayList & LinkedList、 HashMap 
 LinkedHashMap & TreeMap 
 CouncurrentHashMap、HashSet & LinkedHashSet & TreeSet
### 装饰者模式理解  静态代码块   构造代码块   构造函数
### linux命令三剑客  grep   sed  akw   pcretest  rpm

### make make install 命令

### tail

### ab  curl

### fork/join框架

### 多线程 io nio socket

​	