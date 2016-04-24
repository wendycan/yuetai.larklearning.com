json.array! @comments do |comment|
  json.id comment.id
  json.text comment.text
  json.username comment.user.username
  json.avator comment.user.avator
  json.user_id comment.user.id
  json.created_at comment.created_at
end
