<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [Emacs](#emacs)
    - [spacemacs 长时间运行无响应](#spacemacs-长时间运行无响应)
    - [win10 使用emacs建议](#win10-使用emacs建议)
        - [dbus-xxfluS2Izg错误](#dbus-xxflus2izg错误)
    - [重定义emacs的.emacs.d](#重定义emacs的emacsd)
    - [启动配置](#启动配置)
    - [相关配置生成文件的位置](#相关配置生成文件的位置)
    - [spacemacs配置](#spacemacs配置)
    - [org-mode](#org-mode)
        - [org babel 执行代码](#org-babel-执行代码)
        - [org 导出pdf](#org-导出pdf)
    - [markdown-mode](#markdown-mode)
    - [编程](#编程)
        - [smart 编译，自动查找 makefile](#smart-编译自动查找-makefile)

<!-- markdown-toc end -->


# Emacs

我在用emacs,好多年，但其实， 我是个vimer,我总想不起emacs原生的编辑快捷键

我用vim好多年，但其实，大部分时候，我都是在emacs中，除了基本的编辑命令，我不记得vim的其他命令

## spacemacs 长时间运行无响应
只是尝试,不一定可以解决
``` emacs-lisp
(setq history-length 100)
(put 'minibuffer-history 'history-length 50)
(put 'evil-ex-history 'history-length 50)
(put 'kill-ring 'history-length 25)
```

## win10 使用emacs建议

个人推荐使用wsl，win10 1709版本支持的很好

使用Xming 而不是 vcxsrv, 我使用vcxsrv, 结果emacs25在打开xming第一次可以正常显示,以后一直是空白的,不显示任何字符,emacs27(emacs-snapshot)无法窗口最大化,窗口最大化后,显示的范围还是刚开始启动时的范围.Xming版本 6.9.0.31 则无论哪种版本都很正常. 

### dbus-xxfluS2Izg错误

Failed to connect to socket /tmp/dbus-xxfluS2Izg: Connection refused

``` bash
export NO_AT_BRIDGE=1
export LIBGL_ALWAYS_INDIRECT=1
```

## 重定义emacs的.emacs.d
我比较讨厌emacs默认的配置文件的格式，在想要配置的时候总是不好找

```emacs-lisp
(setq user-emacs-directory "emacs_config")
```

## 启动配置
我很喜欢使用org-mode来作为emacs初始化时的配置， 这样可以将文档，代码放到同一个文件，并且可以生成好看的文档。只需要在.emacs中添加一句话即可解决. [//]: <> (我自定义了目录)
```emacs-lisp
(org-babel-load-file (expand-file-name "tips.org" user-emacs-directory)) 

```
### tern 找不到

``` bash
sudo npm -g tern
```
ubuntu 还需要

``` bash
sudo ln -s /usr/bin/nodejs /usr/bin/node
```
### source code pro 字体

``` bash
#!/bin/bash
set  -euo pipefail
I1FS=$'\n\t'
mkdir -p /tmp/adodefont
cd /tmp/adodefont
wget -q --show-progress -O source-code-pro.zip https://github.com/adobe-fonts/source-code-pro/archive/2.030R-ro/1.050R-it.zip
unzip -q source-code-pro.zip -d source-code-pro
mkdir -p ~/.fonts
cp -v source-code-pro/*/OTF/*.otf ~/.fonts/
fc-cache -f
rm -rf source-code-pro{,.zip}
```

## 相关配置生成文件的位置
当更改了.emacs.d的位置后，不同的主机使用同一份配置，在有同步的情况下，容易发生冲突，因此，将相关内容换个位置
``` emacs-lisp
(setq locate-user-emacs-directory "~/.emacs.d")
(setq server-auth-dir "~/.emacs.d/server")
```

## spacemacs配置
我在用evil好多年之后，现在切换成了spacemacs, 但我还想用org-mode来做初始化文件
```emacs-lisp
(setq dotspacemacs-configuration-layer-path "~/emacs_config")
(setq recentf-save-file (expand-file-name "recentf" "~/.emacs.d"))
(setq dotspacemacs-elpa-https nil)
(setq dotspacemacs-check-for-update nil)
(setq package-user-dir (concat user-emacs-directory "/elpa"))
(setenv "SPACEMACSDIR" user-emacs-directory)
(setq spacemacs-start-directory (concat user-emacs-directory "/spacemacs/"))
(load-file (concat spacemacs-start-directory "init.el"))
```

## org-mode
### org babel 执行代码

``` emacs-lisp
(with-eval-after-load 'org
    (setq org-confirm-babel-evaluate nil) ; 执行代码取消确认
    (setq org-bullets-bullet-list '("■" "◆" "▲" "▶")) ; 比默认的太阳星星好些
    (org-babel-do-load-languages
     'org-babel-load-languages
     '((emacs-lisp . t)
       (ruby . t)
       (sql . t)
       (C . t)
       (ditaa . t)
       (makefile . t)
       (js . t)
       (elixir . t)
       (translate . t)
       (http . t)
       (python . t)
       (sh . t)
       (shell . t)
       (latex . t)
       (php . t)
       (plantuml . t)
       (R . t)))
    )
```

### org 导出pdf
windows 使用 ctex 生成 pdf
```emacs-lisp
(setq org-latex-compiler "xelatex")
(setq org-latex-default-class "ctexart")
(unless (boundp 'org-latex-classes) (setq org-latex-classes nil))
(add-to-list 'org-latex-classes
             '("ctexart"
               "\\documentclass[fancyhdr,fntef,UTF8,a4paper,cs4size]{ctexart}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
(add-to-list 'org-latex-classes
             '("ctexrep"
               "\\documentclass[fancyhdr,fntef,UTF8,a4paper,cs4size]{ctexrep}"
               ("\\part{%s}" . "\\part*{%s}")
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))
(add-to-list 'org-latex-classes
             '("ctexbook"
               "\\documentclass[fancyhdr,fntef,UTF8,a4paper,cs4size]{ctexbook}"
               ("\\part{%s}" . "\\part*{%s}")
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))
(add-to-list 'org-latex-classes
             '("beamer"
               "\\documentclass{beamer}
           \\usepackage[fntef,nofonts,fancyhdr]{ctex}"
               org-beamer-sectioning))
```


## markdown-mode

emacs 的markdown模式太好用了。我再也不用一个一个的输入原生的markdownu语法了。

## 编程
### smart 编译，自动查找 makefile
并不是 smartcompile 插件, 绑定快捷键之后爽歪歪啊
```emacs-lisp
(defun smart-compile-is-root-dir(try-dir)
  (or
   ;; windows root dir for a driver or Unix root
   (string-match "\\`\\([a-zA-Z]:\\)?/$" try-dir)
   ;; tramp root-dir
   (and (featurep 'tramp)
        (string-match (concat tramp-file-name-regexp ".*:/$") try-dir))))

(defun smart-compile-throw-final-path(try-dir)
  (cond
   ;; tramp root-dir
   ((and (featurep 'tramp)
         (string-match tramp-file-name-regexp try-dir))
    (with-parsed-tramp-file-name try-dir foo
        foo-localname))
   (t try-dir)))

(defun smart-compile-find-make-dir( try-dir)
  "return a directory contain makefile. try-dir is absolute path."
  (if (smart-compile-is-root-dir try-dir)
      nil ;; return nil if failed to find such directory.
    (let ((candidate-make-file-name '("GNUmakefile" "makefile" "Makefile")))
      (or (catch 'break
            (mapc (lambda (f)
                    (if (file-readable-p (concat (file-name-as-directory try-dir) f))
                        (throw 'break (smart-compile-throw-final-path try-dir))))
                  candidate-make-file-name)
            nil)
          (smart-compile-find-make-dir
           (expand-file-name (concat (file-name-as-directory try-dir) "..")))))))

(defun wcy-tramp-compile (arg-cmd)
  "reimplement the remote compile."
  (interactive "scompile:")
  (with-parsed-tramp-file-name default-directory foo
    (let* ((key (format "/plink:%s@%s:" foo-user foo-host))
           (passwd (password-read "PASS:" key))
           (cmd (format "plink %s -l %s -pw %s \"(cd %s ; %s)\""
                         foo-host foo-user
                         passwd
                         (file-name-directory foo-localname)
                         arg-cmd)))
      (password-cache-add key passwd)
      (save-some-buffers nil nil)
      (compile-internal cmd "No more errors")
      ;; Set comint-file-name-prefix in the compilation buffer so
      ;; compilation-parse-errors will find referenced files by ange-ftp.
      (with-current-buffer compilation-last-buffer
        (set (make-local-variable 'comint-file-name-prefix)
             (format "/plink:%s@%s:" foo-user foo-host))))))

(defun smart-compile-test-tramp-compile ()
  (or (and (featurep 'tramp)
           (string-match tramp-file-name-regexp (buffer-file-name))
           (progn
             (if (not (featurep 'tramp-util)) (require 'tramp-util))
             'wcy-tramp-compile))
      'compile))
(defun smart-compile-get-local-file-name (file-name)
  (if (and
       (featurep 'tramp)
       (string-match tramp-file-name-regexp file-name))
      (with-parsed-tramp-file-name file-name foo
        foo-localname)
    file-name))
(defun smart-compile ()
  (interactive)
  (let* ((compile-func (smart-compile-test-tramp-compile))
         (dir (smart-compile-find-make-dir (expand-file-name "."))))
    (funcall compile-func
             (if dir
                 (concat "make -C " dir (if (eq compile-func 'tramp-compile) "&" ""))
               (concat
                (cond
                 ((eq major-mode 'c++-mode) "g++ -g -o ")
                 ((eq major-mode 'c-mode) "gcc -g -o "))
                (smart-compile-get-local-file-name (file-name-sans-extension
             (buffer-file-name)))
                " "
                (smart-compile-get-local-file-name (buffer-file-name)))))))
;;smart end
(global-set-key [f7] 'smart-compile)

```

### 打开大文件
spacemacs打开大文件真的很慢，而且经常卡死，本来wsl就慢，大文件就更慢了。用SPC f l (find-file-literally)打开就超级快了， 缺点就是中文等显示有问题
