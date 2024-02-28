> git_push命令的使用需要自行配置好本地的git全局变量
## connect.sh
- 第一个文件可以直接方便的配置虚拟机以使得可以在远程链接到虚拟机(Linux)
- 直接在connect.sh所在目录下运行
  ```shell
  git clone https://github.com/W1412X/shell.git
  cd shell
  chmod +x connect.sh
  ./connect.sh
  ```
## git_push.sh
- 可以方便的在本地创建仓库，更新仓库并同步到Github
    - 对应创建的仓库名称即为该目录名称
    - 使用
      ```shell
      git clone https://github.com/W1412X/shell_git.git  
      cd shell
      ./install.sh  
      ```
      > 提示输入的Username你需要输入你的Github用户名  
      提示输入token你需要输入你获取的token
    - 之后可以直接在你需要同步的目录下运行 git_push进行同步
      ```shell
      git_push
      #comment为本次push的注释
      git_push -c comment
      ```
- 注意
  - 在一个完全没有执行过git命令的目录下执行此名令
  - 如对于一个新的项目test
    - ```shell
      cd test
      git_push -c "this is a new"
      #这将会在Github创建一个test仓库
      ```
    -  之后对本文件夹下的文件的更改也可以在test目录下运行git_push实现
  - 命令执行输出在本目录下的gitpush_log文件中
> A 