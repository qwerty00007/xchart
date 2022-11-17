# truenas scale 个人应用库

## APP List

- **jellyfin** 使用 [nyanmisaka/jellyfin](https://hub.docker.com/r/nyanmisaka/jellyfin) docker 镜像，增加配置 `/etc/hosts`
- **nastools** 增加配置 `/etc/hosts`，相关[教程](https://gitee.com/qwerty0007/xchart/blob/main/stable/nastools/readme.md)
- **stripcharts** 下载社区应用的压缩包 [main.zip](https://github.com/truecharts/catalog/archive/refs/heads/main.zip)， 后筛选出自己需要的应用，push 到自己的 github 仓库，减少目录同步时间
- **stripcharts-gitea** 自己搭建 gitea 服务，将社区应用 [catalog](https://github.com/truecharts/catalog.git)，镜像到 gitea 服务器，再后筛选出自己需要的应用，push 到自己的 gitea 仓库
- **vlmcsd** 运行在 docker 里的 kms 激活服务器
- **ChineseSubFinder** 自动下载字幕
- **MT Photos** 照片备份 APP,收费软件，[官方网站](https://mtmt.tech/)
- **xunlei** 迅雷 docker 版本，邀请码：迅雷牛通
- **clash** 包含 core 和 ui。

## how to 增加第三方应用库

![增加第三方应用库](https://gitee.com/qwerty0007/xchart/raw/main/assets/add.png)

- gitee 源
  `https://gitee.com/qwerty0007/xchart.git`

- github 源
  `https://github.com/qwerty00007/xchart.git`

## 使用集群内的内部域名，应用内互访

- 查看所有 pod 的信息，获得应用的 NAMESPACE
  `k3s kubectl get pod -A` 

- 查看指定命名空间的 svc 信息，获得应用的 SERVICE-NAME
  `k3s kubectl get svc -n $NAMESPACE`

- 集群内的域名
  `$SERVICE-NAME.$NAMESPACE.svc.cluster.local`