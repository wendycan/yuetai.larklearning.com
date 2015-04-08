json.array! @presentations do |presentation|
  json.id presentation.id
  json.title presentation.title
  json.body presentation.body
  json.username presentation.user.username
  json.tag presentation.tag
  json.language presentation.language
  json.created_at presentation.created_at
end
