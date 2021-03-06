<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [相关问题](#相关问题)
    - [联想E40-30笔记本无法关机，重启](#联想e40-30笔记本无法关机重启)
    - [gpg错误](#gpg错误)
    - [wifi 速度慢](#wifi-速度慢)
- [切换java版本](#切换java版本)
- [使用QQ](#使用qq)
- [插入手机，U盘等不自动弹出文件管理器](#插入手机u盘等不自动弹出文件管理器)
- [查看 apt 记录](#查看-apt-记录)
- [login界面键盘鼠标无法输入](#login界面键盘鼠标无法输入)
- [kvm](#kvm)
    - [kvm 桥接](#kvm-桥接)
        - [客户端无法动态分配到ip地址](#客户端无法动态分配到ip地址)
        - [客户端挂载 virtio 9p 共享目录无法写入](#客户端挂载-virtio-9p-共享目录无法写入)

<!-- markdown-toc end -->

# 相关问题
## 联想E40-30笔记本无法关机，重启
似乎无论那个版本，默认都这样，关机后，最好的结果是屏幕黑掉，然后电源还开着。一不小心就弄的
完全没电开不了机。

从网上找到的添加acpi=force, apm=power_off, apm=on之类的，最多的效果就是屏幕黑了，但关不了机。重启也是偶尔可以重启。

通过阅读文档，并经过上百次的组合测试，最后启动添加的参数如下:

```
apm=on apm=power_off acpi=force reboot=pci pci=noacpi
```
上述的参数可以正常关机，重启。我自己觉得最重要的应该是最后的两个， reboot=pci后，基本可以实现正常重启，但关机似乎不能断电。然后添加上pci=noacpi后，关机可以断电了。

## gpg错误
```bash
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32
```

## wifi 速度慢
  可能是节能的关系，将节能关掉试试
 ```bash
 sudo iwconfig wlan2 power off
 ``` 

# 切换java版本

``` bash
sudo update-alternatives --config javac
```
# 使用QQ

*下面的操作是几年前的，现在早已放弃了*

x86_64环境下
对于64位操作系统，由于缺少32位库，因此操作相对麻烦
依次执行命令
``` bash
sudo apt-get install lib32ncurses5
sudo apt-get install lib32z1
sudo apt-get install lib32bz2-1.0
sudo apt-get install libgtk2.0-0:i386
```

执行完之后就可以像32位系统一样操作了，第一次使用时输入命令

``` bash
sudo bash /opt/longene/qq/qq.sh
```
然后即可运行，以后运行时按windows键，输入QQ，看到QQ的图标单击即可
无法输入中文件的问题

open the file using below cmd
```
sudo vim /opt/longene/tm2013/tm2013.sh 
```
add by cherish
```
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
```


# 插入手机，U盘等不自动弹出文件管理器

每次插入都弹出一个新的，怪烦人的

``` bash
gsettings set org.gnome.desktop.media-handling automount-open false
```

# 查看 apt 记录

有时候搞错了，不知道之前装了哪些

``` bash
vi /var/log/apt/history.log
```

# login界面键盘鼠标无法输入

试试远程是否能能登陆，如果远程可以登陆的话，说明没死。或者过段时间看看屏幕会不会灭或者出现屏保，这都说明系统没死，只是负责处理鼠标的程序出现了问题，或者被卸载了。

``` bash
apt-get install xserver-xorg-input-evdev
apt-get install xorg xserver-xorg
apt-get install xserver-xorg-input-all
```
# kvm

## kvm 桥接

### 客户端无法动态分配到ip地址

客户端手动分配ip地址后，可以和host主机进行互相通讯，但无法与之外的主机进行通讯。可能是内核配置的关系: /etc/sysctl.conf
``` ini
net.bridge.bridge-nf-call-ip6tables = 0 
net.bridge.bridge-nf-call-iptables = 0 
net.bridge.bridge-nf-call-arptables = 0

```
sysctl -p 可以不重启成效

### 客户端挂载 virtio 9p 共享目录无法写入

客户端挂载共享目录后，共享目录只能读取，无法写入, 可能是qemu配置有问题, 在/etc/libvirt/qemu.conf 中设置 user="root" 和 group="root" 
