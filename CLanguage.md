常量是计算机内存里面不变的数据
变量是计算机内存里面经常改变的数据


%d是十进制   %x是十六进制

#### C语言变量命名规则

 	1. 第一个必须是字母或下划线
 	2. 不能是C语言关键字
 	3. 有的编译器可以将汉字当做字母

变量如果补初始化，可以编译成功，但是执行的时候可能报错

操作系统是如何管理内存的
​	每当一个应用程序打开时，操做系统为其分配内存，
​	内存有内存地址与内存单元，当应用程序初始化运行时，就会往
​	内存单元里面写数据，当操作系统回收的时候，并不清空内存单元，所以
​	存在大量的垃圾数据。
​	如果变量不初始化，就会默认读取垃圾数据，有些垃圾数据会导致程序
​	崩溃。

#### gcc -E -o a.e a.c

预编译啊a.c文件生成目标文件名为a.e
预编译是include包含的头文件内容替换到.c文件中，同时将代码中没用的注释部分删除

-S就是将C语言转化为汇编语言

-c  就代码编译成二进制的机器指令

gcc没有任何参数代表链接


<头文件>代表让C语言编译器去系统目录下寻找相关的头文件
"头文件"代表让C语言编译器去用户当前目录下寻找相关头文件

RISC精简指令集
CISC复杂指令集，一般来说X86构架的CPU都是复杂指令的，AMD，intel就是X86构架的
linux就是基于X86的操作系统

八进制在C语言中为 0
十六进制在C语言中为0x

补码就是反码加一

%x用十六进制的方式输出整数
%u代表输出一个无符号的十进制数
%o代表输出一个八进制数

short在带32为系统下C语言中为短整数 共两个字节

long的意思是长整数，在32位系统下，long是4个字节，在64位系统下windows还是4个字节
在unix下位8个字节

计算一个整数的时候超过整数能够容纳的最大单位后


volatile 代表变量是一个可能杯CPU指令之外的地方改变的，编译器就不会针对这个变量去优化目标代码


register  变量在CPU寄存器里面，而不是在内存里面。单register是建议时指令，而不是命令型的


字符串是内存中一段连续的char空间，以'\0'结尾

 int i = (a = b, a +d)  逗号运算符 先算左边，再算右边，最后结果为右边的计算结果

空语句   只有一个逗号的语句就是空语句，空语句在C语言是合法的

在C语言中0代表false，非0代表true

等号优先级是从右到左

int main()一个函数在C语言中，如果只是（），代表这个函数可以有参数，也可以没有参数
int main(void) 如果是(void),就是明确表达没有任何参数

scanf将回车，空格都认为是字符串输入结束的标志

gets()函数认为回车输入结束的标志，空格不是结束的标志

gets()和scanf()都存在缓冲区溢出的问题

C语言中字符串不能通过==来比较

在C语言中，实参与形参的数据传递时“值传递”，即单向传递，只能由实参传递给形参
而不能由形参传递给实参

如果函数参数是个数组，那么是可以通过形参修改实参的值

再#ifndef中的宏中，一定要大写和下划线，必要的时候加数字，目的是为了避免和其他头文件的宏重复


指针也是一个变量

计算机的内存最小单位是Byte，每一个Byte都有一个唯一的编号，这个编号就是内存地址。
编号在32位系统下是一个32位的整数   在64位系统下是一个64位的整数

指向NULL的指针叫空指针，没有具体指向任何变量地址的指针叫野指针

const int * p定义一个指向常量的指针，表示这个指针只能指向一个常量
int *const p定义一个指针常量，一旦初始化之后内容不可改变

指针运算不是简单的整数加减法，而是指针指向的数据类型在内存中占用的字节数做为倍数的运算

指针常量的意思是一旦定义就固定指向一个地址，这个地址在程序运行期间不能改变

指针就是一个变量，既然是变量就页存在内存地址，所以定义一个指向指针的指针

数组就是一个指针变量

```c
#include<stdio.h>
int main(int argc,char *args[]){
    //argc代表程序执行的时候有几个参数，程序本身是一个参数，所以argc最小值为一
    //第二个参数就是一个指针数组，其中每个成员的类型是char *
    //args
}
```

```c
int *p;
p = 100;//给野指针赋值时错误的
```

```c
#include<stdio.h>
void test(int *);
int main(void){
    void (*p)(int *);//定义了一个指向函数的指针变量
    p = test;
    int a = 100;
    p(&a);
    return 0;
}

void test(int *p){
    
}
```

```c
extern int age;//有一个变量，类型时int，名字时age，已经在其他文件的定义了
```

```c
//auto自动变量，一般情况下代码块内部定义的变量都是自动变量。当然可以显示的使用auto关键字
auto int a;
```

```c
register int i = 0;//建议，如果寄存器空闲，那么这个变量就放在寄存器里面使用
int * p = &i;//对于一个register变量，是不能取地址操作
```

```c
static int a = 0;//静态变量，只初始化一次，而且程序运行期间，静态变量一直存在
```

#### 栈stack是一种先进后出的内存结构，所有的自动变量，函数形参都是由编译器自动放入栈中，当一个变量超出其作用域时，自动从栈中弹出

#### 对于自动变量，什么时候入栈，什么时候出栈，是不需要程序控制的，由C语言编辑器实现

#### 栈不会很大，一般以K位单位

#### 堆heap和栈一样，也是一种在程序在程序运行过程中可以随时修改的内存区域，但是没有栈那样先进后出的顺序。

#### 堆是一个大容器，他的容量要远远大于栈，但是在C语言中，堆内存空间的申请和释放需要手动通过代码来完成的

## 重要***

```c
#include<stdio.h>
void getHeap1(int *p){
    p = malloc(sizeof(int)*10);
}

void getHeap2(int **p){
    *p = malloc(sizeof(int)*10);
}
int main(void){  
	
    int * pHeap = NULL;
    //getHeap1(pHeap);//值传递
    getHeap2(&pHeap);//地址传递
    pHeap[0] = 1;
    pHeap[1] = 2;

    for (int j = 0; j < 2; ++j) {
        printf("pHeap[%d] = %d\n",j,pHeap[j]);
    }

    free(pHeap);

    return 0;
}
```

#### 内存四区

```c
#include<stdio.h>
int c = 0;//全局
static int d = 0;//在定义这个变量的文件内部是全局的，但在外部不可用
void test(){
    auto int b = 0;//所有的局部变量都是静态变量，所以关键字auto可以省略
    static int f = 0;//整个进程运行期间一直有效，是静态区，但只能test函数内部访问
}
int main(void){
    
    return 0;
}
```

### 结构体

```c
#include <stdio.h>
#include <string.h>
struct Student {
    char name[100];
    int age;
    int sex;
};//定义一个结构体

struct A {
    // struct Student;
    int name1[10];
    long long c;
    int a;
    char b;
};

struct B {
    char a :4;//使用一个bit

};

int main(void) {

    printf("%d", 3);
    struct Student student;//定义了一个结构体变量，名字叫student
    struct Student student1 = {"周水平", 12, 0};//定义一个结构体同时初始化
    struct Student student2 = {0};//定义一个结构体，同时将所有变量初始化位0
    struct Student student3 = {.age = 20, .name="傻逼", .sex = 1};
    student.age = 20;
    student.sex = 0;
    strcpy(student.name, "刘德华");
    printf("name = %s,age = %d,sex = %d", student.name, student.age, student.age);

    printf("\n=============================================\n");
    printf("结构体Student的字节数：%d\n", sizeof(struct Student));
    struct A a = {0};
    printf("结构体A的字节数：%d\n", sizeof(a));

    printf("%d", sizeof(size_t));
    return 0;
}

```

------------------------------



#### 在定义与结构体有关的函数时，尽量使用指针，因为指针作为参数，只需要传递一个地址，所以代码效率很高。

### 联合体

```c
union A{
    char *p;
    char a;
};
//联合体中有指针类型，那么一定要用完这个指针，并且free之后才能使用其他成员
```

### typedef

typedef是一种高级数据特性，它能使某一种类型创建自己的名字

### 文件操作

#### 写

```c
#include <stdio.h>
#include <string.h>
int main(void){
    FILE * filePointer = fopen("E:\\a.txt","w");//用写的方式打开一个文件
    //"w"意思就是如果文件不存在，如果文件存在就覆盖
//    fputs("hello world",filePointer);//向文件写入一个字符串
//    fputs("你好",filePointer);
    while(1){
        memset(string,0, sizeof(string));
        scanf("%s",string);

        if (strcmp(string,"exit") == 0){
            break;
        }
        int length = strlen(string);
        string[length] = '\n';
        fputs(string,filePointer);
    }
    fclose(filePointer);//关闭这个文件

    printf("end\n");
    return 0;
}

```

#### 读

````c
#include <stdio.h>
#include <string.h>
int main(void){
    char string[1024] = {0};
    FILE * filePointer = fopen("E:\\a.txt","r");//用读的方式打开一个文件
    //feof(filePointer);//如果文件已经到了结尾，函数返回真

    while(!feof(filePointer)) {
        memset(string, 0,sizeof(string));//初始化数组
        fgets(string, sizeof(string),filePointer);//第一个参数是内存地址，第二个参数是这块											//内存的大小，第三个参数fopen 返回的文件指针
        printf("%s",string);
    }

    fclose(filePointer);
    return 0;
}
````

#### 函数指针

如果在程序中定义了一个函数，在编译时，编译系统为函数代码分配一段存储空间，这段存储空间的起始地址，称为这个函数的指针

#### 文件

**定义** ：存储在外部介质上数据的集合，是操作系统数据的管理单位

**文本文件和二进制文件区别** ：

(**Windows**)

写入时文本会将换行符10\n的ASCII码解析为回车符13\r加 换行符10\n 

读取时，会将回车符\r13加换行符\n10解析为\n10

二进制则会原样写入读出

(**Linux**) 

文本文件和二进制文件读写无差别

#### 文件型结构体

**struct  _iobuf{**

char * _ptr;当前缓冲内容指针

int _cnt;缓冲区还有多少个字符

char *_base;//缓冲区的起始地址

int _flag ;//文件流的状态，是否错误或者结束

int _file;//文件描述符

int _charbuf;//双字节缓冲，缓冲两个字节

int _buffsize ;//缓冲区大小

char * _tmpfname;//临时文件名

**};**

**typedef  struct  _iobuf FILE**;

#### access函数

| 模式            |                                 |
| :-------------- | ------------------------------- |
| (windows)io.h   | Windows上的文件夹都是可读可写的 |
| 0               | 判断是否存在                    |
| 2               | 判断是否可写                    |
| 4               | 判断是否可读                    |
| 6               | 判断是否可读可写                |
| (linux)unistd.h |                                 |
| R_OK            | 读权限                          |
| W_OK            | 写权限                          |
| X_OK            | 读写权限                        |
| F_OK            | 文件是否存在                    |
|                 |                                 |

##### 缓冲区的三种类型

**缓冲区分为三种类型：全缓冲、行缓冲、和不带缓冲。**

1. 全缓冲

   我们缓存在缓冲区的东西在缓冲区满的时候，才写入磁盘或者我们调用fflush刷新缓冲区才能写入到磁盘。对于全缓冲，如果我们缓冲区没满，或者我们没有手动刷新缓存，那么缓存区的内容是不能写入到磁盘的。

2. 行缓冲

   我们标准输入、标准输出都是采用的行缓存，也就是遇到换行符的时候，才会将缓存区的东西写入到磁盘。

3. 无缓存

   有的时候，我们希望一些内容在第一时间写入磁盘或者显示出来，比如我们显示错误信息的时候，这时候典型的例子比如标准出错，它就是直接显示出错信息，而不会先放入缓存。**stderr**



   ### 如何分配内存跨函数使用

   动态申请内存是在堆中完成的，而函数返回不会释放堆内存，但不要忘记，函数返回时，栈内存中的内存会被自动清除，因此不要返回指向栈内存的指针

### 变量存储类别

C语言中，变量存储类别大致分为4种：auto(自动) 、register(寄存器) 、static(静态)、和extern(外部)，其中auto和register属于自动分配方式，而static和extern变量属于静态分配的方式。不同的分配方式，变量的生存期、作用域和可见域各不相同

按函数作用域分，变量可分为局部变量和全局变量，所谓局部变量，是指函数内部定义的变量，局部变量仅在定义它的函数内才能有效使用，其作用域仅限于函数内，即从变量定义的位置开始，到函数体的结束，通常编译器不为局部变量分配内存单元，而是在程序运行中，系统根据需要为器分配临时内存。当函数执行结束时，局部变量被撤销，占用的内存被回收。

在函数外定义的变量称为全局变量，也称为外部变量，全局变量不属于任何一个函数，全局变量一经定义，编译器会为其分配固定的内存单元，在程序运行期间，这块内存单元始终有效，直到程序执行完毕，有操作系统回收内存。

不同的函数，可以定义同名的局部变量，如果生命周期不重合，编译器为了优化，会使用同一内存单元，如果生命周期重合，就会使用不同的内存单元。

### 作用域与可见域

在程序代码中，变量的有效范围称为作用域，能对变量标识符进行合法访问的范围称为可见域，可以这样说作用域是变量理论有效的区域，而可见域是变量实际有效的区域，可见域是作用域的子集。

可以将C语言作用于分为3类

* 块作用域

  自动变量(auto ,register)和内部静态变量(static)具有块作用域，在一个块内声明的变量，其作用域从声明开始到该块结束为止。

* 文件作用域

  外部变量static具有文件作用域，从声明点到文件末尾，此处所指的是文件的编译基本单位-c文件

* 全局作用域

  全局变量(extern)具有全局作用域，只要在使用前对其声明，便可在程序(由若干个文件组成)的任意位置使用全局变量。

### 编译与预处理

使用 gcc 命令不跟任何的选项的话，会默认执行预处理、编译、汇编、链接这整个过程，如果程序没有错，就会得到一个可执行文件，默认为a.out

-E选项：提示编译器执行完预处理就停下来，后边的编译、汇编、链接就先不执行了。

-S选项：提示编译器执行完编译就停下来，不去执行汇编和链接了。

-c选项：提示编译器执行完汇编就停下来。



### 宏

#define 一行写不下用   \ 做链接

```c
#ifndef   //如果没有定义
#undef    //终结宏的作用范围

//ANSI标准说明了五个预定义的宏名用于代码调试
__DATE__  //进行预处理的日期 ("mm dd yyyy"形式的字符串)
__FILE__  // 代表当前源代码文件名的字符串文字
__LINE__   //代表当前源代码中的行号的整型常量
__TIME__   //原文件编译的时间，格式"hh:mm:ss"
__FUNCTON__ //当前所在的函数名
```



```c
//#define DEBUG
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>//静态断言的头文件
#ifndef DEBUG
#define myAssert(x) //为空  //没有代码测试
#else
#define myAssert(x)\
if (!(x))\
        {\
        printf("myAssert(%s)开始检测.....\n",#x);\   
		//#x传递的参数，自动加上双引号，让其变成字符串
        printf("当前函数名为%s，文件名为%s，代码行号为%d",__FUNCTION__,__FILE__,__LINE__);\
        }
#endif
void main(void){

    double  a ,b;
    scanf("%lf%lf",&a,&b);
    printf("a = %lf,b = %lf\n",a,b);

    myAssert(b!=0);
    printf("a/b = %f ",a/b);
    return;
}
```

```c
//预处理指令以#号开头，每句最后只写一行
#include <stdlib.h>
#include <stdio.h>
#define cn "你好世界"
#define en "hello world"

#define B 1   //定义一个宏有选择的编译语句   ，例如一套代码同时应对两个环境

void main(void){
#if B == 1
    printf(cn);
#else
    printf(en);
#endif
    return;
}

```

