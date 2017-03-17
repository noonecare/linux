# 文本处理

- vim
> - Oreilly 的 《学习vi和vim编辑器》 写的既全面又通俗易懂，遇到什么不会刻意查查这本书
> - .swap 文件， 编辑 vim 遇到意外退出的情况，当前编辑的情况会被保存在 同名但加了 .swap 的文件名中，下一次你打开这个文件时，会有个 对话框，问你是 Recovery 还是 Edit anyway。 你可以 recovery 也可以 edit anyway。但是做完之后，需要删除 .swap 文件，否则下一次打开还会出现这个对话框。
> - 删除特定行 :g/<regular_expression>/d, 比如删除空行， :g/^$/d
> - 给字符串填上 " 号 :%s/[a-z]\+/"&"/g


- sed

- awk


# 计划和定时任务

- crontab

- at

# 编译器

- gcc
> - gcc 编译 C 代码时，默认会连接（引用） /usr/ 和 /usr/lib 以及 LD_LIBRARY_PATH 环境变量路径下的 .so 文件（静态连接文件）和 .a 文件（动态连接文件）。除此之外，如果你想手动指定引用一个目录下的 .a 或者 .so 文件，可以执行
-L 指明连接所在的目录， -l 指明连接文件名称（非文件名，比如 liba.so 的名称为 a）
-I 指明头文件所在的目录
```shell
gcc example.c -L example_directory -l exampleshared
```


> - gcc 生成库文件
```
gcc -c -fPIC exmaple.c -o example.o
gcc example.o --shared -o example.so
```

- make
> - make 执行的是 MakeFile 文件，根据 MakeFile 中的语句，编译安装程序
> - make install 是我最常用的语句

- cmake


# 程序管理

- supervisor


# Web Server
- nginx


# 打包以及解压缩

- tar


# web
- curl
- wget

