json.id @post.id
json.content @post.content
json.reply_to @post.reply_to
json.replied_count @post.replied_count
json.created_at @post.created_at
if @post.image.attached?
  json.image url_for(@post.image)
end
json.set! :user do
  json.id current_user.id
  json.name current_user.username
  json.set! :profile do
    json.nickname current_user.profile.nickname
    if current_user.profile.icon.attached?
      json.icon url_for(current_user.profile.icon)
    end
  end
end
