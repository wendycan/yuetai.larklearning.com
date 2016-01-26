module Yuetai
  module Entities
    class Blog < Grape::Entity
      expose :id, :title, :body, :tag_list, :template, :language, :visited_count, :created_at
    end

    class User < Grape::Entity
      expose :username, :desc, :github, :webchat, :email, :avator, :level
    end

    class Tag < Grape::Entity
      expose :name, :created_at, :articles, :id
    end

  end
end
