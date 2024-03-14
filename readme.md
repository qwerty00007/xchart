# truenas scale 个人应用库

## APP List

> 应用部署请参考各个应用下的 readme.md

- **jellyfin** 使用 [nyanmisaka/jellyfin](https://hub.docker.com/r/nyanmisaka/jellyfin) docker 镜像，增加配置 `/etc/hosts`
- **vlmcsd** 运行在 docker 里的 kms 激活服务器
- **ChineseSubFinder** 自动下载字幕
- **MT Photos** 照片备份 APP, 收费软件，[官方网站](https://mtmt.tech/)
- **xunlei** 迅雷 docker 版本，邀请码：迅雷牛通
- **moviepilot** 追剧，媒体整理
- **cookiecloud** 同步 cookie
- **hlink** 硬链接工具
- **qbittorrent** bt 下载工具，支持 host 网络模式
- **transmission** bt 下载工具，支持 host 网络模式
- **alist** 挂载网盘
- **external-service** 代理集群外的服务

## 增加第三方应用库

- gitee 源<br>
  [https://gitee.com/qwerty0007/xchart.git](https://gitee.com/qwerty0007/xchart.git)

- github 源<br>
  [https://github.com/qwerty00007/xchart.git](https://github.com/qwerty00007/xchart.git)

![增加第三方应用库](https://gitee.com/qwerty0007/xchart/raw/main/assets/add.png)

## 使用集群内的内部域名，应用内互访

1. 查看所有 pod 的信息，获得应用的 NAMESPACE<br>

```
k3s kubectl get pod -A
```

2. 查看指定命名空间的 svc 信息，获得应用的 SERVICE-NAME<br>

```
k3s kubectl get svc -n $NAMESPACE
```

3. 集群内的域名<br>

```
$SERVICE-NAME.$NAMESPACE.svc.cluster.local
```

## 证书导入

1. 对于没有证书的朋友可以使用[mkcert](https://github.com/FiloSottile/mkcert)生成自己域名的证书，在局域网内测试，具体使用方法请参考该项目 github 上说明。
2. 也可以使用 acme 自动获取证书，参考视频[ACME 自动添加泛域名证书](https://b23.tv/g1T2FWo)

## 解决 truenas scale 痛点

1. 权限将 acl 权限设置为 nfsv4，方便配置

2. bios 时间同步</br>
   truenas scale webui 时间与 shell 的时间对不上解决方法，shell 下依次执行以下命令

```
sudo bash
systemctl stop ntp
ntpd -g -q
systemctl start ntp
hwclock --systohc
date
```

> 参考来源：https://www.truenas.com/community/threads/truenas-displays-time-correctly-but-sets-it-in-bios.109450/

3. 应用安装</br>
   应用运行 id 对于挂载的数据集要有读写权限，对应第 1 步的权限设置

4. 镜像加速

- docker.io 的加速
  truenas scale 23.10 配置 containerd 镜像加速
  在`/root/registries.yaml`写入以下内容

```
mirrors:
  ”docker.io“:
    endpoint:
      - ”https://docker.nju.edu.cn/“  ##加速地址，我使用的是南京大学开源镜像站
      - ”https://registry-1.docker.io“
```

然后执行以下命令

```
ln /root/registries.yaml /etc/rancher/k3s/registries.yaml
systemctl restart k3s.service ##重启 k3s 服务
```

> 参考 https://www.cnblogs.com/rancherlabs/p/14324469.html
>
> 已证实重启不会失效
>
> 升级要重新配置，可以设置开启执行以下命令
>
> ```
> ln /root/registries.yaml /etc/rancher/k3s/registries.yaml
> ```

- 其他镜像站参考 [南京大学开源镜像站私服仓库](https://doc.nju.edu.cn/books/35f4a)</br>
  使用`k3s crictl pull` 拉取镜像</br>
  再使用`k3s ctr image tag` 更改为所需的 image tag

## 请我喝奶茶

- 微信

  ![](https://gitee.com/qwerty0007/xchart/raw/main/assets/wechat.jpg)

- 支付宝

  ![](https://gitee.com/qwerty0007/xchart/raw/main/assets/alipay.jpg)
