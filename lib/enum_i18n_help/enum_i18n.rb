module EnumI18nHelp
  module EnumI18n
    def enum(definitions)
      super(definitions)
      # super has defined enum.
      # So defined_enums are available!
      #
      # To avoid defining methods multiple times,
      # slices hash to get enums called this time.
      #
      # Be careful not to destroy defined_enum, such as using merge!
      defined_enums.slice(*definitions.keys.map(&:to_s)).each_pair do |key, value|
        EnumAttribute.define_text_method!(self, key)
        EnumAttribute.define_options_method!(self, key, value.symbolize_keys)
      end
    end
  end

  class EnumAttribute
    class << self

      def define_text_method!(klass, enum_key)
        klass.class_eval <<-METHOD, __FILE__, __LINE__ + 1
        def #{enum_key}_text
          I18n.t "activerecord.attributes.#{klass.name.underscore}/#{enum_key}." + #{enum_key}, default: #{enum_key}.humanize
        end
        METHOD
      end

      # This method assume that attr_value is a symbolized hash
      def define_options_method!(klass, attr_name, attr_value)
        attr_value_hash = attr_value.keys.map { |key| [key, key.to_s.humanize] }.to_h

        klass.instance_eval <<-METHOD, __FILE__, __LINE__ + 1
        def #{attr_name}_options
          locale_definitions = I18n.t("activerecord.attributes.#{klass.name.underscore}/#{attr_name}")

          #{attr_value_hash}
            .merge(locale_definitions.reject{ |k, v| v.nil? || #{attr_value.keys}.exclude?(k.to_sym) })
            .invert
            .to_a
        end
        METHOD
      end
    end
  end
end
