
- HTTP 是根据人的需求不断完善起来的, 从历史来看这些需求有：
     - 链接的更快
     - 追踪流量的来源
     - 认证/安全
     - 管控
     - 减轻服务器的负载
     - International
     - 断点续传
     - 多人协作修改网络资源
     - 丰富的应用

- 链接的更快
     - connection: keep-alive。
          - 建立 HTTP 链接，首先会建立 TCP 链接。然后让 HTTP 公用 TCP 链接（常被称为通道），就能加快 HTTP 通信的速度（减少了建立 TCP 通道的时间）。 connection 表头的值常常是 keep-alive。
          - 这种解法带来一个问题，Server 如何判断何时应该断开一个 TCP 链接
              - 为了解决这个问题，出现了 Content-Length 表示 Content-Length 的长度，当 TCP 通道经过 Content-Length Byte 后，Server 就会断开 TCP 链接。
              - 上面这种解法，又导致一个问题，就是如果 response body 是变长的， Server 如何判断何时应该断开一个 TCP 链接
              - 为了解决这个问题，出现了 transfer-encoding: chuncked 这种传输方式。server 遇到 Zero-byte Chunck 这个符号时，断开 TCP 通道。
     - cache proxy
         - 光绕地球一圈大约需要 0.13 秒，所以距离远，一般http会慢。而且距离远，一般会进过多次 route, 每次 route 也花时间。cache 服务器的出现，能减少这些因素的耗时。
         - cache proxy 的原理是把 popular 的 resource 保存在 cache proxy 中，用户访问某资源，如果在 proxy 中，已经有了该资源（称为 hit），直接从 proxy 中获取该资源，如果 proxy 中没有，再从 资源的 server 中获取资源。
         - cache proxy 可能会导致一个问题就是资源不是最新版。为此出现了 cache-control 表头。
         - Cache-Control: no-store(不会在proxy 上保留response文件)
         - Cache-Control: no-cache（会保留response 文件，但是serve client 之前必须首先 revalidate）
         - Pragma: no-cache(HTTP 1.0 中的 Cache-Control)
         - Cache-Control: max-age=3600
         - Cache-Control: s-maxage=3600
         - Expires: Fri, 05 Jul 2002, 05:00:00:00 GMT
         - Cache-Control: must-revalidate
         - Date: 资源被创建的日期
         - Age: 收到该资源过了多长时间



- 认证/安全

 - 请求一项资源， Server 返回 start line 为
HTTP/1.1 401: Login Required（HTTP 版本号也可能是 HTTP/1.0）
headers 中包含 WWW-Authenticate header 的 response。
使用 chrome 的话，会自动弹窗让你输入账号密码。
输入账号密码(实际上向Server 发送了个带 Authorization header 的 request 比如Authorization: Basic am910jRmdW4=)
Server 接到这样一个带了 Authorization 并且密码正确的话，就会把资源反馈给用户。
 - WWW-Authenticate 和 Authorization 表头中的 Basic ，表示用何种算法加密密码。常见的有两种：
     - Digest Digest 多了一步加密解密的过程，比如，我有公钥， server 有公钥和私钥，我对公钥做个 hash(比如用 MD5算法)得到一个 新的密码（经常被称为 fingerprint）,验证的时候，把fingerprint 发给 Server, Server 对Server 本身有的公钥用同样的算法做个 hash 得到一个 fingerprint, 两个 fingerprint 相同，认证成功，Server 向 Client 发送Response。但是Response 是用 私钥编码过的，必须有公钥才能解码。公钥从来没有在网络中传输过，别人从网络中截取到的数据，最多只可能是 fingerprint, 所以别人最多可以截获Response, 但是却没法解码Response.
     - Basic  Base64编码密码。最好在 https 中使用，在 http 中使用不是很安全。Basic Authentication is convenient and flexible but completely insecure.




- 追踪用户
很多网站的引用需要跟踪用户，了解用户的行为。

     -  **Cookies** 跟 cookies 相关的header 就是 cookies 和 set-cookies header
比如，访问知乎，输入账号和密码，这些账号和密码就保存在了 cookies header。Cookies 中一般有 Domain, path, Expires attributes。

     - 常用的包含用户信息的 header 有：

|Header name|Header type|Description|
|-----------|-----------|-----------|
|From|Request|User's email address|
|User-Agent|Request|User's browser software|
|Referer|Request|page user came from by following link|
|Authorization|Request|Username and password|
|Client-ip|Extension(Request)|Client's IP address|
|X-Forwarded-For|Extension(Request)|Client's IP address|
|Cookie|Extension(Request)|Server-generated ID label|

     - 这些保存用户信息的 header, 都可以伪造。 比如 From header 按理说应当是用户的邮箱地址，但是实际上 From 得到的邮箱地址很可能不是用户的邮箱地址， 用户不想暴露自己的地址，瞎填了个地址。爬虫经常会伪造 User-Agent， 高匿代理会伪造 XFF。综上所述，追踪用户，最靠谱的办法还是使用 cookies。

HTTP Rules to determine the end of a message:

-  If message type cannot have a enity body, the message ends when countered the CRLF. headers may have  content-length header, however, content-length header is ignoreed. a example for this case is a response message for HEAD method.
-  If a message have **Transfer Encoding** header in its header, the message is ends by **Zero-byte Chunk**
-  a message can have a **Content-Length** header. message ends according to the **Content-Length** header. unless there is a **non-identitty Transfer encoding**.
-  a message whose MIME types is "multipart" valued, then each part of the message will specify its own size, that's what called **self-delimited**. a sender cannot send such a message unless he is sure of that the recipiant can parse it.
-  a message ends when close connection. In practice, only Server can use Close Connection.
-  If cannot determine the length of the entity body for a message which own a enity body. HTTP/1.1 will response with 411 code, or 401 code.

实话讲，我不知道 Transfer Encoding， non-identity Transfer Encoding 是什么概念。




mediat-type: multi-part 表示消息是 分成多个消息传送的。这里就有一个问题，如果知道多个部分属于一条信息。比如，传送一个文件，

```bashshell
Content-Type:multipart/form-data;boundary=---------------------------7d33a816d302b6
```

```bashshell
Content-Type: multipart/mixed; boundary=unique-boundary-1
--unique-boundary-1
Content-type: text/plain; charset=US-ASCII
Hi there, I'm some boring ASCII text...
--unique-boundary-1
Content-Type: multipart/parallel; boundary=unique-boundary-2
--unique-boundary-2
Content-Type: audio/basic
... 8000 Hz single-channel mu-law-format
audio data goes here ...
--unique-boundary-2
Content-Type: image/jpeg
... image data goes here ...
--unique-boundary-2--
--unique-boundary-1
Content-type: text/enriched
This is <bold><italic>enriched.</italic></bold>
<smaller>as defined in RFC 1896</smaller>
Isn't it <bigger><bigger>cool?</bigger></bigger>
--unique-boundary-1
Content-Type: message/rfc822
From: (mailbox in US-ASCII)
To: (address in US-ASCII)
Subject: (subject in US-ASCII)
Content-Type: Text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: Quoted-printable
```

**multipart submission**
```bashshell
Content-Type: multipart/form-data; boundary=[abcdefghijklmnopqrstuvwxyz]

```

**multi response range**
```bashshell
HTTP/1.0 206 Partial content
Server: Microsoft-IIS/5.0
Date: Sun, 10 Dec 2000 19:11:20 GMT
Content-Location: http://www.joes-hardware.com/gettysburg.txt
Content-Type: multipart/x-byteranges; boundary=--[abcdefghijklmnopqrstuvwxyz]--
Last-Modified: Sat, 09 Dec 2000 00:38:47 GMT
--[abcdefghijklmnopqrstuvwxyz]--
Content-Type: text/plain
Content-Range: bytes 0-174/1441
Fourscore and seven years ago our fathers brough forth on this continent
a new nation, conceived in liberty and dedicated to the proposition that
all men are created equal.
--[abcdefghijklmnopqrstuvwxyz]--
Content-Type: text/plain
Content-Range: bytes 552-761/1441
But in a larger sense, we can not dedicate, we can not consecrate,
we can not hallow this ground. The brave men, living and dead who
struggled here have consecrated it far above our poor power to add
or detract.
--[abcdefghijklmnopqrstuvwxyz]--
Content-Type: text/plain
Content-Range: bytes 1344-1441/1441
and that government of the people, by the people, for the people shall
not perish from the earth.
--[abcdefghijklmnopqrstuvwxyz]--
```


- 丰富的应用 MIME

MIME type 不同，浏览器对于接受到的 response 采取的操作不同。比如如果 response 的 Content-Type 为 text/, 那么浏览器会直接打开 response， 把 response 的内容显示在窗口中。如果 response 的 Content-Type 为 application/, 那么浏览器一般会把 response 保存到本地。除此之外，不同浏览器对于相同 MIME type 的 response 采取的操作也可能不一样。


- Restful API

我一直认为 http 服务器，不做前端，就是 Restful API 接口。

Restful API 有如下的定义（不过我还是似懂非懂）:

- Uniform interface
- Client/Server separation
- Stateless( session state is always hold on the client side, 我觉得这一句最扯，我看到的很多服务器都把session id 保存在数据库里)
- Cacheable
- Layered
- Strength

最后来一道常见的考试题： Session 和 Cookie 的区别：

Session是在服务端保存的一个数据结构，用来跟踪用户的状态，这个数据可以保存在集群、数据库、文件中；
Cookie是客户端保存用户信息的一种机制，用来记录用户的一些信息，也是实现Session的一种方式。