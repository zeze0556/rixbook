
<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [tor网站服务[链接](../dev/safe.html#tor-网站服务)](#tor网站服务链接devsafehtmltor-网站服务)
    - [cannot link to container](#cannot-link-to-container)
    - [ERROR: could not find an available, non-overlapping IPv4 address pool among the defaults to assign to the network](#error-could-not-find-an-available-non-overlapping-ipv4-address-pool-among-the-defaults-to-assign-to-the-network)
    - [网络限速](#网络限速)

<!-- markdown-toc end -->
# tor网站服务[链接](../dev/safe.html#tor-网站服务) 


## cannot link to container

docker: Error response from daemon: Cannot link to /redis, as it does not belong to the default network.
添加下列参数

```
--net XX_default
```

## ERROR: could not find an available, non-overlapping IPv4 address pool among the defaults to assign to the network

``` bash
docker network prune
```

## 网络限速

有时候需要进行网络限速，iproute2的tc命令是个非常简单的工具。在docker的container中进行限速的话，效果非常的好，而且不容易对其他的服务产生干扰。

1. 需要添加cap_add 参数并且包含NET_ADMIN权限
2. docker-compose文件中可以添加cap_add字段

以ipfs的docker镜像为例，ipfs默认没有设置任何限速，因此，很容易造成下载或者上传流量太大而其他正常使用网络的程序运行缓慢，尤其对于软路由而言，很容易造成路由器的连接数过多而造成所有设备无法上网。

从ipfs-go下载代码后，ipfs-go使用的基础镜像是busybox:1-glibc，这个默认是没有iproute2在内的，不过，我们可以将这个镜像替换为frolvlad/alpine-glibc, 然后 RUN apk add --no-cache iproute2 busybox; frolvlad/alpine-glibc的glibc库已经比较全了，所以libc.so.6就务必要了。 path如下:
```
sed -i -e 's/busybox\:1\-glibc/frolvlad\/alpine-glibc/g' -e '/libdl.so/cRUN apk add --no-cache iproute2' Dockerfile
```
写个脚本方便调用，比如将其挂载到/bin/netlimit上
```
#!/bin/sh
UP="$1"
/sbin/tc qdisc del dev eth0 root
/sbin/tc qdisc add dev eth0 root tbf rate ${UP}kbit latency 50ms burst 15kb

```
使用时只要docker exec container_id netlimit num 即可，配合cron等工具，还可实现定时限速
