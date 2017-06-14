json.status 0
# 可用缓存
json.json_cache [@user, @cache_key, params[:page].to_i], env: env do
  json.users @users do |user|
    json.id user.id
    json.avatar user.avatar
    json.name user.name
    json.reviews_count user.reviews_count
    json.followers_count user.followers_count
  end
end
