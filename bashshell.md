# Bashshell

----

###  可以认为 BashShell 中只有 **字符串**变量和 **字符串**组成的序列。

----

### Operator

|operator|description|
|---|---|
|$< variable >|the value of variable|
|\`< cmd >\`|the stdout of the cmd|
|$(< cmd >)|the stdout of the cmd|
|$((< expr >))|numberic calculation|
|let < expr >|numberic calculation|
|[ <boolean expr > ]|return true or false|
|-eq|等于|
|-ge|大于|
|-le|小于|
|+|string concat|
|&#124;&#124;|or|
|&&|and|
|-n|not|
|()|make a array|


-----

###  ", ' 以及不加引号的区别

- 如果要输入包含空格 tab 等分隔符的字符串需要使用引号，比如

```shell
# error
a=quote effect
# correct
b="quote effect"
# correct
c='quote effect'
```

- '' 中的\$, \` 表示的字面量， ""中的的\$, \`字符会进过转义，比如
```shell
a=1
# a is 1
echo "a is $a"
# a is $a
echo 'a is $a'
# 列出当前目录的所有文件
echo "`ls`"
# `ls`
echo '`ls`'
# 列出当前目录的所有文件
echo "$(ls)"
# $(ls)
echo '$(ls)'
```

- all character in ' is literal. almost all character in " is literal.


-----------

### 控制语句

if and for
```bashshell
if [ condition ]
then
< statements >
fi
```
```bashshell
if [ condition ]
then
< statements >
elif [ condition ]
then
< statements >
else
then [ condition ]
< statements >
fi
```

```bashshell
while [ condition ]
do
< statements >
done```

```bashshell
util [condition]
do
< statements >
done
```
```bashshell
for < varaibalbe > in < array_typed_variable >
do
< statements >
done
```

-----------

### keywords


- bashshell cmd

|cmd|description|
|--------|-----------|
|declare|set the default type of a variable|
|unset|un set a variable|
|export|export a variable to be enviroment variable|
|seq|make a sequence|
|expr|numberic value, string operation|



------

### 位置参数

- shell 中定义函数时传递的参数是位置参数， \$1 表示传入的第一个参数， \$2 表示传入的第二个参数依次类推，比如

```shell
function f = {
a=$1+$2
echo $a
}

f "$@"
```

- \$* and \$@

> - "\$*" will be a string varaible, not an array, no matter what the positional param is.

> - "\$@" will be an array. if the positional param is an array.

> - the example below show the difference

a.sh
```bashshell
#!/usr/bin/bash
echo "$@"
echo "$*"
```

```bashshell
./a.sh i am your father
```


-----

### String Operation

**expr** 命令是 bash 原生提供的操作字符串的命令。我更常用 **grep**, **sed**, **awk** 这些linux的文本编辑工具，更常用也更强大。特别的这些工具都支持使用正则表达式。

regular expression:
[sed](http://coolshell.cn/articles/9104.html)

text manipulate:
[awk](http://coolshell.cn/articles/9070.html)


-----

### 运行 shell script

there are three four ways to start a shell script

< script_path >
bash < script_path >

the above two ways will start another bash process.

source < script_path >
. < scipt_path >

cmds in script_path will be interrepted by the current bash process.

the following codes show the difference

b.sh

```bashshell
#!/usr/bin/bash
echo $$
PATH="iamworking":${PATH}
```

```bashshell
source b.sh
```

```bashshell
bash b.sh
```

------

### array

|use|syntax|
|---|------|
|make an array|(value1 value2 value3 ... valuen)|
|fetch a value by index|\${array[index]}(\${array} is equal to \${array[0]})|
|fetch all value from an array|\${array[@]} or \${array[*]}|
|get the length of an array|\${#array[@]} or \${#array[*]}|

------


###  进程和bashshell
> - 写一个 bash script 比如 a.sh， 然后运行 ./a.sh 只会产生一个 进程吗？答案是不是的。
> - bash 的一些用法可以产生 **subshell**, subshell 是新的进程，有自己的 pid。
> - BASH_SUBSHELL变量显示了 子进程的level。可以用这个变量观察脚本是否产生了 subshell。
> - bash 中哪些用法可以产生 **subshell** ?
>> - bash 中的 command 有部分称为 builtin 的，不是 builtin 的 command 称为 external 的。 external command 一般会产生 subshell
>> - 圆括号中的命令列表，这些命令会执行在一个 subshell 中 (command_1;command_2;command_3...command_n)
>> - 后台 job 会产生subshell
>> - 管道会产生 subshell