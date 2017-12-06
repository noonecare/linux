Docker


Docker 常见的应用是写 Dockerfile 创建一个或者多个镜像，然后部署一个或者多个 container , 每个 container 中包含了一项服务，组合起来提供一套完整的服务。

### Container
可执行环境，可以从 Image 中生成。
常用命令参见 [gist](https://app.gistboxapp.com/library/label/1496318728818)。
创建 container 的命令还是挺长的，手动输入容易出错。docker-compose 可以把从 image 中生成 container 的过程脚本化，通过写 docker-compose.yml 文件。写了 docker-compose.yml 文件之后，docker-compose up 就会起来 docker-compose.xml 配置的一套 container, docker-compose stop 就会停止 docker-compose.xml 中配置的container。



### Image

创建 Container 的菜谱。固化创建的虚拟环境，方便重现Container(可执行环境)。

- docker build: 写 Dockerfile 创建 image, 把创建 Image 的步骤脚本化，方便自动化部署（可执行环境）。[Dockerfile 的例子](https://github.com/turnbullpress/dockerbook-code)。
- docker commit


### Registry

image 的仓库，方便共用image。 docker push 把自己写的 image 推送到 registry 中； docker pull 把别人写的 image 拉下来。


常见的问题：

1. COPY 和 ADD 异同?
ADD 会解压， COPY 不会解压。

2. Docker CMD 和 ENTRYPOINT 异同？
CMD 会被运行 Contaner 时的语句覆盖；ENTRYPOINT 不会，ENTRYPOINT。

3. Port Mapping

4. link

5. volume

6. 通过 link 和 volume 连接多个 container 提供一套服务

7. volume 和 mount ?
volume 就是 container 中可用于共享数据以及持久化数据的文件。
mount 是对于 volume 的操作，通过 mount 建立本地文件系统和 Container 中 volume 的对应。

8. docker-compose.yaml 中有 volumes volumes-from volumes-driver , 这三个选项有什么联系有什么区别?
volumes 用于声明 volume
[volumes-from 用于引用其他 container 中已经创建的 volume（如果当前container 中已经有一个和 volume-from 的volume 同名的 volume ，直接 volume 是不是会报错）](https://jiajially.gitbooks.io/dockerguide/content/chapter_fastlearn/docker_run/--volumes-from.html)
volumes-from 可以用于持久化 volume。
[volume_driver](https://docs.docker.com/compose/compose-file/compose-file-v2/#userns_mode) docker 官方文档上有介绍，很少用，不知道也无所谓。






更多问题：

kubernetes: 在集群上部署 container， 非常容易横向扩展，除此之外 kubernetes 可以监控 container 的运行状况。


推荐读物：《The Docker Book》