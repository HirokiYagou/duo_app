json.id @post.id
json.username current_user.username
json.nickname current_user.profile.nickname
json.content @post.content
json.created_at @post.created_at
if @post.image.attached?
  json.image url_for(@post.image)
end
