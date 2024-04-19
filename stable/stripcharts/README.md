# StripCharts
筛选 truecharts 中你需要的应用推送到自建 gitea 服务器, gitee 或者 github。gitee 和 github 就使用 token 推送。
环境变量说明
* `STRIP_STABLE` 筛选在仓库里 **stable** 的 apps 例如：`nextcloud|plex|traefik|cloudflareddns|vaultwarden`，注意用 `|` 分隔
* `STRIP_PREMIUM` 筛选在仓库里 **premium** 的 apps 例如：`actualserver|breitbandmessung-de`，注意用 `|` 分隔
* `STRIP_system` 筛选在仓库里 **system** 的 apps 例如：`actualserver|breitbandmessung-de`，注意用 `|` 分隔
* `STRIP_REPO` 这里填你需要 push 的 gitea 服务器地址，例如：`http://user:password@nas_ip:port/user/my_striped_charts.git`
* `CATALOG_REPO` 将社区应用 [catalog](https://github.com/truecharts/catalog.git)，镜像到 gitea 服务器，然后将仓库地址填入，例如：`http://nas_ip:port/user/catalog.git`，或者使用 auth token 推送到github https://ghp_17613457614573562476235476@github.com/test/test.git
* `USER_EMAIL` 配置 git user email.
* `USER_NAME` 配置 git user name.
这样可以减少同步目录的时间，和减少下载大量无用的应用。

## 参考配置

![](https://ghproxy.com/https://raw.githubusercontent.com/qwerty00007/xchart/main/assets/stripcharts_gitea_readme.png)