### git应用详情

##### git 基础命令

1. git  init 创建版本库。
2. git add  test.txt 将已修改的文件提交文件到暂存区
3. git status 查看工作区的状态
4. git rm --cached   test.txt 将暂存区的内容删除
5. git checkout -- test.txt 丢弃 **工作区** 上次的修改**此命令谨慎使用** 
6. git mv test.txt test2.txt 重命名文件
7. git commit --amend -m '再次修正'  修正上次提交的信息
8. git add . 将所有文件提交到暂存区
9. git commit -am ""  添加当前目录下的所有文件并提交
10. git blame test.txt  查看文件的所有修改信息

##### user.name和user.mail

1. 对于user.name与user.email来说有三个地方可以设置
   1. /etc/gitconfig (几乎不会使用)，**git config --system**
   2. ~/.gitconfig (很常用) **git config --global**
   3. 针对特定项目的 ，.git/config文件夹中 **git  config --local**
2. **git config user.name**  查看用户名
3. **git config user.emal**  查看邮箱  
4. **git config --global alias.别名 要替代的命令**  git 命令别名

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
* **git branch -m master  master2** 改变分支的名字
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

##### git checkout -- test.txt

* 作用是：丢弃掉相对于暂存区中最后一次添加的文件所做的变更

##### git reset HEAD  test.txt

* 作用是：将之前添加到暂存区的内容从暂存区移到工作区

##### 保存工作现场

* 保存现场
  * **git stash**
  * **git stash  list** 查看所有保存现场
* 恢复现场
  * **git stash apply** (stash 内容不删除，需要通过 **git stash drop stash@{0} 手动删除**)
  * **git stash pop** (恢复工作现场的同时也将stash内容删除)
  * **git stash apply stash@{0}** 恢复哪一个工作现场

##### Git标签

* 新建标签，标签有两种：轻量级标签( lighweight) 与带有附注标签(annotated)

* 创建一个轻量级标签

  * **git tag v1.0.1**

* 创建一个带有附注的标签

  * **git tag -a v1.0.0.2  -m 'release vesion'**

* 删除标签

  * **git  tag -d  tag_name**

* 查看标签
  * **git tag**
  * **git  tag -l 'v*'** 查找带*开头的标签

* **git  push  origin v1.0** 推送标签到远程  **可以推送多个**

* **git  push origin  --tags** 将本地未推送的标签全部推送到远程

* **git  push origin  : refs/tags/v1.0** 将远程 v1.0删除

* **git  push origin  --delete  tag v5.0**  将远程 v5.0删除

* 完整写法

  * **git  push origin refs/tags/v7.0:refs/tags/v7.0**

* 从远程只拉取标签

  * **git  fetch  origin tag v7.0**


##### git diff

* **git diff**
  * 比较的是暂存区与工作区文件之间的差别
* **git  diff HEAD **
  * 比较的是最新的提交与工作区之间的差别
  * **HEAD** 可以替换成特定的 **commit_id**
* **git diff --cached**
  * 比较的是最新的提交与暂存区之间的区别

##### 远程协作

1. **git  remote  show** 显示所有的远程仓库
2. **git remote  show origin** 显示origin仓库的详细信息
3. **git remote add orgin 地址** 
4. **git branch -a** 查看本地和远程分支
5. **git branch -av** 将最后一次提交的信息显示出来
6. **git  clone  地址  mygit ** 将远程仓库clone到本地的mygit仓库
7. **git  pull  ==  git fetch  +  git merge**

##### 关于Git分支的最佳实践

1. 通常来说，Git分支会有如下几种
   1. master分支
   2. test分支
   3. develop分支
   4. hotfix分支

##### 将本地分支推送到远程并在远程创建分支

1. **git  push  -u  origin  test**
2. **git  push  --set-upstream  origin  develop **
3. **git  push  --set-upstream  origin  develop   src:dest**

##### 创建本地分支并追踪远程分支

1. **git  checkout  -b  test  origin/test**
2. **git  checkout  --track  origin/test**

##### git  push 和git pull完整写法

* **git  push  origin  srcBranch:destBranch**
* **git  pull  origin  srcBranch : destBranch**

##### 删除远程分支

1. **git  push  origin   :  dest**
2. **git  push  --delete  develop**

##### HEAD标记

* HHEAD文件是一个指向你当前分支的引用标识符，该文件并不包含SHA-1只，而是一个指向另外一个应用的指针
* 当执行git  commit命令时，git 会创建一个commit对象，并且将这个对象的parent指针设置为HEAD所指向的引用的SHA-1值
* 我们对于HEAD的任何操作，都会被 **git  reflog** 完整记录下来
* 实际上，我们可以通过git底层命令 **symbolic-ref** 来实现对HEAD文件内容修改

##### refspec

1. 在缺省的情况下，refspec会被  **git remote add** 命令所自动生成，Git 会获取远端上 refs/heads下的所有引用，并将它们写到本地的refs/remote/origin目录下，所以，如果原端上有一个master分支，你就可以通过下面几种方式访问他们的历史记录：
   1. **git log  origin/master**
   2. **git  log  remotes/origin/master**
   3.  **git log refs/remotes/origin/mster**

##### Git    gc

1. **git  gc** 会把 refs目录下的文件打包成 **packed-refs** 文件
2. 一般不会使用

##### Git裸库与submodule

1. 创建裸库
   1. **git  init  --bare**
2. **git  submodule  add 远程地址  本地目录名**
   1. 作用：为项目添加依赖的项目
   2. 远程项目发生变化 直接进入子模块 执行  **git pull**
   3. **git  submodule  foreach  git  pull**  更新所有子模块
3. clone一个带有子模块的项目时有有三步
   1. **git  clone**
   2. **git  submodule  init**
   3. **git  submodule  update  --recursive**
4. clone一个带有子模块的第二种操作
   1. **git  clone  地址  --recursive**

##### git subtree

1. 先添加远程库 **git  remote  add  subtree-origin  地址**
2. 将远程代码放在subtree目录下 从 subtree-origin  的master分支
   1. **git  subtree  add  --prefix=subtree   subtree-origin  master **
3. 更新
   1. **git subtree pull --prefix=subtree  subtree-origin  master  --squash**
4. 







