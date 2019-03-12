Recaptcha.configure do |config|
  config.site_key  = ENV['RECAPTCHA_ASKBYME_KEY']
  config.secret_key = ENV['RECAPTCHA_ASBKBYME_SECRET']
end
