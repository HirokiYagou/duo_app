json.id @post.id
json.content @post.content
json.created_at @post.created_at
if @post.image.attached?
  json.image url_for(@post.image)
end
json.set! :user do
  json.id current_user.id
  json.name current_user.username
  json.nickname current_user.profile.nickname
end
