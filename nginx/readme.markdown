执行
```shell
python python_server.py --port=8000 &
python python_server.py --port=8001 &
python python_server.py --port=8002 &
python python_server.py --port=8003 &
```

启动 4 个 tornado server。

```shell
cat reverse-proxy-server.conf >> /etc/nginx/nginx.conf
```

重新加载配置
```shell
nginx -s reload
```

这时，访问 http://localhost:80 nginx 服务器会把 request 做反向代理（传给 4 台 tornado 服务器中的一台）,这样可以做负载均衡。

```shell
curl http://localhost:80
```