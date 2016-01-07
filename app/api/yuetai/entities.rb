module Yuetai
  module Entities
    class Blog < Grape::Entity
      expose :id, :title, :body, :tag_list, :template, :language
    end
  end
end
