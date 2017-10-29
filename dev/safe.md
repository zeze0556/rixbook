<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [cryptsetup 整盘加密](#cryptsetup-整盘加密)
- [tor网站服务](#tor网站服务)

<!-- markdown-toc end -->


# cryptsetup 整盘加密
过于复杂的密码很容易丢失，即使使用密钥管理器也容易发生误操作或者被迫暴露。而密钥文件其实也并非那么的可靠。

cryptsetup的命令真的很长。我写了个[小脚本](script/crypt.sh)简化下。

使用方法如下
```bash
crypt.sh action -k key -h header -d /dev/sdx -p xG -s offset -c cipher -b blocksize -e -n N
```

脚本只支持key文件的方式。脚本使用key文件的offset* 8位置的数值作为在key文件中的偏移,默认为1个字节，可以通过设置N的值来修改字节的大小，比如N为2就是两个字节的值*8作为最终的偏移，N越大，则密钥文件需要的也越大，因为表示偏移位置的数字范围也越大。我比较喜欢使用随机生成的文件，因此，这个最终的偏移是多少，除了打开文件，具体计算，我也不清楚，但只需要记住初始的值offset就可以了。

blocksize为密钥文件的大小， 单独可能没太大用，但如果将key文件和header文件直接拼接起来，带上参数-e, 则后续的操作(format除外)， 就不需要使用header文件了。脚本会将header文件解出来，放到/dev/shm下面，使用完之后，再删除掉它， 这个时候, blocksize就很有用了。

-p 对应的是align-payload 参数，支持偏移，这个值和blocksize, offset 一样， 支持K,M,G这样人类可看的格式。
action可以为 open, close, format, dump 对应的使cryptsetup的 open, close, format,luksDump

这样一来， 主要只用记住密钥文件的偏移即可。

# tor网站服务

最简单的方式，生成匿名网站: *.onion, 当然需要tor浏览器来访问
docker 部署
```yaml
version: "3.1"
services:
  torservice:
    image: goldy/tor-hidden-service
    restart: always
    links:
    - hello
    environment:
    - HELLO_PORTS=80:80
    - HELLO_SERVICE_NAME=hello
    volumes:
    - ./keys:/var/lib/tor/hidden_service/

  hello:
    image: nginx:alpine
    restart: always

```
