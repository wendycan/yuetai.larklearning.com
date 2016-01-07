json.array! @blogs do |blog|
  json.id blog.id
  json.title blog.title
  json.body blog.body
  json.username blog.user.username
  json.tag blog.tag_list
  json.language blog.language
  json.created_at blog.created_at
  json.visited_count blog.visited_count
end
