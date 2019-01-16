# DiscourseIntegralStatistic

DiscourseIntegralStatistic is a plugin for ...

## Installation

Follow [Install a Plugin](https://meta.discourse.org/t/install-a-plugin/19157)
how-to from the official Discourse Meta.

- clone plugin sources in discourse/plugins directory
```
$ git clone https://github.com/zhaohongguang/discourse-integral-statistic.git
```

- execute datebase migration
```
$ bundle exec rake db:migrate RAILS_ENV=[production or development or test]
```

- if nessesary, execute assets precompile
```
$ bundle exec rake assets:precompile RAILS_ENV=production
```

- start server and enjoy calendar plugin.

## Usage

## Feedback

If you have issues or suggestions for the plugin, please bring them up on
[Discourse Meta](https://meta.discourse.org).
