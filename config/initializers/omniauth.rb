require 'omniauth/openid'
require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do
  openid_filesystem = OpenID::Store::Filesystem.new(Rails.root.join('tmp', 'openid'))
  provider :open_id, openid_filesystem, name: 'open_id'
end
