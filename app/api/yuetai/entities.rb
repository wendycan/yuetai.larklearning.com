module Yuetai
  module Entities
    class Blog < Grape::Entity
      expose :id, :title, :body, :tag_list, :template, :language
    end

    class User < Grape::Entity
      expose :username, :desc, :github, :webchat, :email, :avator, :level
    end

  end
end
