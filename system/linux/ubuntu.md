
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
