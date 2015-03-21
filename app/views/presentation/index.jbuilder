json.array! @presentations do |presentation|
  json.extract! presentation, :id, :title, :body, :user, :tag, :language
end
