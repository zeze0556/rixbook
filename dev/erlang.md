<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [问题1: elixir 连接远程节点并执行命令](#问题1-elixir-连接远程节点并执行命令)

<!-- markdown-toc end -->



# 问题1: elixir 连接远程节点并执行命令

可以获取到shell的方法:
``` bash
iex --sname test --cookie testcookie --remsh testnode@hostname -e ":rpc.call(:testnode@hostname, Module, :function, [args])"
```

上述方法可以获取到shell,如果要断开的话，使用和本地的shell无什么两样，-e的参数在启动的时候，执行远程节点上的某个函数，使用-remsh, 远程节点的shell将会链接到本地，这时候操作和在远程的shell上几乎无区别。如果不使用，执行完命令后将会自动的返回本地shell,这个时候如果退出shell的话，也仅仅是本地shell退出，远程的不受影响，还在执行。 -e 中的参数由于是在本地shell执行的，如果要执行远程的函数的话，需要使用rpc调用。

如果不想要shell，但又想要执行远程命令，类似http的REST机制。可以使用 erlang的专用和shell等命令行交互的方式：

``` bash
/usr/local/lib/erlang/lib/erl_interface-*/bin/erl_call -sname test -c testcookie -name testnode@hostname -a 'Module, Function [args]'
```

注意对于elixir而言，Module应该为Elixir开头的，比如本地的Module为A， 则在上述的命令中，Module应该为Elixir.A
