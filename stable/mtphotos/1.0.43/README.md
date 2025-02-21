# MT Photos

[MT Photos](https://mtmt.tech/) A photo management system for Nas users

# AI API
在 mtphotos 安装时，增加部署 ai 的选项。
ai 容器使用 cluster ip，因此在 mtphotos webui 里增加 api 时要使用集群内的域名。

- 接口地址填写 http://mtphotos-ai:8000
> 假如你修改了应用名，比如应用名改为 test，那么，接口地址是 http://test-mtphotos-ai:8000
> 假如你修改了应用名，比如应用名改为 mtphotos22，那么，接口地址是 http://mtphotos22-ai:8000
> 建议安装应用时不要更改应用名
- API_AUTH_KEY 填写你安装时填写的key

# DF API
同理， 接口地址为 http://mtphotos-df:8066