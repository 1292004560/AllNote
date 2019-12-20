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











