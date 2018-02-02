module EnumI18nHelp
  module EnumI18n
    def enum(definitions)
      super(definitions)
      definitions.each do |key, value|
        EnumAttribute.define_text_method!(self, key)
        EnumAttribute.define_options_method!(self, key, value)
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

      def define_options_method!(klass, attr_name, attr_value)
        attr_value_hash = attr_value.keys.map { |key| [key, key.to_s.humanize] }.to_h

        klass.instance_eval <<-METHOD, __FILE__, __LINE__ + 1
        def #{attr_name}_options
          #{attr_value_hash}.merge((I18n.t "activerecord.attributes.#{klass.name.underscore}/#{attr_name}").reject{ |_, v| v.nil? }).invert.to_a
        end
        METHOD
      end
    end
  end
end
