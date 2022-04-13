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

1. **tabe[dit] {filename}   在标签中打开{filename}**
2. **ctrl + w + T      把窗口移动到一个新标签页**
3. **tabc[lose] 关闭当前标签页及其中的所有窗口**
4. **:tabo[nly]   只保留活动标签页，关闭所有其他标签页**



###### Tab(标签页)切换操作

| Ex    命令        | 普通模式下命令 | 用途                    |
| ----------------- | -------------- | ----------------------- |
| :tab  n[ext]  {N} | {N} gt         | 切换到编号为{N}的标签页 |
| :tab  n[ext]      | gt             | 切换到下一个标签页      |
| :tab  p[revious]  | gT             | 切换到上一个标签页      |

#### TextObject(文本对象)

1. vim中也有对象的概念，比如说一个单词，一段句子，一个段落。
2. 很多其他的编辑器经常只能操作单个字符来修改文本，比较低效。
3. 通过文本对象来修改要比只修改单个字符高效。

###### 文本对象操作方式

1. **[number]<command>[text object]**
2. number表示次数，command时命令，d(delete),c(change)，y(yank).
3. text object是要操作的文本对象，比如单词w，句子s，段落p

iw表示inner word 。如果键入viw命令，那么首先v将进入选择模式，然后iw将选中当前单词

1. vi + " 快速选中双引号中的内容

2. ci + {  删除方括号的内容并进入插入模式

3. ci + ( 删除圆括号的内容并进入插入模式

#### vim Normal模式下复制粘贴

1. normal 模式下复制粘贴分别使用y(yank)和p(put),剪贴d和p。
2. 我们可以使用v(visual)命令中所要复制的地方，然后使用p粘贴。
3. 配合文本对象：比如使用yiw复制一个单词，yy复制一行。

#### vim insert模式复制粘贴

1. 可以使用ctrl+v粘贴
2. :set autoindent,自动缩进，粘贴Python代码缩进混乱。
3. 使用:set paste :set nopaste解决

#### vim寄存器

1. vim里操作的是寄存器而不是系统剪贴板。
2. 默认我们使用d删除或者y复制放到了“ 无名寄存器”。
3. 用x删除一个字符放到“无名寄存器”，然后p粘贴，可以调换俩字符。
4. 通过 "{register}前缀可以指定寄存器，不指定默认用无名寄存器。
5. 比如使用 “ayiw” 复制一个单词到寄存器a中，“bdd删除当前行到寄存器b中。

#### 其他寄存器

**除了有名寄存器a-z,vim中还有其他常见寄存器**

1. 复制专用寄存器 ” 0 使用y复制文本同时会被拷贝到复制寄存器0.

2. 系统剪贴板 “ + 可以在复制前加上  " + 复制到系统剪贴板。

3. 其他一些寄存器 ” % 当前文件名，“ . 上一次插入的文本。

#### 强大的vim宏(macro)

1. 宏可以看成是一系列命令的集合。
2. 我们可以使用宏**录制**一系列的操作，然后用于**回放**。
3. 宏可以非常方便地把一系列命令用在多行文本上。

#### 如何使用宏

1. vim使用**q**来录制，同时也是**q**结束录制。
2. 使用**q{register}**选择要保存的寄存器，把录制的命令保存在其中。
3. 使用**@{register}** 回放寄存器保存的一系列命令。

##### 比如给所有的行加上双引号

1. gg命令让光标到行首。
2. qa录制宏并且将宏保存到a寄存器中。
3. 然后esc切换到normal模式。
4. 然后**I**跳入行首，加上**“** 。
5. 然后**A**跳入行尾，加上**”**。
6. 然后**q**结束录制
7. 然后shift + v 选中一行。
8. GG跳到行尾。
9. :  normal  @a 。

##### 例如

**:normal   I"**给行尾加上双引号。

**:normal   A" **给行尾加上双引号。

#### vim 补全大法

##### vim 中常见的补全

|           命令            |     补全类型     |
| :-----------------------: | :--------------: |
|        (ctrl + n)         |    普通关键字    |
|  (ctrl + x)   ( ctrl+n)   | 当前缓冲区关键字 |
|  (ctrl+x)     (ctrl + i)  |  包含文件关键字  |
| (ctrl + x)   ( ctrl  + ]) |  标签文件关键字  |
|  (ctrl + x)   (ctrl + k)  |     字典查找     |
| (ctrl + x)   (ctrl  + l)  |     整行补全     |
|  (ctrl + x)   (ctrl + f)  |    文件名补全    |
| (ctrl + x)    (ctrl + o)  |  全能(Omni)补全  |

##### 常见的三种补全类型

1. 使用CTRL + n  和 CTRL + p 补全单词。
2. 使用CTRL  + x 和 CTRL + f 补全文件名。
3. 使用CTRL + x 和CTRL + o补全代码，需要开启文件类型检查，安装插件。

**开启文件类型检查 : filetype  on**

**设置文件类型  : set filetype**

**输出当前文件名     :r !   echo %**

**输出当前文件的绝对路径  : r ! echo %:p**

#### vim更换配色

1. 使用 **: colorscheme**显示当前的主题配色，默认是default。
2. 使用 **: colorscheme  <ctrl +d>**可以显示所有配色。
3. 有中意的配色后，用**:colorscheme   配色名** 就可以更换配色。

#### 编写vim配置文件

1. linux/Unix下新建一个隐藏文件 vim     ~/.vimmrc.
2. windows 系统vim  $MYVIMRC ,通过环境变量编辑配置文件。

##### vim配置都包含什么

1. 常用设置，比如:set nu 设置行号，colorscheme hybrid设置主题。
2. 常用的vim 映射，比如noremap**<leader>** w : w **<cr>**保存文件。
3. 自定义的vimscript函数(vim 高手)插件的配置。

###### vim中的映射

1. 设置leader键 let  mapleader  = “ ，”常用的是逗号或空格。
2. 比如inoremap <leader> w <ESC> :w <cr> 在插入模式保存。

#### 什么是Vim的映射

**vim映射就是把一个操作映射到另一个操作**

##### 基本映射

**基本映射指的是normal模式下的映射**

1. 使用map就可以实现映射。比如: map  - x 然后按 - 就会删除字符。
2. **: map <space> viw **告诉vim按下空格的时候选中整个 单词。
3. **:map <c  +d > dd  **可以使用ctrl + d 执行dd 删除一行。“注意”：c 尾 ctrl
4. : ummap   - 取消映射。

##### 模式映射

###### Vim中常用模式normal/visual/insert都可以定义映射

1. 用nmap/vmap/imap定义映射只在normal/visual/insert/分别有效。
2. **:vmap \  U 将  \  代替 U  把在visual模式下选中的文本大小写(u/U转换大小写)**   。
3. 如何在insert模式下映射CTRL + d 删除一行 **: imap  <c-d>  <ESC>ddi**
4. **: nmap - dd**          **: nmap \  -**  。
5. 当你按下  \ 时，vim会解释为 -  。我们又映射了 \  vim 继续解析为 dd ，即它会删除整行。

###### 递归与非递归映射

1. 如果你安装了一个插件，插件映射了同一个按键的不同行为，有冲突就会失效。
2. 解决方案就是使用非递归映射。

###### 非递归映射

1. 使用 map对应的 **nnoremap/vnoremap/ inoremap**。
2. 何时使用递归映射 **map** ? 何时使用非递归映射 **nnoremap**?
3. 任何时候都应该使用非递归映射，拯救自己和插件作者。

###### 学习vim书籍

[本方法学VimScript](<http://higrid.net/hi/books/learnvimthehardway>)

***

#### 安装插件

###### 常见插件vim-plug , Vundle,Pathogen,Dein.Vim,volt等。

###### 综合性能，易用性，文档，等几个方面，推荐使用vim-plug.

[vim-plug 插件的GitHub网址](https://github.com//junegunn/vim-plug)

#### 安装vim-startify 插件

1. [vim-startify,一个好用的开屏插件](https://github.com/mhinz/vim-startify)
2. 修改.vimrc 文件，增加该插件名称。
3. 重新启动vim或者source一下 **.vimrc** ,执行 **:PlugInstall**

#### 如何寻找插件

1. 通过google进行搜索。
2. **https://vimawesome.com**

#### vim美化插件

1. [修改启动界面](https://github.com/mhinz/vim-startify)
2. [状态栏美化](https:github.com/vim-airline/vim-airline)
3. [增加代码缩进条](https://github.com/yggdroot/indentline)

#### vim配色方案

1. [vim-hybird配色](https://github.com/w0ng/vim-hybrid).
2. [solarized配色](https://gitgub/altercation/vim-colors-solarized).
3. [gruvbox配色](https://github.com/morhetz/gruvbox).

#### 文件管理器nerdtree

1. [使用nerdtree插件进行文件目录树管理](https://github.com/scrooloose/nerdtree)。
2. autocmd vimenter  NERDTree 可以启动vim是打开。
3. nnoremap <leader> v : NEEDTreeFind<cr> 查找文件打开。

#### 模糊搜索器

1. [模糊搜索器](https://github.com/ctrlpvim/ctrlp.vim)。
2. 映射命令  let g:ctrlp_map = '<c-p>'
3. 使用ctrl+p然后搜索少量的字符就可以搜索啦。

#### vim快速定位文件，文件任我行

##### vim基础移动命令

1. 比如w/e基于单词移动，gg/G问价首尾，0/$行首 行尾 f{char}查询字符。
2. ctrl+f  ctrl + u 前后翻屏。

##### 文件任意位置移动插件easymotion

* [文件内容快速定位插件easymotion](https://github.com/easymotion/vim-easymotion)。
* nnmap ss <Plug>(easymotion-s2)。

***

 #### 成对编辑插件

1. [成对编辑插件vim-surround](https://github.com/tpope/vim-surround)。
2. normal模式下增加，修改，删除成对内容。
3. ds(delete a surrounding)。
4. cs(change a surrounding)。
5. ys(you add a surounding)。
6. 例如：ys  iw "  给   name 加双引号。
7. 例如 ：将双引号改成单引号 **cs  "  '  **

#### 强大的vim模糊搜索与替换插件

###### 搜索插件

1. [fzf是一个命令行搜索工具，fzf.vim集成到vim中](https://github.com/junegunn/fzf.vim) 。
2. 使用Ag [PATTERN]模糊搜索目录。
3. 使用Files[PATH]模糊搜索目录。

###### 替换插件

* [far-vim](https://github.com/brooth/far.vim)。
* 比如说在重构代码的时候经常用到。
* **：Far foo  bar **   ** / *.py.

#### 代码大纲tagbar

1. [tagbar](https://github.com/majutsushi/tagbar)。
2. 需要安装Universal CTags生成对应的tag文件。
3. 快速浏览代码结构，并且搜索跳转到对应的代码块。

#### 高亮代码插件

* [vim-interestingwords](https://github.com/lfv89/vim-interestingwords)。
* 浏览代码的时候经常需要知道一个变量的使用方式。
* 可以使用这个插件同时高亮多个单词。

#### 强大的代码补全插件

* [deoplete.nvim](https://github.com/shougo/deoplete.nvim)。
* 多编程语言支持，支持模糊匹配。
* 需要安装对应编程语言的扩展。
* [coc.vim](https://github.com/neoclide/coc.nvim)。
* 强大的neovim/vim8补全插件，LSP支持。
* full Lanuage  Server Protocol support  as  VScode。

#### vim代码格式化与静态检查

* 静态检查是为了让编写的代码更加规范。golint/pylint/eslint等。
* vim-autoformat和Neoformat 是两种使用较多的插件。
* [noeformat](https://github.com/sbdchd/neoformat)。
* 需要安装对应的语言格式化库。
* neomake和ale是两种常用的lint插件。
* [ale](https://github.com/w0rp/ale)。
* 同样需要安装对应的语言lint库。
* vim8/neovim支持异步检查，不会影响vim的编辑效率。

#### vim快速注释代码插件

* [vim-commentary](https://github.com/tpope/vim-commentary)。
* 记住常用命令gc注释和取消注释。
* 插件会根据不痛的文件类型使用注释。

#### vim和git，强强联手

* [fugitive](https://github.com/tpope/vim-fugitive)。
* 能在vim中使用git。
* Gedit，Gdiff，Gblame，Gcommit。
* [vim-gitgutter](https://github.com/airblade/vim-gitgutter)。
* 在vim里显示文件变动。
* 当我们修改文件之后可以显示当前的问价变动。
* 哪些行是新增的，哪些行是修改了，哪些行是删除了。
* 在命令行查看提交记录。
* [gv.vim](https://github.com/junegunn/gv.vim)。
* 使用 **:GV ** 命令调用。
* 可以浏览代码提交变更。

#### vim和Tmux，天作之和

* Tmux一个强大的终端分屏复用工具。
* 通过brew(mac) apt-get(ubuntu)安装。
* 可以复用终端，分屏，托管进程等。
* 在服务器上即使退出服务器，也不会被kill，托管进程也更方便。
* 可以方便地分割屏幕实现多个进程公用屏幕。

#### Neovim

* [neovim](https://neovim.io)。
* 开发更加活跃，更加丰富的特性和扩展，异步支持。
* neovim的设计可以嵌入到很多GUI里，加上好看的外壳。

#### 使用强大的开源vim配置

1. [开源配置一](https://github.com/SpaceVim/SpaceVim)。
2. [开源配置二](http://github.com/PegasusWang/vim-config)。

***

### Vim实用技巧笔记


