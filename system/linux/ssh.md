<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [ssh是所有人最想要的后门程序](#ssh是所有人最想要的后门程序)
    - [本地转发](#本地转发)
    - [动态端口转发](#动态端口转发)
    - [xwindow 中文乱码](#xwindow-中文乱码)

<!-- markdown-toc end -->


# ssh是所有人最想要的后门程序

## 本地转发

```bash
ssh -L 3309:localhost:3306 user@remote
```

## 动态端口转发
这个非常有用，作用么，就是让远程主机做枪手
```bash
ssh -D -g -N 8088 user@remote
```

## xwindow 中文乱码
可能缺少中文字体

``` shell
sudo apt install fonts-arphic-uming
```
