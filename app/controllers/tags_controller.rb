class TagsController < ApplicationController
  def show
    @tag = Tag.find_by_id(params[:id])
    @tags = Tag.joins('LEFT JOIN (select count(id) alength, tag_id from taggings a group by a.tag_id ) ac on ac.tag_id = tags.id').order('ac.alength desc')
    @articles = @tag.articles.order('created_at DESC')
      .where(template: 'blog').paginate(:page => params[:page], :per_page => 10)
  end
end
