###  对象的实例化

#### 1. 创建对象的方式

```java
new 是最常见的方式
	变形 1 ： XXxx的静态方法
	变形 2 ： XxxBuider/XxxFactory的静态方法
Class 的 newInstance() :反射的方法 ，只能调用空参构造器，权限必须是 public
Constructor的 newInstance(...) : 可以调用空参 、带参的构造器，权限没有要求
使用 clone() 方法 不调用任何构造器 当前类需要实现 Cloneable 接口,实现 clone()方法
使用序列化 从文件从网络中获取一个对象的二进制流
第三方库 Objenesis


```

#### 2. 对象的创建步骤

```java
1. 判断对象是否加载、链接、初始化
2. 为对象分配内存
	如果内存完整 ---- 指针碰撞
	如果内存不完整 ---- 虚拟机需要维护一个列表
				----- 空闲列表分配
3. 处理并发安全问题 
4. 初始化分配到的空间
5. 设置对象头
6. 执行init()方法初始化
```



## 接口和抽象类的异同

```java
//在jdk7中只能声明全局常量和抽象方法
public static final NAME = "zhoushuiping";

//在jdk8中能声明静态方法和默认方法
static void method(){}
default void method2(){}

//在jdk9中可以声明私有方法
public interface MyInterface {


    default void method1(){
        method();
    }

    private void method(){
        System.out.println("调用了method");
    }
}

class MyInterfaceImpl implements MyInterface{
    public static void main(String[] args) {
        MyInterface myInterface = new MyInterfaceImpl();
        myInterface.method1();
    }
}


```

## JDK 对try catch的优化

```java
public class TryTest {

    //JDK7
    @Test
    public void testTryJDK7(){
        InputStreamReader reader = null;
        try {
            reader = new InputStreamReader(System.in);
            reader.read();
        }catch (IOException e){
            e.printStackTrace();
        }finally {
            //资源关闭操作
            if (reader!=null){
                try {
                    reader.close();
                }catch (IOException e){
                    e.printStackTrace();
                }
            }
        }
    }

    //JDK8中：要求资源对象实例化。不用显示处理资源关闭
    @Test
    public void testTryJDK8(){
        try (InputStreamReader reader = new InputStreamReader(System.in)){

            //读取数据的过程
            reader.read();
        }catch (IOException e){
            e.printStackTrace();
        }
    }

    //JDK9中可以在try()中调用已经实例化的对象
    @Test
    public void testTryJDK9(){
        InputStreamReader reader = new InputStreamReader(System.in);
         OutputStreamWriter writer = new OutputStreamWriter(System.out);
        try (reader;writer){
            //数据处理过程
            //此时reder是 final的，不可在被赋值
            reader.read();
        }catch (IOException e) {
            e.printStackTrace();
        }
    }

}


```

## JDK9之后对String的改变

> String : JDK8 及之前，底层使用char[] 存储 JDK9之后底层使用byte[]
>
> StringBuffer 和 StringBuilder 也做了相同的改变

## 关于String的面试题

``` java
new String("ab")会创建几个对象
	一个对象是： new 关键字会在堆空间创建
	另一个对象是：字符串常量池中的对象 字节码指令  ldc

new String("a") + new String("b")会创建几个对象
	对象1 ： new StringBuilder() 字符串拼接需要创建的对象
	对象2 ： new String("a")
    对象3 ： 常量池的 "a"
    对象4 ： new String("b")
    对象5 ： 常量池的 "b"
    
    更加深入 StringBuidler 的 toString()
    对象6 ： new String("ab")
    强调一下 toString() 的调用，在常量池中并没有生成 "ab"
```

 ```java
public class StringIntern {
    public static void main(String[] args) {

        String s = new String("1");
        s.intern();//调用此方法之前，字符串常量池中已经存在了"1"
        String s2 = "1";
        System.out.println(s == s2);//jdk6：false   jdk7/8：false

		//s3变量记录的地址为：new String("11")
        String s3 = new String("1") + new String("1");
        
        //执行完上一行代码以后，字符串常量池中，是否存在"11"呢？答案：不存在！！
        s3.intern();//在字符串常量池中生成"11"。如何理解：jdk6:创建了一个新的对象"11",也就有新的地址。
                                            //         jdk7:此时常量中并没有创建"11",而是创建一个指向堆空间中new String("11")的地址
        String s4 = "11";//s4变量记录的地址：使用的是上一行代码代码执行时，在常量池中生成的"11"的地址
        System.out.println(s3 == s4);//jdk6：false  jdk7/8：true
    }


}
注意 : jdk6 与 jdk7 不同的原因 一个字符串常量池在永久代中  和 一个字符串常量池在堆空间中
 ```

```java
 public static void main(String[] args) {
        
        String s = new String("a") + new String("b");//new String("ab")
        //在上一行代码执行完以后，字符串常量池中并没有"ab"

        String s2 = s.intern();//jdk6中：在串池中创建一个字符串"ab"
                               //jdk8中：串池中没有创建字符串"ab",而是创建一个引用，指向new 									//		String("ab")，将此引用返回

        System.out.println(s2 == "ab");//jdk6:true  jdk8:true
        System.out.println(s == "ab");//jdk6:false  jdk8:true
    }
```

```java

/**
 * 字符串拼接操作
 
 */
public class StringTest5 {
    @Test
    public void test1(){
        String s1 = "a" + "b" + "c";//编译期优化：等同于"abc"
        String s2 = "abc"; //"abc"一定是放在字符串常量池中，将此地址赋给s2
        /*
         * 最终.java编译成.class,再执行.class
         * String s1 = "abc";
         * String s2 = "abc"
         */
        System.out.println(s1 == s2); //true
        System.out.println(s1.equals(s2)); //true
    }

    @Test
    public void test2(){
        String s1 = "javaEE";
        String s2 = "hadoop";

        String s3 = "javaEEhadoop";
        String s4 = "javaEE" + "hadoop";//编译期优化
        //如果拼接符号的前后出现了变量，则相当于在堆空间中new String()，具体的内容为拼接的结果：javaEEhadoop
        String s5 = s1 + "hadoop";
        String s6 = "javaEE" + s2;
        String s7 = s1 + s2;

        System.out.println(s3 == s4);//true
        System.out.println(s3 == s5);//false
        System.out.println(s3 == s6);//false
        System.out.println(s3 == s7);//false
        System.out.println(s5 == s6);//false
        System.out.println(s5 == s7);//false
        System.out.println(s6 == s7);//false
        //intern():判断字符串常量池中是否存在javaEEhadoop值，如果存在，则返回常量池中javaEEhadoop的地址；
        //如果字符串常量池中不存在javaEEhadoop，则在常量池中加载一份javaEEhadoop，并返回次对象的地址。
        String s8 = s6.intern();
        System.out.println(s3 == s8);//true
    }

    @Test
    public void test3(){
        String s1 = "a";
        String s2 = "b";
        String s3 = "ab";
        /*
        如下的s1 + s2 的执行细节：(变量s是我临时定义的）
        ① StringBuilder s = new StringBuilder();
        ② s.append("a")
        ③ s.append("b")
        ④ s.toString()  --> 约等于 new String("ab")

        补充：在jdk5.0之后使用的是StringBuilder,在jdk5.0之前使用的是StringBuffer
         */
        String s4 = s1 + s2;//
        System.out.println(s3 == s4);//false
    }
    /*
    1. 字符串拼接操作不一定使用的是StringBuilder!
       如果拼接符号左右两边都是字符串常量或常量引用，则仍然使用编译期优化，即非StringBuilder的方式。
    2. 针对于final修饰类、方法、基本数据类型、引用数据类型的量的结构时，能使用上final的时候建议使用上。
     */
    @Test
    public void test4(){
        final String s1 = "a";
        final String s2 = "b";
        String s3 = "ab";
        String s4 = s1 + s2;
        System.out.println(s3 == s4);//true
    }
    //练习：
    @Test
    public void test5(){
        String s1 = "javaEEhadoop";
        String s2 = "javaEE";
        String s3 = s2 + "hadoop";
        System.out.println(s1 == s3);//false

        final String s4 = "javaEE";//s4:常量
        String s5 = s4 + "hadoop";
        System.out.println(s1 == s5);//true

    }

    /*
    体会执行效率：通过StringBuilder的append()的方式添加字符串的效率要远高于使用String的字符串拼接方式！
    详情：① StringBuilder的append()的方式：自始至终中只创建过一个StringBuilder的对象
          使用String的字符串拼接方式：创建过多个StringBuilder和String的对象
         ② 使用String的字符串拼接方式：内存中由于创建了较多的StringBuilder和String的对象，内存占用更大；如果进行GC，需要花费额外的时间。

     改进的空间：在实际开发中，如果基本确定要前前后后添加的字符串长度不高于某个限定值highLevel的情况下,建议使用构造器实例化：
               StringBuilder s = new StringBuilder(highLevel);//new char[highLevel]
     */
    @Test
    public void test6(){

        long start = System.currentTimeMillis();

//        method1(100000);//4014
        method2(100000);//7

        long end = System.currentTimeMillis();

        System.out.println("花费的时间为：" + (end - start));
    }

    public void method1(int highLevel){
        String src = "";
        for(int i = 0;i < highLevel;i++){
            src = src + "a";//每次循环都会创建一个StringBuilder、String
        }
//        System.out.println(src);

    }

    public void method2(int highLevel){
        //只需要创建一个StringBuilder
        StringBuilder src = new StringBuilder();
        for (int i = 0; i < highLevel; i++) {
            src.append("a");
        }
//        System.out.println(src);
    }
}

```

## Reference

### 强引用(Strong Reference)

最传统的引用定义，是指代码之中普遍存在引用赋值，及类似 Object obj = new Object(); 这种引用关系。**无论任何情况下，只要强引用对象关系还存在，垃圾收集器就永远不会回收掉被引用的对象**.

### 软引用(Soft Reference)

在系统将要发生内存溢出之前，将会把这些对象列入回收范围之中进行二次回收。如果这次回收还没有足够的内存，才会抛出内存溢出的异常。

```java
//通过 -Xms10m  -Xmx10m 设置内存
public class SoftReferenceTest {
    public static class User {
        public User(int id, String name) {
            this.id = id;
            this.name = name;
        }

        public int id;
        public String name;

        @Override
        public String toString() {
            return "[id=" + id + ", name=" + name + "] ";
        }
    }

    public static void main(String[] args) {
        //创建对象，建立软引用
//        SoftReference<User> userSoftRef = new SoftReference<User>(new User(1, "songhk"));
        //上面的一行代码，等价于如下的三行代码
        User u1 = new User(1,"songhk");
        SoftReference<User> userSoftRef = new SoftReference<User>(u1);
        u1 = null;//取消强引用


        //从软引用中重新获得强引用对象
        System.out.println(userSoftRef.get());

        System.gc();
        System.out.println("After GC:");
//        //垃圾回收之后获得软引用中的对象
        System.out.println(userSoftRef.get());//由于堆空间内存足够，所有不会回收软引用的可达对象。
//
        try {
            //让系统认为内存资源紧张、不够
//            byte[] b = new byte[1024 * 1024 * 7];
            byte[] b = new byte[1024 * 7168 - 635 * 1024];
        } catch (Throwable e) {
            e.printStackTrace();
        } finally {
            //再次从软引用中获取数据
            System.out.println(userSoftRef.get());//在报OOM之前，垃圾回收器会回收软引用的可达对象。
        }
    }
}

```



### 弱引用(Weak Reference)

被弱引用关联的对象只能生存到下一次垃圾收集之前。当垃圾收集器工作是，无论空间是否足够，都会回收掉被弱引用关联的对象。

```java
public class WeakReferenceTest {
    public static class User {
        public User(int id, String name) {
            this.id = id;
            this.name = name;
        }

        public int id;
        public String name;

        @Override
        public String toString() {
            return "[id=" + id + ", name=" + name + "] ";
        }
    }

    public static void main(String[] args) {
        //构造了弱引用
        WeakReference<User> userWeakRef = new WeakReference<User>(new User(1, "songhk"));
        //从弱引用中重新获取对象
        System.out.println(userWeakRef.get());

        System.gc();
        // 不管当前内存空间足够与否，都会回收它的内存
        System.out.println("After GC:");
        //重新尝试从弱引用中获取对象
        System.out.println(userWeakRef.get());
    }
}
 // WeakHashMap
```



### 虚引用(Phantom Reference)

一个对象是否有虚引用的存在，完全不会对其生存时间构成影响，也无法通过虚引用来获得一个对象的实例。为一个对象设置虚引用的**唯一目的就是能在这个对象被垃圾收集器回收时收到一个系统通知**。

虚引用必须和引用队列以前使用。虚引用在创建时必须提供一个引用队列作为参数。当垃圾回收器准备回收一个对象时，虚引用加入引用队列，以通知应用程序对象的回收情况。

**由于虚引用可以跟踪对象的回收时间，因此，也可以将一些资源释放的操作放置在虚引用中执行和记录**。

```java
public class PhantomReferenceTest {
    public static PhantomReferenceTest obj;//当前类对象的声明
    static ReferenceQueue<PhantomReferenceTest> phantomQueue = null;//引用队列

    public static class CheckRefQueue extends Thread {
        @Override
        public void run() {
            while (true) {
                if (phantomQueue != null) {
                    PhantomReference<PhantomReferenceTest> objt = null;
                    try {
                        objt = (PhantomReference<PhantomReferenceTest>) phantomQueue.remove();
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                    if (objt != null) {
                        System.out.println("追踪垃圾回收过程：PhantomReferenceTest实例被GC了");
                    }
                }
            }
        }
    }

    @Override
    protected void finalize() throws Throwable { //finalize()方法只能被调用一次！
        super.finalize();
        System.out.println("调用当前类的finalize()方法");
        obj = this;
    }

    public static void main(String[] args) {
        Thread t = new CheckRefQueue();
        t.setDaemon(true);//设置为守护线程：当程序中没有非守护线程时，守护线程也就执行结束。
        t.start();

        phantomQueue = new ReferenceQueue<PhantomReferenceTest>();
        obj = new PhantomReferenceTest();
        //构造了 PhantomReferenceTest 对象的虚引用，并指定了引用队列
        PhantomReference<PhantomReferenceTest> phantomRef = new PhantomReference<PhantomReferenceTest>(obj, phantomQueue);

        try {
            //不可获取虚引用中的对象
            System.out.println(phantomRef.get());

            //将强引用去除
            obj = null;
            //第一次进行GC,由于对象可复活，GC无法回收该对象
            System.gc();
            Thread.sleep(1000);
            if (obj == null) {
                System.out.println("obj 是 null");
            } else {
                System.out.println("obj 可用");
            }
            System.out.println("第 2 次 gc");
            obj = null;
            System.gc(); //一旦将obj对象回收，就会将此虚引用存放到引用队列中。
            Thread.sleep(1000);
            if (obj == null) {
                System.out.println("obj 是 null");
            } else {
                System.out.println("obj 可用");
            }
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
```

### 终结器引用(Final Reference)

* 它用以实现对象的finalize()方法，也可以称为终结器引用。
* 无需手动编码，其内部配合引用队列使用。
* 在 GC 时，终结器引用入队。由 Finalizer线程通过终结器引用找到被引用对象并调用它的finalize()方法，第二次GC时才能回收被引用对象。 

 ## 成员变量初始化(非静态)

```java
/*
成员变量（非静态的）的赋值过程： ① 默认初始化 - ② 显式初始化 /代码块中初始化 - ③ 构造器中初始化 - ④ 有了对象之后，可以“对象.属性”或"对象.方法"
 的方式对成员变量进行赋值。
 */
class Father {
    int x = 10;

    public Father() {
        this.print();
        x = 20;
    }
    public void print() {
        System.out.println("Father.x = " + x);
    }
}

class Son extends Father {
    int x = 30;
//    float x = 30.1F;
    public Son() {
        this.print();
        x = 40;
    }
    public void print() {
        System.out.println("Son.x = " + x);
    }
}

public class SonTest {
    public static void main(String[] args) {
        Father f = new Son();
        System.out.println(f.x);
    }
}

```

## 原子类之高性能热点商品点赞计数案例

```java
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.atomic.AtomicLong;
import java.util.concurrent.atomic.LongAccumulator;
import java.util.concurrent.atomic.LongAdder;

public class AccumulatorCompareDemo {


    public static final int _1W = 100000;
    public static final int THREAD_NUMBER = 50;

    public static void main(String[] args) throws InterruptedException {

        ClickNumber clickNumber = new ClickNumber();
        long starTime;
        long endTime;

        CountDownLatch countDownLatch1 = new CountDownLatch(THREAD_NUMBER);
        CountDownLatch countDownLatch2 = new CountDownLatch(THREAD_NUMBER);
        CountDownLatch countDownLatch3 = new CountDownLatch(THREAD_NUMBER);
        CountDownLatch countDownLatch4 = new CountDownLatch(THREAD_NUMBER);

        starTime = System.currentTimeMillis();
        for (int i = 1; i <= THREAD_NUMBER; i++) {
            new Thread(() -> {
                try {
                    for (int j = 1; j <= 100 * _1W; j++) {
                        clickNumber.clickBySynchronized();
                    }
                } finally {
                    countDownLatch1.countDown();
                }
            }, String.valueOf(i)).start();
        }

        countDownLatch1.await();
        endTime = System.currentTimeMillis();
        System.out.println("----costTime: " + (endTime - starTime) + "毫秒\t clickBySynchronized  " + clickNumber.number);

        System.out.println("=================================================================================================");

        starTime = System.currentTimeMillis();
        for (int i = 1; i <= THREAD_NUMBER; i++) {
            new Thread(() -> {
                try {
                    for (int j = 1; j <= 100 * _1W; j++) {
                        clickNumber.clickByAtomicLong();
                    }
                } finally {
                    countDownLatch2.countDown();
                }
            }, String.valueOf(i)).start();
        }

        countDownLatch2.await();
        endTime = System.currentTimeMillis();
        System.out.println("----costTime: " + (endTime - starTime) + "毫秒\t clickByAtomicLong  " + clickNumber.atomicLong.get());

        System.out.println("=================================================================================================");

        starTime = System.currentTimeMillis();
        for (int i = 1; i <= THREAD_NUMBER; i++) {
            new Thread(() -> {
                try {
                    for (int j = 1; j <= 100 * _1W; j++) {
                        clickNumber.clickByLongAdder();
                    }
                } finally {
                    countDownLatch3.countDown();
                }
            }, String.valueOf(i)).start();
        }

        countDownLatch3.await();
        endTime = System.currentTimeMillis();
        System.out.println("----costTime: " + (endTime - starTime) + "毫秒\t clickByLongAdder  " + clickNumber.longAdder.sum());


        System.out.println("=================================================================================================");

        starTime = System.currentTimeMillis();
        for (int i = 1; i <= THREAD_NUMBER; i++) {
            new Thread(() -> {
                try {
                    for (int j = 1; j <= 100 * _1W; j++) {
                        clickNumber.clickByLongAccumulator();
                    }
                } finally {
                    countDownLatch4.countDown();
                }
            }, String.valueOf(i)).start();
        }

        countDownLatch4.await();
        endTime = System.currentTimeMillis();
        System.out.println("----costTime: " + (endTime - starTime) + "毫秒\t clickByLongAccumulator  " + clickNumber.longAccumulator.get());


        System.out.println("=================================================================================================");


    }
}

class ClickNumber {
    int number = 0;

    public synchronized void clickBySynchronized() {
        number++;
    }

    AtomicLong atomicLong = new AtomicLong(0);

    public void clickByAtomicLong() {
        atomicLong.getAndIncrement();
    }


    LongAdder longAdder = new LongAdder();

    public void clickByLongAdder() {
        longAdder.increment();
    }


    LongAccumulator longAccumulator = new LongAccumulator(((left, right) -> right + left), 0);

    public void clickByLongAccumulator() {
        longAccumulator.accumulate(1);
    }


}

```



