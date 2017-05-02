# AssInterface

This project rocks and uses MIT-LICENSE.

* 本项目为mountable类引擎项目，依赖于宿主项目而存在。
* 将此项目放置在宿主项目的vendor 目录下

## 配置：
>宿主config/routes.rb中添加：

```ruby
mount AssInterface::Engine => '/interface'
```

>宿主Gemfile中添加：

```ruby
gem 'ass_interface', path: './vendor/ass_interface'
```

>进入宿主文件夹下生成数据库迁移文件，运行：

```
$ rake ass_interface:install:migrations
$ rake db:migrate
```