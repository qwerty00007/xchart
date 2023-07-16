# NAS-Tools

NAS 媒体库资源归集、整理自动化工具

# NAS-TOOLS 硬链接详细配置

> 这个教程将告诉你在 TrueNAS SCALE 下部署 NAS- TOOLS，并配置硬链接的详细流程，配置好硬链接后，pt/bt 下载的文件不会变动，而是将媒体文件硬链接到另一个文件夹并重命名，刮削媒体信息，并且只占用一份容量。

## 添加应用仓库

将应用仓库 https://gitee.com/qwerty0007/xchart 添加目录

![图片](https://gitee.com/qwerty0007/xchart/raw/main/assets/add.png)

## 目录结构

我们使用`data`文件夹做为根目录。
`data`有两个子文件夹`downloads`和`media`，它们分别又有子文件夹`movies`，`TVs`和`others`。

> 要确保 NAS-TOOLS， 媒体服务器，下载器，对 `data`文件夹有**写入权限**。一般来说普通用户 id 都是 1000， 确保 id 为 1000 的用户对`data`有写入权限。
> 仓库内的 NAS-TOOLS，Jellyfin，官方应用 qBitterent，都可以方便的配置运行 id。

- `data/downloads`文件夹挂载到下载器如 qBittorrent。
  > 对于下载器来说，它只需要访问`downloads`文件夹，将相应的媒体保存至相应的目录`movies`或者`TVs`。
- `data/media`文件夹挂载到媒体服务器 Jellyfin，Emby 或者 Plex。
  > 对于媒体服务器来说，它只需要访问硬链接后的文件就行了，也就是`data/media`文件夹。
- `data`文件夹挂载到 NAS-TOOLS
  > 而对于 NAS-TOOLS 来说，因为他需要将`downloads`下的文件链接到`media`文件夹下，所以需要将挂载`/data`到 NAS-TOOLS

**注意：不可以将`downloads`和`media`文件夹分别挂载到 NAS-TOOLS，因为这样会被 docker 识别成两文件系统，导致不能创建硬链接。**

这个目录结构看起来是这样的：

```
data
├── downloads
│  ├── movies
│  ├── others
│  └── TVs
└── media
   ├── movies
   ├── others
   └── TVs
```

## TrueNAS SCALE 配置

1. 新建数据集`data`

设置权限，给普通用户读写权限，默认这个用户的 id 是 1000。

2. 设置 SMB 共享

挂载 smb，按照上面文件结构新建文件夹。

## NAS-TOOLS 配置

- 目录挂载

将`path/to/data`文件夹挂载到 NAS-TOOLS 的`/data`

![图片](https://gitee.com/qwerty0007/xchart/raw/main/assets/IMG_1.jpg)

- 设置`PUID`和`PGID`

![图片](https://gitee.com/qwerty0007/xchart/raw/main/assets/IMG_12.png)

- 媒体库配置
  1. 电影目录`/data/media/movies`
  2. 电视剧目录`/data/media/TVs`

![图片](https://gitee.com/qwerty0007/xchart/raw/main/assets/IMG_4.jpg)

- 目录同步配置
  1. 电影
  源目录`/data/downloads/movies` 
  <br>
  目的目录`/data/media/movies`
  2. 电影剧
  源目录`/data/downloads/TVs`
  <br>
  目的目录`/data/media/TVs`

![图片](https://gitee.com/qwerty0007/xchart/raw/main/assets/IMG_3.jpg)

- 下载器配置 qBitterent
  1. 电影
     保存路径`/downloads/movies`
     访问目录`/data/downloads/movies`
     分类标签 movies
  2. 电视剧
     保存路径`/downloads/TVs`
     访问目录`/data/downloads/TVs`
     分类标签 TVs

![图片](https://gitee.com/qwerty0007/xchart/raw/main/assets/IMG_5.jpg)

## 下载器配置 (qBitterent)

- 目录挂载

将`path/to/data/downloads`文件夹挂载到 qBitterent 的`/downloads`

![图片](https://gitee.com/qwerty0007/xchart/raw/main/assets/IMG_6.jpg)

- 设置`PUID`和`PGID`

![图片](https://gitee.com/qwerty0007/xchart/raw/main/assets/IMG_13.png)

- 设置分类

设置两个分类 movies 和 TVs：
1. movies 保存到`/downloads/movies`
2. TVs 保存到`/downloads/TVs`

![图片](https://gitee.com/qwerty0007/xchart/raw/main/assets/IMG_7.jpg)

![图片](https://gitee.com/qwerty0007/xchart/raw/main/assets/IMG_8.jpg)

设置种子管理模式为自动，这样会按类别保存

![图片](https://gitee.com/qwerty0007/xchart/raw/main/assets/IMG_9.jpg)

## 媒体服务器配置 (Jellyfin)

- 目录挂载

将`path/to/data/media`文件夹挂载到 Jellyfin 的`/media`

![图片](https://gitee.com/qwerty0007/xchart/raw/main/assets/IMG_10.jpg)

- 设置运行 ID

![图片](https://gitee.com/qwerty0007/xchart/raw/main/assets/IMG_14.jpg)

- 添加媒体库

将`/media/movies`和`/media/TVs`分别添加到媒体库

## 检查硬链接是否成功

- 使用 ls - al

在`media`里具体到某一个影片文件夹下 执行 `ls -al` ，影片前的数字大于 1 就硬链接成功了，实际上，这个数字是每硬链接一次就+1。

![图片](https://gitee.com/qwerty0007/xchart/raw/main/assets/IMG_11.jpg)

## 拓展应用

- 其他下载器
如果还有别的下载器，也下载一些影音文件， 比如又部署了一个 [迅雷 docker 版](https://hub.docker.com/r/cnk3x/xunlei)， 可以在 `downloads`文件夹新建`xunlei`，再在该文件夹下新建`movies`和 `TVs`，然后在将`path/to/data/downloads/xunlei`挂载到 xunlei 这个应用的下载目录`/xunlei/downloads`。

> 在`downloads`下再新建`xunlei`文件夹是为了方便管理各个下载器的文件。

然后在 NAS-TOOLS 的目录同步设置中添加迅雷下载的目录。这样每当迅雷下载好后， NAS-TOOLS 就会将影音文件刮削同步到`media`目录

- 导入已下载的影音文件
比如自己有一些影音文件，自己不想整理，可以在`data`目录下新建文件夹`import`，再在`import`新建`movies`和`TVs`。将相应的影音文件 copy 到对应目录，在 NAS-TOOLS 里面添加同步目录。这样 NAS-TOOLS 会自动整理重命名这些影音文件。
最后可能目录结构看起来是这样的：

```
data
├── downloads
│  ├── movies
│  ├── others
│  └── TVs
├── import
│  ├── movies
│  ├── others
│  └── TVs
└── media
   ├── movies
   ├── others
   └── TVs
```

同步目录

![图片](https://gitee.com/qwerty0007/xchart/raw/main/assets/IMG_15.png)


## 参考配置

![](https://ghproxy.com/https://raw.githubusercontent.com/qwerty00007/xchart/main/assets/nastools_readme.jpg)

## 参考

- [Hardlinks and Instant Moves (Atomic-Moves)](https://trash-guides.info/Hardlinks/Hardlinks-and-Instant-Moves/)



EDITOR on iPhone by [taio](https://taio.app/cn/)