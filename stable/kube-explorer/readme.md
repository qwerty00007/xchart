# kube-explorer
kube-explorer is a portable explorer for Kubernetes without any dependency.

# how-to

1. 将 k3s 配置文件复制到自己的存储池
```
cp /etc/rancher/k3s/k3s.yaml /mnt/path/to/you/pool/

```

2. 修改复制过来的 k3s 配置文件的服务器 ip 地址为自己 NAS 的 ip

![](https://ghproxy.com/https://raw.githubusercontent.com/qwerty00007/xchart/main/assets/kube-explorer-config.png)

3. 安装 kube-explorer 时将修改后的 k3s 配置文件挂载到容器 

![](https://ghproxy.com/https://raw.githubusercontent.com/qwerty00007/xchart/main/assets/kube-explorer-configfile.png)
