json.id @post.id
json.username @post.user.username
json.content @post.content
json.created_at @post.created_at
json.image url_for(@post.image)
