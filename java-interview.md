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





