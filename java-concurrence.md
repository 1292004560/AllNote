## 进程通信的方式

1. **`socket`**
2. **`信号处理 (signal handlers)`**
3. **`共享内存 (shared memory)`**
4. **`信号量 (semaphores)`**
5. **`文件`**

## 为什么需要并发

1. `资源利用` ： 程序有的时候需要等待外部的操作，比如输入和输出。在等待的时候，让其他程序运行会提高效率。
2. `公平` :  **多个用户或程序可能对系统资源有平等的优先级别。让他们通过更好的时间片来共享计算机，这比结束一个程序后才开始下一个程序更可取。**
3. `方便` : 写一些程序，让他们，各自执行一个单独的任务并进行有必要的相互协调，这比写一个程序来执行所有的任务更容易。

## 无状态对象和有状态对象

1. **`无状态对象` **: 一个类的同一个实例被多个线程共享并不会使这些线程存储共享的状态,那么该类的实例就称为无状态对象(Stateless Object)   
2. **`有状态对象`** : 一个类的实例被多个线程共享会使这些线程存在共享状态,那么 该类的实例称为有状态对象

```java
import net.jcip.annotations.ThreadSafe;

@ThreadSafe
public class Stateless {
    

    public void getValue() {
        System.out.println("你好")
    }
}

注意: 所谓有状态对象和无状态对象的区别是，有状态对保存数据，所以当多个线程并发访问这个变量时，会产生线程不安全问题
     无状态对象他就是一组操作，不保存任何信息。

Java虚拟机栈是线程私有的，它的生命周期与线程相同。虚拟机栈描述的是Java方法执行的内存模型：每个方法在执行的同时都会创建一个栈帧用于存储局部变量表、操作数栈、动态链接、方法出口等信息。

局部变量的固有属性之一就是封闭在执行线程中。它们位于执行线程的栈中，其他线程无法访问这个栈。


import net.jcip.annotations.NotThreadSafe;

@NotThreadSafe
public class Stateful {
    
    public int value;


    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }
}
```

## 可重入的锁

**`重新进入意味着请求是基于 "每线程(pre-thread)", 而不是基于"   "每调用的(pre-invocation)" 。重进入的实现是通过为每个锁对象关联一个请求计数器(acquisition count) 和一个占有他的线程。当计数器为0时，认为锁是未被占有的。线程请求一个未被占有的锁时，JVM将记录锁的占有者，并且将计数器置为1。如果同一线程再次请求这个锁，计数将递增；每次占用线程退出同步块，计数器将递减。直到计数器达到0，锁被释放。  `**

## Vector 类一定是线程安全的吗？

```java
 if (!vector.contains(element)){
            vector.add(element);
  }
```

**这是经典的 put-if-absent  情况，尽管 contains, add 方法都正确地同步了，但作为 vector 之外的使用环境，仍然存在   race condition : 因为虽然条件判断  if (!vector.contains(element))与方法调用  vector.add(element);   都是原子性的操作 (atomic)，但在 if 条件判断为真后，那个用来访问vector.contains 方法的锁已经释放，在即将的 vector.add 方法调用 之间有间隙，在多线程环境中，完全有可能被其他线程获得 vector的 lock 并改变其状态, 此时当前线程的 vector.add(element);   正在等待（只不过我们不知道而已）。只有当其他线程释放了 vector 的 lock 后， vector.add(element);  继续，但此时它已经基于一个错误的假设了**

**Vector 和 ArrayList 实现了同一接口 List, 但所有的 Vector 的方法都具有 synchronized 关键修饰。但对于复合操作，Vector 仍然需要进行同步处理**

## 加锁和使用volatile的区别

- **`加锁可以保证可见性与原子性`**
- **`valatile变量只能保证原子性`**

## 什么情况下使用valatile变量

* **`写入变量时并不依赖变量的当前值；或者能够确保只有单一的线程修改变量的值；`**
* **`变量不需要与其他的状态变量共同参与不变约束；`**
* **`而且，访问变量时，没有其他的原因需要加锁。`**

## 发布和逸出

* **发布(publishing) 一个对象的意思是使他能够被当前范围之外的代码所使用。比如将一个引用存储到其他代码可以访问的地方，在一个非私有的方法中返回这个引用，也可以把它传递到其他类的方法中**
*  **如果发布对象时它还没有完成构造，这种情况叫逸出**

## 安全发布对象

### 错误发布对象

```java
public class ThisEscape {
　　public ThisEscape(EventSource source) {
　　　　source.registerListener(new EventListener() {
　　　　　　public void onEvent(Event e) {
　　　　　　　　doSomething(e);
　　　　　　}
　　　　});
　　}
 
　　void doSomething(Event e) {
　　}
 
　　interface EventSource {
　　　　void registerListener(EventListener e);
　　}
 
　　interface EventListener {
　　　　void onEvent(Event e);
　　}
 
　　interface Event {
　　}
}
```

**这将导致this逸出，所谓逸出，就是在不该发布的时候发布了一个引用。在这个例子里面，当我们实例化ThisEscape对象时，会调用source的registerListener方法，这时便启动了一个线程，而且这个线程持有了ThisEscape对象（调用了对象的doSomething方法），但此时ThisEscape对象却没有实例化完成（还没有返回一个引用），所以我们说，此时造成了一个this引用逸出，即还没有完成的实例化ThisEscape对象的动作，却已经暴露了对象的引用。其他线程访问还没有构造好的对象，可能会造成意料不到的问题。**

### 正确发布对象

```java
public class SafeListener {
　　private final EventListener listener;
 
　　private SafeListener() {
　　　　listener = new EventListener() {
　　　　　　public void onEvent(Event e) {
　　　　　　　　doSomething(e);
　　　　　　}
　　　　};
　　} 
　　public static SafeListener newInstance(EventSource source) {
　　　　SafeListener safe = new SafeListener();
　　　　source.registerListener(safe.listener);
　　　　return safe;
　　}
　　void doSomething(Event e) {
　　}
 
　　interface EventSource {
　　　　void registerListener(EventListener e);
　　}
 
　　interface EventListener {
　　　　void onEvent(Event e);
　　}
 
　　interface Event {
　　}
　}
```

**在这个构造中，我们看到的最大的一个区别就是：当构造好了SafeListener对象（通过构造器构造）之后，我们才启动了监听线程，也就确保了SafeListener对象是构造完成之后再使用的SafeListener对象。**

**具体来说，只有当构造函数返回时，this引用才应该从线程中逸出。构造函数可以将this引用保存到某个地方，只要其他线程不会在构造函数完成之前使用它。**

## 什么样的对象是不可变的

* **`他的状态不能在创建后再被修改；`**
* **`所有的域都是final类型；`**
* **`并且，它被正确创建(创建期间没有发生this应用)逸出。`**

**注意 : 不可变性并不简单地等于将对象中的所有域都声明为final 类型，所有域都是final类型的对象仍然是可变的，因为final域可以获得一个可变对象的引用。  **

## 这段代码为什么线程安全的

```java
import net.jcip.annotations.Immutable;

import java.math.BigInteger;
import java.util.Arrays;

@Immutable
class OneValueCache {
    
    private final BigInteger lastNumber;
    
    private final BigInteger[] lastFactors;
    
    public OneValueCache(BigInteger i, BigInteger[] factors){
        lastNumber = i;
        lastFactors = Arrays.copyOf(factors,factors.length);
    }
    
    public BigInteger[] getFactors(BigInteger i){
        if (lastNumber == null || !lastNumber.equals(i))
            return null;
        else 
            return Arrays.copyOf(lastFactors,lastFactors.length);
    }
}

@ThreadSafe
public class VolatileCachedFactorizer implements Servlet {
    
    private volatile  OneValueCache cache = new OneValueCache(null,null);
   
    @Override
    public void service(ServletRequest request, ServletResponse response)  {

        BigInteger i = extractFromRequest(request);
        BigInteger [] factors = cache.getFactors(i);
        if (factors == null){
            factors = factors(i);
            cache = new OneValueCache(i, factors);
        }
        encodeIntoResponse(response,factors);
    }
}
```

## 安全发布模式

如果一个对象不是不可变的，它必须被安全地发布，通常发布线程与消费线程都必须同步化。此刻让我们关注一下，如何确保消费线程能够看到处于发布当时的对象状态 ; 我们要解决对象发布后对其修改的可见性问题。

```java
  为了安全发布对象，对象的引用以及对象的状态必须同时对其他线程可见。一个正确创建的对象可以通过下列条件安全发布。
  1. 通过静态初始化器初始化对象的引用;
  	public static Holder hodler = new Holder(42);
	这种方式就是使用静态初始化器，也是最简单和最安全的发布模式;
    静态初始化器是由JVM在类的初始化阶段执行，由于JVM内在的同步，该机制确保了以这种方式初始化的对象可以被安全的发布
  2. 将它的引用存储到volatile域或AtomicReference;
  3. 将它的引用存储到正确创建的对象的final域中;
  4. 将它的引用存储到由锁正确保护的域中;
```

## 安全共享对象的策略

* **线程限制 : ** 一个线程限制的对象，通过限制在线程中，而线程独占，且只能被他占用的线程修改。

* **共享只读(shared read-only) : ** 一个共享的只读对象，在没有额外同步的情况下，可以被多个线程并发访问，但是任何线程都不能修改它。共享只读对象包括可变对象与高效不可变对象。

  ​      `注意 : 发布之后不会被修改的对象称为高效不可变对象` 

* **共享线程安全(shared thread-safe)  : ** 一个线程安全的对象在内部进行同步，所以其他线程无须额外同步，就可以通过公共接口随意的访问它。

* **被守护的(Guarded)  : ** 一个被守护的对象只能通过特定的锁来访问。被守护的对象包括那些被线程安全对象封装的对象，和已知被特定的锁保护起来的已发布对象。



