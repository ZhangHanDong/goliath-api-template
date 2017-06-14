json.status 0
json.user do
  json.id @user.id
  json.name @user.name
  json.custom_service (@user.custom_service? ? 0 : 1)
  json.allowed_comments (@user.allowed?(:comments) ? 0 : 1)
  json.allowed_posts (@user.allowed?(:posts) ? 0 : 1)
end
json.access_token @access_token
json.refresh_token @refresh_token
json.scopes 'all'
json.provider "local_app"
