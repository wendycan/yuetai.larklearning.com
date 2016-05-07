module Yuetai
  module Entities
    class Blog < Grape::Entity
      expose :id, :title, :body, :tag_list, :template, :language, :visited_count, :created_at
    end

    class User < Grape::Entity
      expose :id, :username, :desc, :github, :webchat, :email, :avator, :level, :created_at
      expose :articles_count

      private
      def articles_count
        object.articles.length
      end
    end

    class Tag < Grape::Entity
      expose :name, :created_at, :articles, :id
    end

    class Comment < Grape::Entity
      expose :id, :text, :user_id, :created_at
      expose :avator
      expose :username

      private
      def avator
        ::User.all.find(object.user_id).avator
      end

      def username
        ::User.all.find(object.user_id).username
      end
    end

  end
end
