<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [PHP](#php)
    - [laravel](#laravel)
        - [输出数据库执行语句](#输出数据库执行语句)
        - [关于redis](#关于redis)

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

### 关于redis
  Class redis does not exist
  在 bootstrap/app.php 添加
```php
$app->register(\Illuminate\Redis\RedisServiceProvider::class);
```
在composer.json 中添加
```
"predis/predis": "^1.1",
"illuminate/redis": "^5.3",
```
