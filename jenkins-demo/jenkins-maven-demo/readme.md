之前 jenkins build 时，一直报错：

```shell
FATAL: command execution failed.
java.io.IOException: error=2, No such file or directory
...
Caused: java.io.IOException: Cannot run program "mvn" (in directory "/var/lib/jenkins/workspace/maven-demo"): error=2,
No such file or directory
```

这个错误是因为没有给 jenkins 安装 maven 造成的。在 jenkins 服务器上，我执行以下操作

```shell
# 使用 jenkins 用户
sudo su jenkins
# 安装 maven
sudo apt-get install maven
```

问题解决。

teamcity is similar to jenkins
