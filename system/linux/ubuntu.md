<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [相关问题](#相关问题)
    - [gpg错误](#gpg错误)
    - [wifi 速度慢](#wifi-速度慢)
- [切换java版本](#切换java版本)
- [使用QQ](#使用qq)
- [插入手机，U盘等不自动弹出文件管理器](#插入手机u盘等不自动弹出文件管理器)

<!-- markdown-toc end -->

# 相关问题
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
