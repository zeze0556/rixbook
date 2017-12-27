<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [PHP](#php)
    - [laravel](#laravel)
        - [输出数据库执行语句](#输出数据库执行语句)

<!-- markdown-toc end -->


# PHP

## laravel

### 输出数据库执行语句

``` php
\DB::listen(function($sql, $bindings, $time) {
            var_dump($sql);
            var_dump($bindings);
            var_dump($time);
        });
```
