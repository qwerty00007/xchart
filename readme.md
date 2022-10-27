truenas scale 应用

使用官方应用和社区应用修改的

APP list

- **jellyfin** 使用 [nyanmisaka/jellyfin](https://hub.docker.com/r/nyanmisaka/jellyfin) docker 镜像，增加配置 `/etc/hosts`
  
- **nastools** 增加配置 `/etc/hosts`
  
- **stripcharts** 下载社区应用的压缩包 [main.zip](https://github.com/truecharts/catalog/archive/refs/heads/main.zip)， 后筛选出自己需要的应用，push 到自己的 github 仓库，减少目录同步时间。
  
- **stripcharts-gitea** 自己搭建 gitea 服务，将社区应用 [catalog](https://github.com/truecharts/catalog.git)，镜像到 gitea 服务器，再后筛选出自己需要的应用，push 到自己的 gitea 仓库。
  
- **vlmcsd** 运行在 docker 里的 kms 激活服务器
  
- **ChineseSubFinder** 自动下载字幕
  
- **MT Photos** 照片备份 APP,收费软件
  
- **xunlei** 迅雷 docker 版本
  

# how to
![增加第三方应用库](/assets/add.png)

<https://github.com/qwerty00007/xchart.git>