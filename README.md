## 使用[Goliath](https://github.com/postrank-labs/goliath) 1.0 实现高性能微服务API 完整模板（仅供参考）

此项目为多年前基于Goliath1.0 + Grape 所做项目，因为Goliath并没有提供一个统一的项目结构，故抽离的模板，可以参考此模板方便的实现API微服务。

支持：

1. 异步Rack Middleware
2. 类Rails的项目目录结构，方便开发
3. 自扩展的Goliath命令，比如 goliath console/ goliath start /goliath db 等，按需修改
4. 支持em-synchrony异步http remote request方法（查看lib/tools/http_base.rb）
5. 增加了Docker化文件(需要自行按需修改)
6. 支持Jbuilder 并且 支持json cache （查看lib/tools/json_cache.rb 需要自己定义）
7. 支持异步任务
8. 支持capistrano部署
9. 支持paperclip文件上传（查看config/initializes/paperclip.rb）
10. 支持国际化、本地时区
11. 其他（比如，可以自己配置Grape Entity替换jbuilder等）
