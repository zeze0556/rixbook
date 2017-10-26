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
