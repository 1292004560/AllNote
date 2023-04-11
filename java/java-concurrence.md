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



## JAVA并发——客户端加锁机制, 内置锁——面试题

```JAVA

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
@NotThreadSafe 
public class ListHelp<E> {
    public List<E> list = Collections.synchronizedList(new ArrayList<E>());
    
    // 方法1
    public synchronized boolean putIfAbsent(E x) { // 这个方法并不是线程安全的，因为当前只获得了ListHelp的锁，并没有获得list                                                     的锁，没有办法保证当前操作的原子性
        boolean absent = !list.contains(x);
        if (absent) {
            list.add(x);
        }
        return absent;
    }
}
方法1的同步方法中对list进行先检查后执行的操作（一般都要求先检查后执行的操作是原子性的），但是list对象并不是你这个方法所私有的，看着list是public的，也就是说，list是发布出去的，其他地方可以修改这个list。而在方法1中执行完list.contain(x)后，其他方法可以对list进行添加或者删除元素操作，导致方法1中的absent结果会失效，当你根据失效的absent结果去进行操作时，必然导致数据上不一致的问题。那么为什么这个类是不安全的呢，因为方法1获得了ListHelp的锁并没有获得list的锁，导致，方法1中对list的先检查后执行操作不是满足原子性的。
    
    
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
@ThreadSafe 
public class ListHelp<E> {
    public List<E> list = Collections.synchronizedList(new ArrayList<E>());
    // 方法2
    public  boolean putIfAbsentSafe(E x) { // 这个方法是线程安全的
        synchronized(list ) {
            boolean absent = !list.contains(x);
            if (absent) {
                list.add(x);
            }
            return absent;
        }
    }
}
```

## 同步容器可能出现的问题

`Vector 、 HashTable 、 Collections.sysnchronizedxx`

**这些同步容器对于一些复合操作，有时可能需要使用额外的客户端加锁(client-side locking) 进行保护**

* `迭代(反复获取元素，直到获得容器的最后一个元素)`
* `导航(navigation, 根据一定的顺序查找下一个元素)`
* `条件运算,如"缺少即加入(put-if-absent)"`

## 为计算结果建立高效、可伸缩的高速缓存

1. 第一种实现

```java

//Computable <A, V> 接口描述了一个功能，输入类型是A，输出结果类型是V。ExpensiveFunction实现了Computable，需要花很长时间计算的结果
public interface Computable <A, V>{

    V compute(A arg) throws InterruptedException;
}


public class ExpensiveFunction  implements Computable<String, BigInteger> {
    @Override
    public BigInteger compute(String arg) throws InterruptedException {

        // after deep thought
        return new BigInteger(arg);
    }
}



public class Memorizer1<A, V> implements Computable<A,V> {


    private final Map<A, V> cache = new HashMap<>();

    private final Computable<A, V> c;


    public Memorizer1(Computable<A,V> c){
        this.c = c;
    }

    @Override
    public synchronized V compute(A arg) throws InterruptedException {

        V result = cache.get(arg);
        if (result == null){
            result = c.compute(arg);
            cache.put(arg, result);
        }
        return result;
    }
}
// 这种实现方式为了保护两个线程不会同步访问HashMap,同步了整个compute方法。这样保证了线程安全，但是带来一个明显的可伸缩性问题。
```

2. 第二种实现

```java
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class Memoizer2 <A, V> implements Computable<A, V>{

    private final Map<A ,V> cache = new ConcurrentHashMap<>();


    private final Computable<A,V> c;

    public Memoizer2(Computable<A, V> c){
        this.c = c;
    }
    @Override
    public V compute(A arg) throws InterruptedException {

        V result = cache.get(arg);
        if (result == null){
            result = c.compute(arg);
            cache.put(arg, result);
        }
        return result;
    }
}

// Memoizer2 用ConcurrentHashMap取代HashMap，改进了Memoizer1中这种糟糕的并发行为。因为ConcurrentHashMap是线程安全的，所以不需要在访问底层Map时对它进行同步，这样减少了在Memoizer1中同步compute带来冗长代码。
// Memoizer2与Memoizer1相比，具有更好的并发性；多线程可以真正的并发使用它。但是作为高速缓存仍然存在缺陷-- 当两个线程同时调用compute方法时，存在一个漏洞，会造成它们计算相同的值。在备忘录这种情况下，这仅仅是效率低而已--高速缓存的目的就是避免重复计算数据。但是对于高速缓存机制更多元化的用途而言，这就不仅仅是效率问题；一个缓存对象仅仅能够被初始化一次的话，这个漏洞会带来安全风险。

// Memoizer2的问题在于，如果一个线程启动了一个开销很大的计算，其他线程并不知道这个线程正在进行中，所以会重复这个计算。
```

3. 第三种实现

```java
import java.util.concurrent.*;

public class Memoizer3<A, V> implements Computable<A, V> {


    private final ConcurrentHashMap<A, Future<V>> cache = new ConcurrentHashMap<>();

    private final Computable<A, V> c;

    public Memoizer3(Computable<A, V> c) {
        this.c = c;
    }

    @Override
    public V compute(final A arg) throws InterruptedException {
        while (true) {
            Future<V> future = cache.get(arg);
            if (future == null) {
                Callable<V> eval = () -> c.compute(arg);

                FutureTask<V> futureTask = new FutureTask<>(eval);
                future = cache.put(arg, futureTask);
                if (future == null) {
                    future = futureTask;
                    futureTask.run();// 调用c.compute发生在这里
                }
            }
            try {
                return future.get();
            } catch (CancellationException e) {
                cache.remove(arg, future);
            } catch (ExecutionException e) {
                throw new RuntimeException();
            }
        }
    }
}
// FutrueTask代表一个计算的过程，可能已经结束，也可能正在运行中。FutureTask.get只要结果可用，就会将结果返回；否则它就会一直阻塞，直到结果被计算出来，并返回。
// Memoizer3为缓存的值重新定义可存储Map,用ConcurrenHashMap<A,Future<V>>取代了ConcurrenHashMap<A,V> 。Memoizer3首先检查一个相应的计算是否已经开始，(Memoizer2 与它相反，它会判断计算是否完成)。如果不是，就会创建一个FutureTask,把它注册到Map中,并开始计算；如果是，那么它就会等待正在进行的计算。结果可能很快就会得到，或者正在运算的过程中--但是这对于调用者Future.get来说是透明的。
// Memoizer3的实现近乎完美：它展现了非常好的并发性(大部分来源于ConcurrentHashMap良好的并发性)，能很快返回已经计算的结果，如果新到的线程请求的是其他线程真在计算的结果,他会耐心地等待。它只存在一个缺陷--两个线程可能同时计算相同的值，它仅仅存在这一个漏洞。这个漏洞远不如Memoizer2的严重，仅仅是因为compute中的if代码块是非原子(nonatomic) 的"检查再运行"序列，仍然存在这种可能：两个线程几乎同时调用compute计算相同的值，双方都没有在缓存中找到期望的值，并开始计算。
```

4. 完美实现

```java
import java.util.concurrent.*;

public class Memorizer<A, V> implements Computable<A, V>{


    private final ConcurrentHashMap<A, Future<V>> cache = new ConcurrentHashMap<>();

    private final Computable<A, V> c;

    public Memorizer(Computable<A , V> c){
        this.c = c;
    }

    @Override
    public V compute(final  A arg) throws InterruptedException{
        while (true){
            Future<V> future = cache.get(arg);
            if (future == null){
                Callable<V> eval = () -> c.compute(arg);

                FutureTask<V> futureTask = new FutureTask<>(eval);
                future = cache.putIfAbsent(arg, futureTask);
                if (future == null){
                    future = futureTask;
                    futureTask.run();
                }
            }
            try {
                return  future.get();
            }catch (CancellationException e){
                cache.remove(arg, future);
            }catch (ExecutionException e){
                throw new RuntimeException();
            }
        }
    }

}

// Memorizer 利用ConcurrentHashMap中的原子化的putIfAbsent方法，消除了Memorizer3的隐患。
// 为了防止缓存污染，如果一个计算被取消或者失败，Memorizer就会把Future从缓存中移除。
```

## 第一部分总结

* 可变状态

  所有并发问题都归结为如何协调并发状态。可变状态越少，保证线程安全就越容易。

* 尽量将域声明为final类型，除非它们需要是可变的。

* 不可变对象天生是线程安全的。

  不可变对象极大地减轻了并发编程地压力。他们简单而且安全，可以在没有锁或者防御性复制的情况下自由的共享。

* 封装使管理复杂度变得更可行。

  你固然可以用存储全局变量的数据来写一个线程安全类。但是你为什么要这么做？在对象中封装数据，让她们能够更加容易地保持不变 ; 在对象中封装同步，使他们更容易地遵守同步策略。

* 用锁来守护每一个可变变量。

* 对同一不变约束中地所有变量都使用相同地锁。

* 在运行复合操作期间持有锁。

* 在非同步地多线程情况下，访问可变变量地程序存在隐患的。

* 在设计过程中就考虑线程安全。或者在文档中明确地说明它不是线程安全的。

* 文档化你的同步策略。

## 使用阻塞队列来实现生产者和消费者模式

```java
import java.util.concurrent.BlockingQueue;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Producer implements Runnable{


    private final BlockingQueue sharedQueue;



    public Producer(BlockingQueue sharedQueue) {

        this.sharedQueue = sharedQueue;

    }



    @Override

    public void run() {
        for(int i=0; i<10; i++){
            try {
                System.out.println("Produced: " + i);
                sharedQueue.put(i);
            } catch (InterruptedException ex) {
                Logger.getLogger(Producer.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////


import java.util.concurrent.BlockingQueue;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Consumer implements Runnable{


    private final BlockingQueue sharedQueue;



    public Consumer (BlockingQueue sharedQueue) {

        this.sharedQueue = sharedQueue;

    }



    @Override

    public void run() {

        while(true){

            try {

                System.out.println("Consumed: "+ sharedQueue.take());

            } catch (InterruptedException ex) {

                Logger.getLogger(Consumer.class.getName()).log(Level.SEVERE, null, ex);

            }

        }

    }




}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;

public class ProducerConsumerPattern {

    public static void main(String args[]){



        //Creating shared object

        BlockingQueue sharedQueue = new LinkedBlockingQueue();



        //Creating Producer and Consumer Thread

        Thread prodThread = new Thread(new Producer(sharedQueue));

        Thread consThread = new Thread(new Consumer(sharedQueue));



        //Starting producer and Consumer thread

        prodThread.start();

        consThread.start();

    }
}

```

## 不可取消的任务在退出前保存中断

```java
public Task getNextTask(BlockingQueue<Task> queue){
    boolean interrupted = false;
    try{
        while(true){
            try{
                return queue.take();
            }catch(Exception e){
                interrupted = true;
            }
        }finally{
            if (interrupted)
                Thread.currentThread().interrupt();
        }
    }
}
```

## 如何减少上下问切换

减少上下文切换的方法有无锁并发编程、`CAS算法`、`使用最少线程`和`使用协程`。

* 无锁并发编程

  多线程竞争锁时，会引起上下文切换，所以多线程处理数据时，可以用一些办法来避免使用锁，如将数据的ID按照Hash算法取模分段，不同的线程处理不同段的数据。

* `CAS`算法

  Java的Atomic包使用`CAS`算法来更新数据，而不需要加锁

* 使用最少线程

  避免创建不需要的线程，比如任务很少，但是创建了很多线程来处理，这样会造成大量线程都处于等待状态

* 协程

  在单线程里实现多任务的调度，并在单线程里维持多个任务间的切换



## 避免死锁的方法

* 避免一个线程同时获取多个锁
* 避免一个线程在锁内同时占用多个资源，尽量保证每个锁只占用一个资源
* 尝试使用定时锁，使用`lock.tryLock（timeout）`来替代使用内部锁机制
* 对于数据库锁，加锁和解锁必须在一个数据库连接里，否则会出现解锁失败的情况

## volatile读的内存语义

当读一个`volatile`变量时，`JMM`会把该线程对应的本地内存置为无效。线程接下来将从主内存中读取共享变量

## volatile重排序规则表

* 当第二个操作是volatile写时，不管第一个操作是什么，都不能重排序。这个规则确保volatile写之前的操作不会被编译器重排序到volatile写之后
* 当第一个操作是volatile读时，不管第二个操作是什么，都不能重排序。这个规则确保volatile读之后的操作不会被编译器重排序到volatile读之前
* 当第一个操作是volatile写，第二个操作是volatile读时，不能重排序

## `JMM`内存屏障插入策略

* 在每个volatile写操作的前面插入一个`StoreStore`屏障。
*  在每个volatile写操作的后面插入一个`StoreLoad`屏障。
* 在每个volatile读操作的后面插入一个`LoadLoad`屏障。
* 在每个volatile读操作的后面插入一个`LoadStore`屏障。
