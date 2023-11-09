# moviepilot

NAS 媒体库资源归集、整理自动化工具

配置文件请使用注释后的 [app.env](https://gitee.com/qwerty0007/xchart/raw/main/stable/moviepilot/app.env)

## 添加应用仓库

将应用仓库 https://gitee.com/qwerty0007/xchart 添加目录

![图片](https://gitee.com/qwerty0007/xchart/raw/main/assets/add.png)

## 目录结构

我们使用`data`文件夹做为根目录。
`data`有两个子文件夹`downloads`和`media`，它们分别又有子文件夹`movies`，`TVs`和`others`。

> 要确保 moviepilot， 媒体服务器，下载器，对 `data`文件夹有**写入权限**。一般来说普通用户 id 都是 1000， 确保 id 为 1000 的用户对`data`有写入权限。
> 仓库内的 moviepilot，Jellyfin，官方应用 qBitterent，都可以方便的配置运行 id。

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

## qb 或 tr 下载器配置
- `path/to/data/downloads`文件夹挂载到下载器如 qBittorrent。
  > 对于下载器来说，它只需要访问`downloads`文件夹，将相应的媒体保存至相应的目录`movies`或者`TVs`。
## 媒体服务器配置
- `path/to/data/media`文件夹挂载到媒体服务器 Jellyfin，Emby 或者 Plex。
  > 对于媒体服务器来说，它只需要访问硬链接后的文件就行了，也就是`/data/media`文件夹。
## moviepilot 配置
- `path/to/data`文件夹挂载到 moviepilot
  > 而对于 moviepilot 来说，因为他需要将`downloads`下的文件链接到`media`文件夹下，所以需要将挂载`/data`到 moviepilot
  > 由于 moviepilot 要求下载保存目录，容器内映射路径需要一致，所以我们再将 /data/downloads，挂载到 moviepilot。

**注意：不可以将`downloads`和`media`文件夹分别挂载到 moviepilot，因为这样会被 docker 识别成两文件系统，导致不能创建硬链接。**

- moviepilot 目录挂载
Moviepilot Storage

Configuration Volume 挂载到 moviepilot 的 `/config`

moviepilot Volume 挂载到 moviepilot 的 `/moviepilot`

Media Data Volume `/path/to/data`挂载到 moviepilot 的 `/data`

Downloads Volume `/path/to/data/downloads`（*这个目录必须是 data 下的文件夹*）挂载到 moviepilot 的 `/downloads`

![图片](https://gitee.com/qwerty0007/xchart/raw/main/assets/IMG_1.png)


## 参考

- [Hardlinks and Instant Moves (Atomic-Moves)](https://trash-guides.info/Hardlinks/Hardlinks-and-Instant-Moves/)
- [moviepilot 配置常见问题](https://github.com/Putarku/MoviePilot-Help)