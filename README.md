# EnumI18nHelp

Help ActiveRecord::Enum feature to work with I18n.

added a new Test::Unit to the existing EnumHelp gem and changed the namespace of I18n.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'enum_i18n_help'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install enum_i18n_help

## Usage

model

```ruby
class User < ActiveRecord::Base
  enum role: { manager: 1, member: 2 }
end
```

I18n

```ruby
ja:
  activerecord:
    attributes:
      user/role:
        manager: 管理者
        member: 一般
```

```ruby
en:
  activerecord:
    attributes:
      user/role:
        manager: Manager
        member: Member
```

### enum_column_text

```ruby
user = User.first
user.role
=> "manager"
user.role_text
=> "管理者"
```

change locale

```ruby
I18n.locale = :en
user.role
=> "manager"
user.role_text
=> "Manager"
```

### enum_column_options

```ruby
User.role_options
=> [["管理者", :manager], ["一般", :member]]
```

## Contributing

1. Fork it ( https://github.com/ShuheiTsuji/enum_i18n_help )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
