require "enum_i18n_help/version"
require "active_support/lazy_load_hooks"

ActiveSupport.on_load :active_record do
  require "enum_i18n_help/enum_i18n"
  ActiveRecord::Base.extend EnumI18nHelp::EnumI18n
end

module EnumI18nHelp
  # Your code goes here...
end
