

# *unix* 相关

## msys2

### msys2 启动速度慢
原因: 缺少 /etc/passwd 和 /etc/group

``` bash
mkpasswd -l -c > /etc/passwd
mkgroup -l -c > /etc/group
```
