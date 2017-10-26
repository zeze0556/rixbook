# Emacs

我在用emacs,好多年，但其实， 我是个vimer,我总想不起emacs原生的编辑快捷键

我用vim好多年，但其实，大部分时候，我都是在emacs中，除了基本的编辑命令，我不记得vim的其他命令

## 重定义emacs的.emacs.d
我比较讨厌emacs默认的配置文件的格式，在想要配置的时候总是不好找

```emacs-lisp
(setq user-emacs-directory "emacs_config")
```

## 启动配置
我很喜欢使用org-mode来作为emacs初始化时的配置， 这样可以将文档，代码放到同一个文件，并且可以生成好看的文档。只需要在.emacs中添加一句话即可解决.
```emacs-lisp
(org-babel-load-file (expand-file-name "tips.org" user-emacs-directory)) [//]: <> (我自定义了目录)

```
