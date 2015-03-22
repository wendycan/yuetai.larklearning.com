json.array! @blogs do |blog|
  json.extract! blog, :id, :title, :body, :user, :tag, :language
end
