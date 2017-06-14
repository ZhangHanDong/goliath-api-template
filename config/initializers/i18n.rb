I18n.enforce_available_locales = false
I18n.load_path += Dir["#{Goliath.root}/config/locales/**/*.yml"]
I18n.default_locale = 'cn'
I18n.locale = 'cn'
I18n.reload!
