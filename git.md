### git应用详情

##### git 基础命令

1. git  init 创建版本库。
2. git add  test.txt 将已修改的文件提交文件到暂存区
3. git status 查看工作区的状态
4. git rm --cached   test.txt 将暂存区的内容删除
5. git checkout -- test.txt 丢弃上次的修改**此命令谨慎使用** 
6. git mv test.txt test2.txt 重命名文件
7.  git commit --amend -m '再次修正'  修正上次提交的信息
8. 

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
4. **git + b** 向上翻屏

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



