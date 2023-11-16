## Makefile示例1

```makefile
SRC=$(wildcard *.c)               # wildcard把当前目录下的所有后缀是c的文件全部展开
OBJ=$(patsubst %.c, %.o, $(SRC))  # patsubst把$(SRC)中的变量符合后缀是.c的全部替换成.o，
TARGET=demo                       

all:$(TARGET)                     

$(TARGET):$(OBJ)
	gcc $^ -o $@ -g                  #   $^ 代表依赖的文件

$(OBJ):$(SRC)
	gcc -c $^

run:
	./$(TARGET)

clean:
	rm -rf *.o $(TARGET)            

debug:
	gdb ./$(TARGET)
```



## 编译可执行文件Makefile

```makefile
VERSION  =
CC   =gcc
DEBUG   =-DUSE_DEBUG
CFLAGS  =-Wall
SOURCES   =$(wildcard ./source/*.c)
INCLUDES   =-I./include
LIB_NAMES  =-lfun_a -lfun_so
LIB_PATH  =-L./lib
OBJ   =$(patsubst %.c, %.o, $(SOURCES))
TARGET  =app

#links
$(TARGET):$(OBJ)
 @mkdir -p output
 $(CC) $(OBJ) $(LIB_PATH) $(LIB_NAMES) -o output/$(TARGET)$(VERSION)
 @rm -rf $(OBJ)
 
#compile
%.o: %.c
 $(CC) $(INCLUDES) $(DEBUG) -c $(CFLAGS) $< -o $@

.PHONY:clean
clean:
 @echo "Remove linked and compiled files......"
 rm -rf $(OBJ) $(TARGET) output 
```

* **程序版本**

  开发调试过程可能产生多个程序版本，可以在目标文件后（前）增加版本号标识。

  ```makefile
  VERSION = 1.00
  $(CC) $(OBJ) $(LIB_PATH) $(LIB_NAMES) -o output/$(TARGET)$(VERSION)
  ```

* **编译器选择**

  Linux下为gcc/g++；arm下为`arm-linux-gcc`；不同CPU厂商提供的定制交叉编译器名称可能不同，如Hisilicon`arm-hisiv300-linux-gcc`。

  ```makefile
  CC = gcc
  ```

* **宏定义**

  开发过程，特殊代码一般增加宏条件来选择是否编译，如调试打印输出代码。-D是标识，后面接着的是`宏`。

  ```makefile
  DEBUG =-DUSE_DEBUG
  ```

* **编译选项**

  可以指定编译条件，如显示警告（-Wall），优化等级（-O）。

  ```makefile
  CFLAGS =-Wall -O
  ```

* **源文件**

  指定源文件目的路径，利用`wildcard`获取路径下所有依赖源文件。

  ```makefile
  SOURCES =$(wildcard ./source/*.c)
  ```

* **头文件**

  包含依赖的头文件，包括源码文件和库文件的头文件。

  ```makefile
  INCLUDES =-I./include
  ```

* **库文件名称**

  指定库文件名称，库文件有固定格式，静态库为libxxx.a;动态库为libxxx.so，指定库文件名称只需写“xxx”部分，

  ```makefile
  LIB_NAMES =-lfun_a -lfun_so
  ```

* **库文件路径**

  指定依赖库文件的存放路径。注意如果引用的是动态库，动态库也许拷贝到“/lib”或者“/usr/lib”目录下，执行应用程序时，系统默认在该文件下索引动态库。

  ```makefile
  LIB_PATH =-L./lib
  ```

* **目标文件**

  调用`patsubst`将源文件（.c）编译为目标文件（.o）。

  ```makefile
  OBJ =$(patsubst %.c, %.o, $(SOURCES))
  ```

* **执行文件**

  执行文件名称

  ```makefile
  TARGET =app
  ```

* **编译**

  ```makefile
  %.o: %.c
   $(CC) $(INCLUDES) $(DEBUG) $(CFLAGS) $< -o $@
  ```

* **链接**

  可创建一个`output`文件夹存放目标执行文件。链接完输出目标执行文件，可以删除编译产生的临时文件（.o）。

  ```makefile
  $(TARGET):$(OBJ)
   @mkdir -p output
   $(CC) $(OBJ) $(LIB_PATH) $(LIB_NAMES) -o output/$(TARGET).$(VERSION)
   @rm -rf $(OBJ)
  ```

* **清除编译信息**

  执行`make clean`清除编译产生的临时文件。

  ```makefile
  .PHONY:clean
  clean:
   @echo "Remove linked and compiled files......"
   rm -rf $(OBJ) $(TARGET) output 
  ```

## 编译静态库Makefile

```makefile
VERSION     =1.0.0
CC          =gcc
DEBUG   =
CFLAGS  =-Wall
AR      =   ar
ARFLAGS     =rv
SOURCES   =$(wildcard *.c)
INCLUDES    =-I.
LIB_NAMES   =
LIB_PATH  =
OBJ         =$(patsubst %.c, %.o, $(SOURCES))
TARGET      =libfun_a

#link
$(TARGET):$(OBJ)
 @mkdir -p output
 $(AR) $(ARFLAGS) output/$(TARGET)$(VERSION).a $(OBJ)
 @rm -rf $(OBJ)

#compile
%.o: %.c
 $(CC) $(INCLUDES) $(DEBUG) -c $(CFLAGS) $< -o $@
  
.PHONY:clean
clean:
 @echo "Remove linked and compiled files......"
 rm -rf $(OBJ) $(TARGET) output 
```

基本格式与`编译可执行Makefile`一致，不同点包括以下。
使用到`ar`命令将目标文件（.o）链接成静态库文件（.a）。静态库文件固定命名格式为：libxxx.a。

## 编译动态库Makefile

```makefile
VERSION   =
CC        =gcc
DEBUG     =
CFLAGS    =-fPIC -shared 
LFLAGS   =-fPIC -shared 
SOURCES   =$(wildcard *.c)
INCLUDES  =-I.
LIB_NAMES =
LIB_PATH  =
OBJ       =$(patsubst %.c, %.o, $(SOURCES))
TARGET    =libfun_so

#link
$(TARGET):$(OBJ)
	@mkdir -p output
 $(CC) $(OBJ) $(LIB_PATH) $(LIB_NAMES) $(LFLAGS) -o output/$(TARGET)$(VERSION).so
	@rm -rf $(OBJ)
 
#compile
%.o: %.c
	$(CC) $(INCLUDES) $(DEBUG) -c $(CFLAGS) $< -o $@

.PHONY:clean
clean:
 @echo "Remove linked and compiled files......"
 rm -rf $(OBJ) $(TARGET) output 
```

**要点说明**

基本格式与“编译可执行Makefile”一致，不同点包括以下。

编译选项和链接选项增加“-fPIC -shared ”选项。动态库文件固定命名格式为libxxx.so。

