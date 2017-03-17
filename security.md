# 文件权限

linux 文件的权限有 wrx， 使用 chmod 改变权限。这里主要讲一下比较特殊的权限：

- 特殊权限
> - s 权限： s 权限是一种可执行权限， a 文件对  others 有 s 权限，那么当 others 执行 a 文件时， others 可以具有 a 文件所有者的权限。
> - t 权限是目录设置的特殊权限，设置了 t 权限的目录文件，非文件 owner 不能删除文件。

- 设置权限(用 wrxts 表示权限，用数字表示权限)
> - chmod [0-7][0-7][0-7] < match_file_string >
> - chmod [augo(who)][+-][rwxst] < match_file_string >

----

# ACL


---

# ssh


---

# Kerberos


- kerberos 的principal 是随便一个不太长的字符串，还是必须有特殊格式的字符串。
> - 答案：principal has an arbitrary number of components, each component is seperated by a component separator, generatlly '/'. The last component is the realm, seperatoed from the rest of the principal by the realm separator, generally '@'. If there is no realm component in the principal, then it will be assumed that the principal is in the default realm for the context in which it is being used.

- kinit 产生的 TGT 会保存到那个路径
- 对于一个用户（TGT）如果 ADC 的 TGS 不给这个 用户(TGT) 发送 ST, 那么TGT 照样使用不了该向服务。
- kerberos 之所以会安全是因为 需要不断的 renew TGT。那么 keytab 是如何保证安全的。

- realm 是什么意思， 是 目录的意思，还是主机的意思？是域名？