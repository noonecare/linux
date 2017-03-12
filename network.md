Linux 网络指令

# DNS 解析

---

- 输入一个域名，程序如何找到域名对应的 IP 的。
> - 程序首先到 /etc/hosts 中寻找，是否有记录 hostname ip 项，指明了 一个 hostname 对应某个 IP。
> - 如果没有找到就到 /etc/resolv.conf 中寻找 DNS 服务器，去 DNS 服务器中找这个 hostname 对应哪个 IP。
> - 如果还没有找到这个 hostname 的 IP, 报 DNS 失败的错误。



# 公网和私网



NAT(Network Address Translation)
- NAT 为每个私有 IP 分配个公网 IP。
- 一般私有IP：Host 会被分配成公共 IP 加 端口号 的形式。

NAT 分为 SNAT(source), DNAT(Destination), PNAT()

iptables

# Network File System

----


nfs: 在 linux 虚拟机上 执行
```bashshell
mount -t nfs 10.200.200.57:/home/wangmeng /mnt/test_machine
```
