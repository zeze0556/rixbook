<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [gogs](#gogs)
    - [backup](#backup)

<!-- markdown-toc end -->


# gogs

## backup

``` bash
gogs backup
```

docker 环境下，需要设置USER环境变量为git，再执行上面的命令

``` bash
docker exec gogs_gogs_1 bash -c "USER=git /app/gogs/gogs backup"
```

