json.set! :currentuser do
  json.id current_user.id
  json.name current_user.username
  json.set! :profile do
    json.nickname current_user.profile.nickname
    if current_user.profile.icon.attached?
      json.icon url_for(current_user.profile.icon)
    end
  end
end