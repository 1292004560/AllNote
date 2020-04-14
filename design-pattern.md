## 设计模式

### 设计模式在软件中哪里使用

**面向对象 => 功能模块[设计模式 + 算法(数据结构)]  => 框架[使用多种设计模式] => 架构[服务器集群]**

### 设计模式七大原则

1. 单一职责原则
2. 接口隔离原则
3. 依赖倒置原则
4. 里氏替换原则
5. 开闭原则
6. 滴米特原则
7. 合成复用原则

#### 单一职责原则(Single responsibility principle)

* **基本介绍**
  * 对类来说的，即一个类应该只负责一项职责。如类A负责两个不同职责：职责1，职责2。 当职责1需求变更而改变A时，可能造成职责2执行错误，所以需要将类A的粒度分解为 A1，A2
* **单一职责原则注意事项和细节**
  * 降低类的复杂度，一个类只负责一项职责。
  * 提高类的可读性，可维护性
  * 降低变更引起的风险
  * 通常情况下，**我们应当遵守单一职责原则**，只有逻辑足够简单，才可以在代码级违
    反单一职责原则；只有类中方法数量足够少，可以在方法级别保持单一职责原则

#### 接口隔离原则(Interface Segregation Principle)

* **基本介绍**
  * 客户端不应该依赖它不需要的接口，即一个类对另一个类的依赖 应该建立在最小的接口上

#### 依赖倒转原则(Dependence Inversion Principle)

1. 高层模块不应该依赖低层模块，二者都应该依赖其抽象 
2. 抽象不应该依赖细节，细节应该依赖抽象
3. 依赖倒转(倒置)的中心思想是面向接口编程
4. 依赖倒转原则是基于这样的设计理念：相对于细节的多变性，抽象的东西要稳定的 多。以抽象为基础搭建的架构比以细节为基础的架构要稳定的多。在java中，抽象 指的是接口或抽象类，细节就是具体的实现类
5. 使用接口或抽象类的目的是制定好规范，而不涉及任何具体的操作，把展现细节的 任务交给他们的实现类去完成

##### 依赖关系传递的三种方式和应用案例

1. 接口传递
2. 构造方法传递 
3. setter方式传递

##### 依赖倒转原则的注意事项和细节

1. 低层模块尽量都要有抽象类或接口，或者两者都有，程序稳定性更好.
2. 变量的声明类型尽量是抽象类或接口, 这样我们的变量引用和实际对象间，就存在
   一个缓冲层，利于程序扩展和优化
3. 继承时遵循里氏替换原则

#### 里氏替换原则

##### OO中的继承性的思考和说明

1. 继承包含这样一层含义：父类中凡是已经实现好的方法，实际上是在设定规范和契
   约，虽然它不强制要求所有的子类必须遵循这些契约，但是如果子类对这些已经实 现的方法任意修改，就会对整个继承体系造成破坏。
2. 继承在给程序设计带来便利的同时，也带来了弊端。比如使用继承会给程序带来侵 入性，程序的可移植性降低，增加对象间的耦合性，如果一个类被其他的类所继承，
   则当这个类需要修改时，必须考虑到所有的子类，并且父类修改后，所有涉及到子 类的功能都有可能产生故障。
3. 问题提出：在编程中，如何正确的使用继承? => 里氏替换原则。

##### 基本介绍

1. 里氏替换原则(Liskov Substitution Principle)在1988年，由麻省理工学院的以为姓里
   的女士提出的。
2. 如果对每个类型为T1的对象o1，都有类型为T2的对象o2，使得以T1定义的所有程序
   P在所有的对象o1都代换成o2时，程序P的行为没有发生变化，那么类型T2是类型T1 的子类型。换句话说，所有引用基类的地方必须能透明地使用其子类的对象。
3. 在使用继承时，遵循里氏替换原则，在子类中尽量不要重写父类的方法。
4. 里氏替换原则告诉我们，继承实际上让两个类耦合性增强了，**在适当的情况下，可
   以通过聚合，组合，依赖来解决问题**。

#### 开闭原则

1. 开闭原则（Open Closed Principle）是编程中最基础、最重要的设计原则。
2. 一个软件实体如类，模块和函数应该对扩展开放(对提供方)，对修改关闭(对使用
   方)。用抽象构建框架，用实现扩展细节。
3.  当软件需要变化时，尽量通过扩展软件实体的行为来实现变化，而不是通过修改已
      有的代码来实现变化。
4. 编程中遵循其它原则，以及使用设计模式的目的就是遵循开闭原则。

#### 迪米特法则

##### 基本介绍

1. 一个对象应该对其他对象保持最少的了解
2. 类与类关系越密切，耦合度越大
3. 迪米特法则(Demeter Principle)又叫最少知道原则，即一个类对自己依赖的类知道的越少越好。也就是说，对于被依赖的类不管多么复杂，都尽量将逻辑封装在类的内 部。对外除了提供的public 方法，不对外泄露任何信息
4. 迪米特法则还有个更简单的定义：**只与直接的朋友通信**
5. **直接的朋友**：每个对象都会与其他对象有耦合关系，只要两个对象之间有耦合关系， 我们就说这两个对象之间是朋友关系。耦合的方式很多，依赖，关联，组合，聚合等。其中，我们称出现成员变量，方法参数，方法返回值中的类为直接的朋友，而 出现在局部变量中的类不是直接的朋友。也就是说，陌生的类最好不要以局部变量 的形式出现在类的内部。

##### 迪米特法则注意事项和细节

1. 迪米特法则的核心是降低类之间的耦合
2. 但是注意：由于每个类都减少了不必要的依赖，因此迪米特法则只是要求降低
   类间(对象间)耦合关系，并不是要求完全没有依赖关系

#### 合成复用原则（Composite Reuse Principle）

##### 基本介绍

原则是尽量使用合成/聚合的方式，而不是使用继承

#### 设计原则核心思想

* 找出应用中可能需要变化之处，把它们独立出来，不要和那些不需要变化的代 码混在一起。
* 针对接口编程，而不是针对实现编程。 
* 为了交互对象之间的松耦合设计而努力。

### Java设计模式 --UML类图

#### UML基本介绍

* UML——Unified modeling language UML (统一建模语言)，是一种用于软件系统
  分析和设计的语言工具，它用于帮助软 件开发人员进行思考和记录思路的结果
* UML本身是一套符号的规定，就像数学 符号和化学符号一样，这些符号用于描 述软件模型中的各个元素和他们之间的 关系，比如类、接口、实现、泛化、依 赖、组合、聚合等
* 使用UML来建模，常用的工具有Rational Rose , 也可以使用一些插件来建模

#### 类图—依赖关系（Dependence）

* 只要是在类中用到了对方，那么他们之间就存在依赖关系。如果没有对方，连编 绎都通过不了。
* 小结
  * 类中用到了对方
  * 如果是类的成员属性
  * 如果是方法的返回类型
  * 是方法接收的参数类型
  * 方法中使用到

#### 类图—泛化关系(generalization）

* 泛化关系实际上就是继承关系，他是依赖关系的特例

#### 类图—实现关系（Implementation）

* 依赖关系的特例

#### 类图—关联关系（Association）

* 关联关系实际上就是类与类之间的联系，他是依赖关系的特例 
  关联具有导航性：即双向关系或单向关系 
  关系具有多重性：如“1”（表示有且仅有一个），“0...”（表示0个或者多个）， “0，1”（表示0个或者一个），“n...m”(表示n到 m个都可以),“m...*”（表示至少m 个）。

#### 类图—聚合关系（Aggregation）

* 聚合关系（Aggregation）表示的是整体和部分的关系，整体与部分可以分开。聚 合关系是关联关系的特例，所以他具有关联的导航性与多重性。

* ```java
  public class Computer {
  	private Mouse mouse; //鼠标可以和computer分离
  	private Moniter moniter;//显示器可以和Computer分离
  	public void setMouse(Mouse mouse) {
  		this.mouse = mouse;
  	}
  	public void setMoniter(Moniter moniter) {
  		this.moniter = moniter;
  	}
  	
  }
  public class Moniter {
  
  }
  
  public class Mouse {
  
  }
  ```

#### 类图—组合关系（Composition）

* 组合关系：也是整体与部分的关系，但是整体与部分不可以分开。

* ```java
  public class Computer {
  	private Mouse mouse = new Mouse(); //鼠标可以和computer不能分离
  	private Moniter moniter = new Moniter();//显示器可以和Computer不能分离
  	public void setMouse(Mouse mouse) {
  		this.mouse = mouse;
  	}
  	public void setMoniter(Moniter moniter) {
  		this.moniter = moniter;
  	}
  	
  }
  public class Moniter {
  
  }
  
  public class Mouse {
  
  }
  ```

### 设计模式类型

* 创建型模式
  * **单例模式**
  * **抽象工厂模式**
  * **原型模式**
  * **建造者模式**
  * **工厂模式**
* 结构型模式
  * **适配器模式**
  * **桥接模式**
  * **装饰模式**
  * **组合模式**
  * **外观模式**
  * **享元模式**
  * **代理模式**
* 行为型模式
  * **模版方法模式**
  * **命令模式**
  * **访问者模式**
  * **迭代器模式**
  * **观察者模式**
  * **中介者模式**
  * **备忘录模式**
  * **解释器模式（Interpreter模式）**
  * **状态模式**
  * **策略模式**
  * **职责链模式(责任链模式)**

#### 单例模式

##### 单例设计模式介绍

所谓类的单例设计模式，就是采取一定的方法保证在整个的软件系统中，对某个类 只能存在一个对象实例，并且该类只提供一个取得其对象实例的方法(静态方法)。

比如Hibernate的SessionFactory，它充当数据存储源的代理，并负责创建Session 对象。SessionFactory并不是轻量级的，一般情况下，一个项目通常只需要一个 SessionFactory就够，这是就会使用到单例模式。

##### 单例设计模式八种方式

1. **饿汉式(静态常量)**
2. **饿汉式（静态代码块**
3. **懒汉式(线程不安全)**
4. **懒汉式(线程安全，同步方法)**
5. **懒汉式(线程安全，同步代码块)**
6. **双重检查**
7. **静态内部类**
8. **枚举**

###### 饿汉式（静态常量）

1. ```java
   public class Singleton {
   
   
       private final static Singleton singletonInstance = new Singleton();
   
       private Singleton(){
           //防止外部new
       }
   
       public static Singleton getSingletonInstance(){
           return  singletonInstance;
       }
   }
   ```

2. 优缺点说明

   1. 优点：这种写法比较简单，就是在类装载的时候就完成实例化。避免了线程同
      步问题。
   2. 缺点：在类装载的时候就完成实例化，没有达到Lazy Loading的效果。如果从始
      至终从未使用过这个实例，则会造成内存的浪费。
   3. 这种方式基于classloder机制避免了多线程的同步问题，不过，instance在类装载 时就实例化，在单例模式中大多数都是调用getInstance方法，但是导致类装载
      的原因有很多种，因此不能确定有其他的方式（或者其他的静态方法）导致类 装载，这时候初始化instance就没有达到lazy loading的效果。
   4. 结论：这种单例模式可用，可能造成内存浪费。

######  饿汉式（静态代码块）

1. ```java
   public class Singleton {
   
       private static Singleton singletonInstance;
   
       private Singleton(){}
   
       static {
           singletonInstance = new Singleton();
       }
   
       public static Singleton getSingletonInstance(){
           return singletonInstance;
       }
   }
   
   ```

2. 优缺点同上

###### 懒汉式(线程不安全)

1. ```java
   public class Singleton {private static Singleton instance;
   
       private Singleton() {}
   
       //提供一个静态的公有方法，当使用到该方法时，才去创建 instance
       //即懒汉式
       public static Singleton getInstance() {
           if(instance == null) {
               instance = new Singleton();
           }
           return instance;
       }
   }
   ```

2. 优缺点说明

   1. 起到了Lazy Loading的效果，但是只能在单线程下使用。
   2. 如果在多线程下，一个线程进入了if (singleton == null)判断语句块，还未来得及
      往下执行，另一个线程也通过了这个判断语句，这时便会产生多个实例。所以 在多线程环境下不可使用这种方式。
   3. 结论：在实际开发中，不要使用这种方式。

###### 懒汉式(线程安全，同步方法)

1. ```java
   public class Singleton {
   
       private static Singleton instance;
       private Singleton() {}
   
       //提供一个静态的公有方法，当使用到该方法时，才去创建 instance
       //即懒汉式
       public static synchronized Singleton getInstance() {
           if(instance == null) {
               instance = new Singleton();
           }
           return instance;
       }
   }
   ```

2. 优缺点说明

   1. 解决了线程不安全问题
   2. 效率太低了，每个线程在想获得类的实例时候，执行getInstance()方法都要进行
      同步。而其实这个方法只执行一次实例化代码就够了，后面的想获得该类实例， 直接return就行了。方法进行同步效率太低
   3. 结论：在实际开发中，不推荐使用这种方式

###### 懒汉式(线程安全，同步代码块)

1. ```java
   public class Singleton {
   
       private static Singleton instance;
   
       private Singleton() {
       }
   
       //提供一个静态的公有方法，当使用到该方法时，才去创建 instance
       //即懒汉式
       public static Singleton getInstance() {
           if (instance == null) {
   
               synchronized (Singleton.class) {
                   instance = new Singleton();
               }
           }
           return instance;
       }
   }
   ```

2. 优缺点说明
   1. 这种方式，本意是想对第四种实现方式的改进，因为前面同步方法效率太低， 改为同步产生实例化的的代码块
   2. 但是这种同步并不能起到线程同步的作用。跟第3种实现方式遇到的情形一 致，假如一个线程进入了if (singleton == null)判断语句块，还未来得及往下执行，
      另一个线程也通过了这个判断语句，这时便会产生多个实例
   3. 结论：在实际开发中，不能使用这种方式

###### 双重检查

1. ```java
   public class Singleton {
       private static volatile Singleton instance;
   
       private Singleton() {}
   
       //提供一个静态的公有方法，加入双重检查代码，解决线程安全问题, 同时解决懒加载问题
       //同时保证了效率, 推荐使用
       public static synchronized Singleton getInstance() {
           if(instance == null) {
               synchronized (Singleton.class) {
                   if(instance == null) {
                       instance = new Singleton();
                   }
               }
   
           }
           return instance;
       }
   }
   ```

2. 优缺点说明

   1. Double-Check概念是多线程开发中常使用到的，如代码中所示，我们进行了两 次if (singleton == null)检查，这样就可以保证线程安全了。
   2. 这样，实例化代码只用执行一次，后面再次访问时，判断if (singleton == null)， 直接return实例化对象，也避免的反复进行方法同步。
   3. 线程安全；延迟加载；效率较高。
   4. 结论：在实际开发中，推荐使用这种单例设计模式。

###### 静态内部类

1. ```java
   public class Singleton {
   
       private Singleton(){}
   
       private static class SingletonInstance{
           private static final Singleton INSTANCE = new Singleton();
       }
   
       public static Singleton getInstance(){
           return SingletonInstance.INSTANCE;
       }
   }
   ```

2. 优缺点说明

   1. 这种方式采用了类装载的机制来保证初始化实例时只有一个线程。
   2. 静态内部类方式在Singleton类被装载时并不会立即实例化，而是在需要实例化
      时，调用getInstance方法，才会装载SingletonInstance类，从而完成Singleton的 实例化。
   3. 类的静态属性只会在第一次加载类的时候初始化，所以在这里，JVM帮助我们 保证了线程的安全性，在类进行初始化时，别的线程是无法进入的。
   4. 优点：避免了线程不安全，利用静态内部类特点实现延迟加载，效率高 。
   5. 结论：推荐使用。

###### 枚举

1. 优缺点说明
   1. 这借助JDK1.5中添加的枚举来实现单例模式。不仅能避免多线程同步问题，而 且还能防止反序列化重新创建新的对象。
   2. 这种方式是Effective Java作者Josh Bloch 提倡的方式。

##### 单例模式注意事项和细节说明

1. 单例模式保证了 系统内存中该类只存在一个对象，节省了系统资源，对于一些需 要频繁创建销毁的对象，使用单例模式可以提高系统性能。
2. 当想实例化一个单例类的时候，必须要记住使用相应的获取对象的方法，而不是使 用new。
3. 单例模式使用的场景：需要频繁的进行创建和销毁的对象、创建对象时耗时过多或 耗费资源过多(即：重量级对象)，但又经常用到的对象、工具类对象、频繁访问数
   据库或文件的对象(比如数据源、session工厂等)。

##### JDK源码 (RunTime)

#### 简单工厂模式

1. 基本介绍

   1. 简单工厂模式是属于创建型模式，是工厂模式的一种。简单工厂模式是由一 个工厂对象决定创建出哪一种产品类的实例。简单工厂模式是工厂模式家族 中最简单实用的模式。
   2. 简单工厂模式：定义了一个创建对象的类，由这个类来封装实例化对象的行 为(代码)。
   3. 在软件开发中，当我们会用到大量的创建某种、某类或者某批对象时，就会 使用到工厂模式。
   4. 违反了开闭原则。

2. 代码

   ```java
   public abstract  class Video {
   
       public abstract  void produce();
   }
   
   public class JavaVideo extends  Video {
       @Override
       public void produce() {
   
           System.out.println("录制java视频");
       }
   }
   public class PythonVideo extends Video {
       @Override
       public void produce() {
           System.out.println("录制python视频");
       }
   }
   public class VideoFactory {
   
   //    public Video getVideo(String type){
   //        if("java".equalsIgnoreCase(type)){
   //            return new JavaVideo();
   //        }else if("python".equalsIgnoreCase(type)){
   //            return new PythonVideo();
   //        }
   //        return null;
   //    }
   
       public Video getVideo(Class c){
           Video video = null;
           try {
                video = (Video) Class.forName(c.getName()).newInstance();
   
           } catch (InstantiationException e) {
               e.printStackTrace();
           } catch (IllegalAccessException e) {
               e.printStackTrace();
           } catch (ClassNotFoundException e) {
               e.printStackTrace();
           }
           return video;
       }
   }
   ```

#### 工厂方法模式

* 基本介绍

  * 对简单工厂模式进行扩展，更符合开闭原则。

* 代码

  ```java
  public abstract  class Video {
  
      public abstract  void produce();
  }
  
  public class JavaVideo extends Video {
      @Override
      public void produce() {
  
          System.out.println("录制java视频");
      }
  }
  
  public  abstract  class VideoFactory {
  
      public abstract Video getVideo();
  }
  
  public class JavaVideoFactory extends VideoFactory {
      @Override
      public Video getVideo() {
  
          return new JavaVideo();
      }
  }
  
  ```



#### 抽象工厂模式

1. 基本介绍
   1. 抽象工厂模式：定义了一个interface用于创建相关或有依赖关系的对象簇，而无需 指明具体的类。
   2. 抽象工厂模式可以将简单工厂模式和工厂方法模式进行整合。
   3. 从设计层面看，抽象工厂模式就是对简单工厂模式的改进(或者称为进一步的抽象)。
   4. 将工厂抽象成两层，AbsFactory(抽象工厂) 和 具体实现的工厂子类。程序员可以
      根据创建对象类型使用对应的工厂子类。这样将单个的简单工厂类变成了**工厂簇**， 更利于代码的维护和扩展。

#### 工厂模式在JDK-Calendar 应用的源码分析

#### 工厂模式小结

1. 工厂模式的意义 
   将实例化对象的代码提取出来，放到一个类中统一管理和维护，达到和主项目的
   依赖关系的解耦。从而提高项目的扩展和维护性。
2. 三种工厂模式 (简单工厂模式、工厂方法模式、抽象工厂模式)
3. 设计模式的依赖抽象原则
4. 创建对象实例时，不要直接 new 类, 而是把这个new 类的动作放在一个工厂的方法 中，并返回。有的书上说，变量不要直接持有具体类的引用。
    不要让类继承具体类，而是继承抽象类或者是实现interface(接口) 
    不要覆盖基类中已经实现的方法。

 #### 原型模式-基本介绍

1. 原型模式(Prototype模式)是指：用原型实例指定创建对象的种类，并且通过拷 贝这些原型，创建新的对象
2. 原型模式是一种创建型设计模式，允许一个对象再创建另外一个可定制的对象， 无需知道如何创建的细节
3. 工作原理是:通过将一个原型对象传给那个要发动创建的对象，这个要发动创建 的对象通过请求原型对象拷贝它们自己来实施创建，即 对象.clone()

##### 深入讨论-浅拷贝和深拷贝

###### 浅拷贝的介绍

1. 对于数据类型是基本数据类型的成员变量，浅拷贝会直接进行值传递，也就是将 该属性值复制一份给新的对象。
2. 对于数据类型是引用数据类型的成员变量，比如说成员变量是某个数组、某个类 的对象等，那么浅拷贝会进行引用传递，也就是只是将该成员变量的引用值（内 存地址）复制一份给新的对象。因为实际上两个对象的该成员变量都指向同一个 实例。在这种情况下，在一个对象中修改该成员变量会影响到另一个对象的该成 员变量值

###### 深拷贝基本介绍

1. 复制对象的所有基本数据类型的成员变量值
2. 为所有引用数据类型的成员变量申请存储空间，并复制每个引用数据类型成员变
   量所引用的对象，直到该对象可达的所有对象。也就是说，对象进行深拷贝要对 整个对象进行拷贝
3. 深拷贝实现方式1：重写clone方法来实现深拷贝
4. 深拷贝实现方式2：通过对象序列化实现深拷贝(推荐)

##### 原型模式的注意事项和细节

1. 创建新的对象比较复杂时，可以利用原型模式简化对象的创建过程，同时也能够提 高效率
2. 不用重新初始化对象，而是动态地获得对象运行时的状态
3. 如果原始对象发生变化(增加或者减少属性)，其它克隆对象的也会发生相应的变化，
   无需修改代码
4. 在实现深克隆的时候可能需要比较复杂的代码
5. **缺点**：需要为每一个类配备一个克隆方法，这对全新的类来说不是很难，但对已有 的类进行改造时，需要修改其源代码，违背了ocp原则

#### 建造者模式

##### 基本介绍

1. 建造者模式（Builder Pattern）又叫生成器模式，是一种对象构建模式。它可以 将复杂对象的建造过程抽象出来（抽象类别），使这个抽象过程的不同实现方
   法可以构造出不同表现（属性）的对象。
2. 建造者模式是一步一步创建一个复杂的对象，它允许用户只通过指定复杂对象
   的类型和内容就可以构建它们，用户不需要知道内部的具体构建细节。

##### 建造者模式的四个角色

1. Product（产品角色）：一个具体的产品对象。
2. Builder（抽象建造者）：创建一个Product对象的各个部件指定的接口/抽象类。
3. ConcreteBuilder（具体建造者）：实现接口，构建和装配各个部件。
4. Director（指挥者）：构建一个使用Builder接口的对象。它主要是用于创建一个
   复杂的对象。它主要有两个作用，一是：隔离了客户与对象的生产过程，二是： 负责控制产品对象的生产过程。

##### 建造者源码java.lang.StringBuilder

##### 建造者模式的注意事项和细节

1. 客户端(使用程序)不必知道产品内部组成的细节，将产品本身与产品的创建过程解 耦，使得相同的创建过程可以创建不同的产品对象
2. 每一个具体建造者都相对独立，而与其他的具体建造者无关，因此可以很方便地替 换具体建造者或增加新的具体建造者，用户使用不同的具体建造者即可得到不同
   的产品对象
3. 可以更加精细地控制产品的创建过程。将复杂产品的创建步骤分解在不同的方法
   中，使得创建过程更加清晰，也更方便使用程序来控制创建过程
4. 增加新的具体建造者无须修改原有类库的代码，指挥者类针对抽象建造者类编程，
   系统扩展方便，符合“开闭原则”
5. 建造者模式所创建的产品一般具有较多的共同点，其组成部分相似，**如果产品之间 的差异性很大，则不适合使用建造者模式，**因此其使用范围受到一定的限制。
6. 如果产品的内部变化复杂，可能会导致需要定义很多具体建造者类来实现这种变化， 导致系统变得很庞大，因此在这种情况下，要考虑是否选择建造者模式。
7. 抽象工厂模式VS建造者模式 
   **抽象工厂模式实现对产品家族的创建，一个产品家族是这样的一系列产品：具有不
   同分类维度的产品组合，采用抽象工厂模式不需要关心构建过程，只关心什么产品 由什么工厂生产即可。而建造者模式则是要求按照指定的蓝图建造产品，它的主要 目的是通过组装零配件而产生一个新产品**

