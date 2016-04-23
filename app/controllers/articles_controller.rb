class ArticlesController < ApplicationController
  def index
    @articles = Article.order('created_at DESC').where(template: 'blog').paginate(:page => params[:page], :per_page => 10)
    @authors = User.joins('JOIN (select count(id) alength, user_id from articles a group by a.user_id ) ac on ac.user_id = users.id').order('ac.alength desc').limit(5)
    @tags = Tag.joins('LEFT JOIN (select count(id) alength, tag_id from taggings a group by a.tag_id ) ac on ac.tag_id = tags.id').order('ac.alength desc')
  end

  def show
    @blog = Article.find_by_id(params[:id])
    @user = @blog.user
    @blog.visited_count += 1
    @blog.save
  end
end
