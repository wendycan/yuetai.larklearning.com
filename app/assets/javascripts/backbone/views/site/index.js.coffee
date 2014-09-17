Yuetai.Views.Site ||= {}

class Yuetai.Views.Site.IndexView extends Yuetai.Views.Base
  el: $('#main-content')

  render: ->
    # @rm_nav()
    # @clearMsg()
    @$el.html(_.template($('#t-index').html())())
    # @books.each(@renderBook, @)
    @articles.each(@renderArticle, @)

  renderBook: (book)->
    $('#items').append(_.template($('#t-book-item').html())(book: book.toJSON()))

  renderArticle: (article)->
    snip = @strip(article.get('body'))
    if article.get('body').length >= 300
      snip = @strip(article.get('body')).substr(0,300)
      snip = snip.concat('...')
    $('#items').append(_.template($('#t-article-item').html())(
      {
        article: article.toJSON(), article_snip: snip
      }
    ))
