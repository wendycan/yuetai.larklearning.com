json.array! @blogs do |blog|
  json.id blog.id
  json.title blog.title
  json.body blog.body
  json.user blog.user.username
  json.tag blog.tag
  json.language blog.language
  json.created_at blog.created_at
end
