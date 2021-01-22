json.array! @posts do |post|
  json.id post.id
  json.content post.content
  json.created_at post.created_at
  json.image url_for(post.image)
end
