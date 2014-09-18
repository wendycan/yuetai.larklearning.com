Yuetai.Views.Articles ||= {}

class Yuetai.Views.Articles.ShowView extends Yuetai.Views.Base
  el: $('#main-content')

  render: ->
    # @rm_nav()
    # @clearMsg()
    @render_nav(@opts.section)
    @article = @articles.get(@opts.article_id)
    author = @authors.get(@article.get('author_id'))
    if author
      author = author.toJSON
    else
      author = ''
    @$el.html(_.template($('#t-article-show').html())({
      article: @article.toJSON()
      author: author
    }))
