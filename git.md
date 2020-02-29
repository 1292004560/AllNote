### git应用详情

##### git 基础命令

1. git  init 创建版本库。
2. git add  test.txt 将已修改的文件提交文件到暂存区
3. git status 查看工作区的状态
4. git rm --cached   test.txt 将暂存区的内容删除
5. git checkout -- test.txt 丢弃上次的修改**此命令谨慎使用** 
6. git mv test.txt test2.txt 重命名文件
7. git commit --amend -m '再次修正'  修正上次提交的信息
8. git add . 将所有文件提交到暂存区
9. git commit -am ""  添加当前目录下的所有文件并提交

##### user.name和user.mail

1. 对于user.name与user.email来说有三个地方可以设置
   1. /etc/gitconfig (几乎不会使用)，**git config --system**
   2. ~/.gitconfig (很常用) **git config --global**
   3. 针对特定项目的 ，.git/config文件夹中 **git  config --local**
2. **git config user.name**  查看用户名
3. **git config user.emal**  查看邮箱  

##### 终端光标操作

1. **ctrl + a** 跳到开头
2. **ctrl + e** 跳到结尾
3. **ctrl + f** 向下翻屏
4. **ctrl + b** 向上翻屏
5. **cd  -**  回到上次工作目录

##### 如何处理误提交

1. **git rm ** 从版本库中删除文件
2. **git commit** 提交这次修改

##### git rm 与 rm的区别

1. git rm
   1. 删除了一个文件
   2. 将删除的文件纳入暂存区(stage ,index)
   3. 若想恢复被删除的文件，需要进行两个动作
      1. **git reset HEAD test.txt** 将待删除的文件从暂存区恢复到工作区
      2. **git checkout -- test.txt** 将工作区中的修改丢弃掉
2. rm
   1. 将 test.txt 删除，这时，被删除的文件并没有纳入暂存区

##### 查看提交历史git log

* git  log
* -p 展示每次提交的内容差异
* -n仅显示最近n次提交
* -- stat 仅显示简要的增改行数统计
* --pretty=oneline 
* --pretty=format:"%h - %an,%ar: %s"
* git log --graph --abbrev-commit 将提交信息简写
* git log --graph --pretty=oneline --abbrev-commit

##### .gitignore

* 配置在这个文件的内容会被git忽略
* 支持正则表达式和通配符
* *.**a** 忽略所有 .**a** 结尾的文件
* **!lib.a**  但 **lib.a** 除外
* **/TODO** 仅仅忽略项目根目录的 **TODO** 文件 ，不包括 **subdir/TODO** 文件
* **build/** 忽略 **build/** 目录下的所有文件
* **doc/*.txt** 会忽略 **doc/notes.txt** 但不会忽略 **doc/server/arch.txt**

##### git 分支

* **git branch** 查看版本库的分支
* **git  branch  分支名** 创建分支
* **git checkout  要切换的分支名**  切换分支
* **git  branch -d 分支名** 删除已合并的分支
* **git branch -D 分支名** 删除分支无论是否合并过的分支
* **git  checkout -b  new_branch** 创建并切换到new_branch分支
* **git merge  new_branch** 合并分支
* **HEAD ** 指向的是当前分支
* **master** 指向提交 
* **fast-forward**
  1. 如果可能，合并分支时git会使用fast-forward模式
  2. 在这种模式下，删除分支时会丢掉分支信息
  3. 合并时加上 **--no-ff** 参数会禁用fast-forward，这样会多出一个commit id
  4. **git merge --no-ff  dev**
  5. 查看log  **git log --graph**

##### 版本回退

* 回退到上一个版本
  * **git reset -- hard HEAD^**
  * **git reset --hard HEAD~1**
  * **git reset --hard commit_id**
* 返回到某一版本
  * git reflog  **记录的是操作日志**

