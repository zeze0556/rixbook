
<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [tor网站服务[链接](../dev/safe.html#tor-网站服务)](#tor网站服务链接devsafehtmltor-网站服务)
    - [cannot link to container](#cannot-link-to-container)
    - [ERROR: could not find an available, non-overlapping IPv4 address pool among the defaults to assign to the network](#error-could-not-find-an-available-non-overlapping-ipv4-address-pool-among-the-defaults-to-assign-to-the-network)

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

