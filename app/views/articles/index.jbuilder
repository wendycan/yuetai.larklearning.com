json.array! @articles do |article|
  json.id article.id
  json.title article.title
  json.body article.body
  json.username article.user.username
  json.tag_list article.tag_list
  json.language article.language
  json.created_at article.created_at
  json.visited_count article.visited_count
end
