json.set! :user do
  if signed_in?
    json.username current_user.username
  else
    json.username ''
  end
end