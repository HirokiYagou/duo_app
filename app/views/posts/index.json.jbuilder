json.set! :posts do
  json.array! @posts do |post|
    json.id post.id
    json.content post.content
    json.reply_to post.reply_to
    if @reply_data[post.id]
      json.replied_count @reply_data[post.id]
    end
    if @favorite_data[post.id]
      json.favorite_count @favorite_data[post.id]
    end
    if !@post_ids.find{|n| n == post.id}.nil?
      json.is_favorite true
    end
    json.created_at post.created_at
    if post.image.attached?
      json.image url_for(post.image)
    end
    json.terms do
      json.array! post.terms, :id, :english
    end
    json.set! :user do
      json.id post.user_id
      json.name post.user.username
      json.set! :profile do
        json.nickname post.user.profile.nickname
        if post.user.profile.icon.attached?
          json.icon url_for(post.user.profile.icon)
        end
      end
    end
  end
end
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
json.set! :assets do
  json.menu_bar image_tag('bars_24.png')
  json.reply_icon image_tag('reply.png')
end
