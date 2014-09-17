Yuetai.Views.Articles ||= {}

class Yuetai.Views.Articles.IndexView extends Yuetai.Views.Base
  el: $('#main-content')

  render: ->
    # @rm_nav()
    # @clearMsg()
    @render_nav(@opts.section)
    @$el.html(_.template($('#t-articles-index').html())())
    @articles.each(@renderArticle, @)

  renderArticle: (article)->
    snip = @strip(article.get('body'))
    if article.get('body').length >= 300
      snip = @strip(article.get('body')).substr(0,300)
      snip = snip.concat('...')
    $('#articles-items').append(_.template($('#t-article-item').html())(
      {
        article: article.toJSON(), article_snip: snip
      }
    ))
