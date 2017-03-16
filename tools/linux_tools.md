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
- make
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
