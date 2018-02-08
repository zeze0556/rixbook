<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [问题1： 类变量默认为null](#问题1：-类变量默认为null)

<!-- markdown-toc end -->


# 问题1： 类变量默认为null
程序中的部分java代码使用动态加载的方式，如果仅使用lib引用最终工程的方式，不会有任何问题;如果使用引用项目源代码工程的话，则在使用过程中，有些类变量表现为全都是未初始化，有些却不是。

最后调查的结果是，动态加载的代码和引用源代码中的类相同造成的，最终导致内存中存在同一个类的多份定义，java虚拟机在使用时，几份同时使用，造成最终类变量表现异常

# android 源代码
刚开始的时候使用清华的镜像，结果最后发现不全，在aosp上列出的代码库在镜像中不一定存在，归根结底，清华的镜像是使用repo创建的，这样如果某个仓库不在列表中的话，就无法自动下载了。于是，写了个小脚本，直接从aosp上下载列出的所有的仓库来建立镜像:

``` bash
#filename aosp.sh
set -x 
aosp="https://android.googlesource.com"
url="$aosp/?format=TEXT"

function init() {
for i in `curl $url`; do
    if [ ! -d "$i.git" ]; then
        mkdir -p `dirname $i` && cd `dirname $i` && git clone --mirror $aosp/$i
        cd -
    fi
done
}

function sync() {
for i in `find . -name \*.git`; do
        cd $i && git remote prune origin && git remote update -p
        cd -
done
}

$1

```

运行aosp.sh init 来初始化，这个会下载所有的镜像，以后可以通过aosp.sh sync来增量同步

## cm14.1 (lineageos) 编译


