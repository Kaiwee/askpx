  Rails.application.config.middleware.use OmniAuth::Builder do
  	provider :facebook, ENV['FACEBOOK_APP_KEY'], ENV['FACEBOOK_APP_SECRET'], scope: "public_profile, email", info_fields: "name, email, picture", secure_image_url: true
  end