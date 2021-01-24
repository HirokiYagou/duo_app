json.nickname @profile.nickname
json.status @profile.status
if @profile.icon.attached?
  json.icon url_for(@profile.icon)
end
if @profile.header.attached?
  json.header url_for(@profile.header)
end