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

Downloads Volume `/path/to/data/downloads`（**这个目录必须是 data 下的文件夹**）挂载到 moviepilot 的 `/downloads`

![图片](https://gitee.com/qwerty0007/xchart/raw/main/assets/IMG_1.png)

- 简化后的 app.env
```
#######################################################################
# 【*】为必配项，其余为选配项，选配项可以删除整项配置项或者保留配置默认值       #
#######################################################################

####################################
#  基础设置                         #
####################################
# 【*】API监听地址
HOST=0.0.0.0
# 是否调试模式
DEBUG=false
# 是否开发模式
DEV=false
# 【*】API密钥，建议更换复杂字符串
API_TOKEN=moviepilot
# 登录页面电影海报,tmdb/bing
WALLPAPER=tmdb
# TMDB图片地址，无需修改需保留默认值
TMDB_IMAGE_DOMAIN=image.tmdb.org
# TMDB API地址，无需修改需保留默认值
TMDB_API_DOMAIN=api.themoviedb.org
# 大内存模式
BIG_MEMORY_MODE=false

####################################
#  媒体识别&刮削                     #
####################################
# 媒体信息搜索来源 themoviedb/douban
SEARCH_SOURCE=themoviedb
# 刮削入库的媒体文件 true/false
SCRAP_METADATA=true
# 新增已入库媒体是否跟随TMDB信息变化
SCRAP_FOLLOW_TMDB=true
# 刮削来源 themoviedb/douban
SCRAP_SOURCE=themoviedb

####################################
#   媒体库                          #
####################################
# 【*】媒体库目录，多个目录使用,分隔
LIBRARY_PATH=/data/media/
# 电影媒体库目录名，默认电影
LIBRARY_MOVIE_NAME=/data/media/movies
# 电视剧媒体库目录名，默认电视剧
LIBRARY_TV_NAME=/data/media/TVs
# 动漫媒体库目录名，默认电视剧/动漫
LIBRARY_ANIME_NAME=/data/media/Anime
# 二级分类
LIBRARY_CATEGORY=false
# 电影重命名格式
MOVIE_RENAME_FORMAT={{title}}{% if year %} ({{year}}){% endif %}/{{title}}{% if year %} ({{year}}){% endif %}{% if part %}-{{part}}{% endif %}{% if videoFormat %} - {{videoFormat}}{% endif %}{{fileExt}}
# 电视剧重命名格式
TV_RENAME_FORMAT={{title}}{% if year %} ({{year}}){% endif %}/Season {{season}}/{{title}} - {{season_episode}}{% if part %}-{{part}}{% endif %}{% if episode %} - 第 {{episode}} 集{% endif %}{{fileExt}}

####################################
#   站点                           #
####################################
# OCR服务器地址
OCR_HOST=https://movie-pilot.org
# 【*】CookieCloud对应的浏览器UA
USER_AGENT=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36 Edg/113.0.1774.57

####################################
#   订阅 & 搜索                     #
####################################
# 订阅模式 spider/rss
SUBSCRIBE_MODE=spider
# RSS订阅模式刷新时间间隔（分钟）
SUBSCRIBE_RSS_INTERVAL=30
# 订阅搜索开关
SUBSCRIBE_SEARCH=false
# 交互搜索自动下载用户ID，使用,分割
AUTO_DOWNLOAD_USER=

####################################
#   消息通知                        #
####################################
# 【*】消息通知渠道 telegram/wechat/slack，多个通知渠道用,分隔
MESSAGER=telegram
# WeChat企业ID
WECHAT_CORPID=
# WeChat应用Secret
WECHAT_APP_SECRET=
# WeChat应用ID
WECHAT_APP_ID=
# WeChat代理服务器，无需代理需保留默认值
WECHAT_PROXY=https://qyapi.weixin.qq.com
# WeChat Token
WECHAT_TOKEN=
# WeChat EncodingAESKey
WECHAT_ENCODING_AESKEY=
# WeChat 管理员
WECHAT_ADMINS=
# Telegram Bot Token
TELEGRAM_TOKEN=
# Telegram Chat ID
TELEGRAM_CHAT_ID=
# Telegram 用户ID，使用,分隔
TELEGRAM_USERS=
# Telegram 管理员ID，使用,分隔
TELEGRAM_ADMINS=
# Slack Bot User OAuth Token
SLACK_OAUTH_TOKEN=
# Slack App-Level Token
SLACK_APP_TOKEN=
# Slack 频道名称
SLACK_CHANNEL=
# SynologyChat Webhook
SYNOLOGYCHAT_WEBHOOK=
# SynologyChat Token
SYNOLOGYCHAT_TOKEN=

####################################
#   下载                           #
####################################
# 【*】下载保存目录，容器内映射路径需要一致
DOWNLOAD_PATH=/downloads
# 电影下载保存目录，容器内映射路径需要一致
DOWNLOAD_MOVIE_PATH=/downloads/movies
# 电视剧下载保存目录，容器内映射路径需要一致
DOWNLOAD_TV_PATH=/downloads/TVs
# 动漫下载保存目录，容器内映射路径需要一致
DOWNLOAD_ANIME_PATH=/downloads/anime
# 下载目录二级分类
DOWNLOAD_CATEGORY=false
# 下载站点字幕
DOWNLOAD_SUBTITLE=true

####################################
#   媒体服务器                      #
####################################
# 【*】媒体服务器 emby/jellyfin/plex，多个媒体服务器,分割
MEDIASERVER=jellyfin
# 入库刷新媒体库
REFRESH_MEDIASERVER=true
# 媒体服务器同步间隔（小时）
MEDIASERVER_SYNC_INTERVAL=6
# 媒体服务器同步黑名单，多个媒体库名称,分割
MEDIASERVER_SYNC_BLACKLIST=
# EMBY服务器地址，IP:PORT
EMBY_HOST=
# EMBY Api Key
EMBY_API_KEY=
# Jellyfin服务器地址，IP:PORT
JELLYFIN_HOST=http://jellyfin-tcp.ix-jellyfin.svc.cluster.local:9096
# Jellyfin Api Key
JELLYFIN_API_KEY=
# Plex服务器地址，IP:PORT
PLEX_HOST=
# Plex Token
PLEX_TOKEN=
```


## 参考

- [Hardlinks and Instant Moves (Atomic-Moves)](https://trash-guides.info/Hardlinks/Hardlinks-and-Instant-Moves/)
- [moviepilot 配置常见问题](https://github.com/Putarku/MoviePilot-Help)