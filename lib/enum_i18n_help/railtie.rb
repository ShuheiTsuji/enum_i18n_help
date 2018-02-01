module EnumI18nHelp
  class Railtie < Rails::Railtie
    initializer "enum_i18n_help.i18n" do
      ActiveSupport.on_load(:active_record) do
        extend EnumI18nHelp::EnumI18n
      end
    end
  end
end
