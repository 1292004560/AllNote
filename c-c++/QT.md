## 按钮控件常用Api

```c++
setParent(this); // 设置父亲
setText("");  // 设置文字
move(100, 200); //设置宽高
setWindowTitle("");  // 设置标题
resize(100, 200); // 重新指定窗口大小
setFixSize(100, 200); // 设置固定大小
```

## 对象树

因为 `QObject` 类就有一个私有变量 `QList<QObject *>`，专门存储这个类的子孙后代们。比如创建一个 `QObject` 并指定父对象时，就会把自己加入到父对象的 `childre()` 列表中，也就是 `QList<QObject *>` 变量中。

**使用对象树的好处**

当父对象被析构时子对象也会被析构

如：有一个窗口 Window，里面有 Label标签、TextEdit文本输入框、Button按钮这三个元素，并且都设置 Window 为它们的父对象。这时候我做了一个关闭窗口的操作，作为程序员的你是不是自然想到将所有和窗口相关的对象析构啊？古老的办法就是一个个手动 delete 呗。是不是很麻烦？Qt 运用对象树模式，当父对象被析构时，子对象自动就 delete 掉了，不用再写一大堆的代码了

## 信号和槽

1. 信号可以连接信号
2. 一个信号可以连接多个槽函数
3. 多个信号可以连接同一个槽函数
4. 信号的参数可以多于槽的参数

```c++
this->teacher = new Teacher(this);
this->student = new Student(this);
void (Teacher::*teacherSignal)(QString) = &Teacher::hungry;
void (Student::*studentSlot)(QString) = &Student::treat;
connect(teacher, teacherSignal, student, studentSlot);
connect(teacher, &Teacher::hungry, student, &Student::treat);
/* 这种方式的优点是 参数直观 缺点是 不做类型检测 */
connect(teacher, SIGNAL(hungry(QString)), student, SLOT(treat(QString)));
```

## Qt对话框

**模态对话框** : 不可以对其他窗口进行操作

```c++
 connect(ui->actionNew, &QAction::triggered, [=](){
        QDialog dialog(this);
        dialog.resize(200, 100);
        dialog.exec(); // 阻塞
    });
```

**非模态对话框** : 可以对其他窗口进行操作

```c++
connect(ui->actionNew, &QAction::triggered, [=](){
        QDialog dialog(this);
        dialog.resize(200, 100);
        dialog.show();
    });

// 这样创建 对话框就会闪一下，对话框在lamda表达式中创建，函数执行完之后，dialg就会被释放掉
```

```c++
connect(ui->actionNew, &QAction::triggered, [=](){
        QDialog * dialog = new Dialog(this);
        dialog->resize(200, 100);
        dialog->show();
    });
// 这样创建不会闪，但是会造成内存泄露
```

```c++
connect(ui->actionNew, &QAction::triggered, [=](){
        QDialog * dialog = new Dialog(this);
        dialog->resize(200, 100);
        dialog->show();
  			dialog->setAttribute(Qt::WA_DeleteOnClose);
    });
```

