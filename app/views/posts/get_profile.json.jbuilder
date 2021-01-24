json.status @profile.status
if @profile.header.attached?
  json.header url_for(@profile.header)
end