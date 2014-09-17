Yuetai.Views.Articles ||= {}

class Yuetai.Views.Articles.ShowView extends Yuetai.Views.Base
  el: $('#main-content')

  render: ->
    # @rm_nav()
    # @clearMsg()
    @article = @articles.get(@opts.article_id)
    @$el.html(_.template($('#t-article-show').html())(article: @article.toJSON()))
