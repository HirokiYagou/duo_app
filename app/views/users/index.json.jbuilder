json.set! :user do
  if signed_in?
    json.username current_user.username
  else
    json.username ''
  end
end
json.set! :assets do
  json.duo image_path('duo.jpg')
  json.book image_path('book.png')
  json.heart image_path('heart_welcome.png')
  json.hayashi image_path('mangrove_hayashi.png')
  json.study image_path('study.png')
  json.kaso image_path('fukei_mura_kaso.png')
end