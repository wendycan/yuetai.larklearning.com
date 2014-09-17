Yuetai.Views.Books ||= {}

class Yuetai.Views.Books.IndexView extends Yuetai.Views.Base
  el: $('#main-content')

  render: ->
    # @rm_nav()
    # @clearMsg()
    @$el.html(_.template($('#t-books-index').html())())
    @books.each(@renderBook, @)

  renderBook: (book)->
    $('#book-items').append(_.template($('#t-book-item').html())(book: book.toJSON()))
