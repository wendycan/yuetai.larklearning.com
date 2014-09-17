Yuetai.Views.Site ||= {}

class Yuetai.Views.Site.IndexView extends Yuetai.Views.Base
  el: $('#main-content')

  render: ->
    # @rm_nav()
    # @clearMsg()
    @$el.html(_.template($('#t-index').html())())
    @books.each(@renderBook, @)

  renderBook: (book)->
    $('#items').append(_.template($('#t-book-item').html())(book: book.toJSON()))

  renderArticle: (article)->
    $('#items').append(_.template($('#t-article-item').html())(article: article.toJSON()))
