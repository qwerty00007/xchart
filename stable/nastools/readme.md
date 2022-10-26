# NAS-Tools

NAS媒体库资源归集、整理自动化工具

参考官方文档：

配置： `PUID`,`PGID`,`/config`,

默认媒体文件夹挂在 `/data`

媒体文件夹推荐目录：

新建数据集 `data` 给 `PUID` 和 `PGID` 对应用户读写权限，再在 `data` 新建文件夹，`media` 和 `download`,`media` 和 `download` 文件夹分别新建 `movies`,`TVs` 和 `others` 文件夹。下载工具分别将电影，电视剧和其他媒体，分别存放在 `movies`, `TVs` 和 `others`。其他详细配置参考官方教程。

> **注意 `data` 数据集是手动新建文件夹，不是新建数据集，不然无法硬链接的**
