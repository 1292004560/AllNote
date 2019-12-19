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
4. 











