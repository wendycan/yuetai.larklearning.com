Yuetai.Views.Articles ||= {}

class Yuetai.Views.Articles.ShowView extends Yuetai.Views.Base
  el: $('#main-content')

  render: ->
    # @rm_nav()
    # @clearMsg()
    @render_nav(@opts.section)
    @article = @articles.get(@opts.article_id)
    author = @authors.get(@article.get('author_id'))
    tag = @tags.get(@article.get('node_id'))
    # @article.set('created_at', @handleDate(@article.get('created_at')))
    @$el.html(_.template($('#t-article-show').html())({
      article: @article.toJSON()
      author: author.toJSON()
      tag: tag.toJSON()
    }))
