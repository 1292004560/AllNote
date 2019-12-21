### vim基本操作笔记

####  vim快速移动

1. w/W移到下一个word/WORD开头

2. e/E移到下一个word/WORD尾

3. b/B回到上一个word/WORD开头，可以理解为backword

4. word指的是以非空白字符分割的单词，WORD以空白字符分割的单词

5. syntax on 语法高亮 syntax off 关闭语法高亮

6. 使用f{char} 可以移动到char字符上，t移动到char的前一个字符

   如果第一次没有没有搜到，可以分号(;)/逗号(,)继续搜索该行下一个/上一个

7. 大写F表示反过来搜前面的字符

8. 0移动到行首的第一个字符，^移动到第一个非空白字符

9. $移动到行尾，g _移动到行尾非空白字符

10. gg/GG移动到文件开头和结尾，可以使用ctrl+o快速返回

11. H/M/L跳转到屏幕开头(Head),中间(Middle)和结尾(Lower)

12. ctrl+u ctrl + f 上下翻页。(upword/forward),zz把屏幕置为中间

#### vim的快速增删改查

1. vim在normal模式下使用x快速删除一个字符
2. 使用d(delete)配合文本对象快速删除一个单词daw(d around   word)
3. d  和 x都可以搭配数字来执行多次
4. 常用三个命令修改，r(replace),c(change),s(substitude)
5. normal模式下使用r可以替换一个字符。s进行替换并进入插入模式
6. 使用c配合文本对象，可以快速进行修改
7. ct+" 删除双引号内的内容并进入插入模式
8. cw删除一个单词并进入插入模式
9. 使用/ 或者？进行前向或者反向搜索
10. 使用n/N跳转到下一个或者上一个进行匹配
11. 使用*或者#进行当前单词的前向和后向匹配
12. R 一直替换到结束
13. S整行删除并进入插入模式
14. caw删除当前单词并进入插入模式
15. C删除整行进入插入模式
16. :set hls搜索高亮  :set incsearch

#### vim如何进行搜索替换

##### substitute命令允许我们查找并且替换文本，并且支持正则表达式

1. ：**[range]s[ubstitute]/{pattern}/{string}/[flags]**

   **range表示范围比如：10，20表示10-20行，%表示全部**

   **pattern表示要替换的模式，string是替换的文本**

2. Flag有几个常用的标志

   **g(global)表示全局范围执行**

   **c(confirm)表示确认，可以确认或者拒绝修改**

   **n(number)报告匹配到的次数而不替换，可以用来匹配次数**

3. : % s /self/this/g 将文档中的self全部替换为this

#### vim多文件操作

##### buffer 、window、tab

1. buffer是指打开的一个文件内存缓冲区
2. window是buffer的可视化的分割区域
3. tab可以组织窗口为一个工作区

##### 如何在buffer中进行切换

1. 使用:ls会列举当前缓冲区，然后使用:b  n 跳转到第 n 各缓冲区
2. :bpre  :bnext  :bfirst  :blast
3. 或者用:b buffer_name 加上tab补全来跳转
4. :e  buffer_name 打开文件放在缓冲区中

##### 窗口是可视化的分割区域

1. 一个缓冲区可以分割成多个窗口，每个窗口也可以打开不同的缓冲区
2. ctrl + w  +s  水平分割，ctrl+w v垂直分割 。或者:sp 和 :vs
3. 每个窗口可以继续被无限分割(看你的屏幕是否足够大)
4. ：vs c.txt 垂直分割打开c.txt文件
5. :vs c.txt 水平分割打开c.txt文件

#####  切换窗口的命令都是使用ctrl+w作为前缀

1. ctrl + w  w 在窗口间循环切换
2. ctrl + w  h 切换到左边的窗口
3. ctrl + w  j  切换到下边的窗口
4. ctrl + w  k  切换到上边窗口
5. ctrl + w  l  切换到右边窗口

##### 重排窗口可以改变窗口的大小:h window-resize 查找

1. ctrl + w  = 使用所有窗口等宽等高
2. ctrl + w 最大化窗口的高度
3. ctrl + w | 最大化窗口的宽度
4. N ctrl + w 把活动窗口的高度设置为N 行
5. N ctrl + w | 把活动窗口的宽度设置为N 列

##### Tab (标签页)将窗口分组

1. Tab 是可以容纳一系列窗口的容器(:h tabpage)
2. vim 的Tab 和其他编辑器不太一样，可以想象成Linux 的虚拟桌面
3. 比如一个Tab全用来编辑Python文件，一个Tab全是HTML文件
4. 相比窗口，Tab一般用的比较少，Tab太多管理起来麻烦

###### Tab (标签页)操作

1. **table[dit] {filename}   在标签中打开{filename}**
2. **ctrl + w + T      把窗口移动到一个新标签页**
3. **tabc[lose] 关闭当前标签页及其中的所有窗口**
4. **:tabo[nly]   只保留活动标签页，关闭所有其他标签页**

###### Tab(标签页)切换操作

| Ex    命令        | 普通模式下命令 | 用途                    |
| ----------------- | -------------- | ----------------------- |
| :tab  n[ext]  {N} | {N} gt         | 切换到编号为{N}的标签页 |
| :tab  n[ext]      | gt             | 切换到下一个标签页      |
| :tab  p[revious]  | gT             | 切换到上一个标签页      |













