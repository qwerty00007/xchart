# xunlei

迅雷远程下载服务(docker)(非官方) [链接](https://hub.docker.com/r/cnk3x/xunlei)

## 更新 image 到3.1.8
- 下载3.1.8的 image [下载链接](https://github.com/dragonflylee/xunlei/releases/download/v3.1.8/xunlei.3.1.8.amd64.tar.xz)
- 到命令行导入镜像
> docker import - cnk3x/xunlei:3.1.8 < xunlei.3.1.8.amd64.tar.xz
> 
> docker images

![图片](https://ghproxy.com/https://raw.githubusercontent.com/qwerty00007/xchart/main/assets/docker_images.png)


## 新版本可以配置 UID 和 GID 自定义下载文件的权限

- 配置环境变量

![图片](https://ghproxy.com/https://raw.githubusercontent.com/qwerty00007/xchart/main/assets/xunlei_env.png)

- 开启特权模式

![图片](https://ghproxy.com/https://raw.githubusercontent.com/qwerty00007/xchart/main/assets/xunlei_pri.png)

- 将挂载的目录更新权限
> chown -R 1000:1000 PATH/TO/xunlei/data
> 
> chown -R 1000:1000 PATH/TO/xunlei/downloads
