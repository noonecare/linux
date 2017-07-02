# coding: utf-8
import tornado.httpserver
import tornado.ioloop
from tornado.web import RequestHandler

from tornado.options import define, options

define("port", default=8000, help="run on the given port", type=int)


class ReverseProxyRequestHandler(RequestHandler):
    def get(self, *args, **kwargs):
        self.write("hello world")


if __name__ == '__main__':
    tornado.options.parse_command_line()
    app = tornado.web.Application(handlers=[(r"/", ReverseProxyRequestHandler)])
    http_server = tornado.httpserver.HTTPServer(app)
    http_server.listen(options.port)
    tornado.ioloop.IOLoop.instance().start()
