# 磁盘相关

## 压缩挂载
btrfs 支持压缩挂载，既节省空间又加快速度。
```bash
mount -o compress=lzo /dev/sdx /data
```
