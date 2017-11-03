<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [问题1： 类变量默认为null](#问题1：-类变量默认为null)

<!-- markdown-toc end -->


# 问题1： 类变量默认为null
程序中的部分java代码使用动态加载的方式，如果仅使用lib引用最终工程的方式，不会有任何问题;如果使用引用项目源代码工程的话，则在使用过程中，有些类变量表现为全都是未初始化，有些却不是。

最后调查的结果是，动态加载的代码和引用源代码中的类相同造成的，最终导致内存中存在同一个类的多份定义，java虚拟机在使用时，几份同时使用，造成最终类变量表现异常
