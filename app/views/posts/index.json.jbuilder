json.set! :posts do
  json.array! @posts do |post|
    json.id post.id
    json.username post.user.username
    json.content post.content
    json.created_at post.created_at
    if post.image.attached?
      json.image url_for(post.image)
    end
  end
end
json.set! :currentuser do
  json.name current_user.username
end
