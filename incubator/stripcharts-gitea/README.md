# StripCharts
筛选你需要的应用推送到自建 gitea 服务器
环境变量说明
* `STRIP_STABLE` 筛选在仓库里 **stable** 的 apps 例如：`nextcloud|plex|traefik|cloudflareddns|vaultwarden`，注意用 `|` 分隔
* `STRIP_INCUBATOR` 筛选在仓库里 **stable** 的 apps 例如：`actualserver|breitbandmessung-de`，注意用 `|` 分隔
* `STRIP_REPO` 这里填你需要 push 的 gitea 服务器地址，例如：`http://user:password@nas_ip:10037/user/my_striped_charts.git`
* `CATALOG_REPO` 将社区应用 [catalog](https://github.com/truecharts/catalog.git)，镜像到 gitea 服务器，然后将仓库地址填入，例如：`http://nas_ip:10037/user/catalog/archive/main.zip`
* `USER_EMAIL` 配置 git user email.
* `USER_NAME` 配置 git user name.
这样可以减少同步目录的时间，和减少下载大量无用的应用。

## 参考配置

![](https://ghproxy.com/https://raw.githubusercontent.com/qwerty00007/xchart/main/assets/stripcharts_gitea_readme.jpg)