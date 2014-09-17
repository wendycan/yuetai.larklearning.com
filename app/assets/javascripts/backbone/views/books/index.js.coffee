Yuetai.Views.Books ||= {}

class Yuetai.Views.Books.IndexView extends Yuetai.Views.Base
  el: $('#main-content')

  render: ->
    # @rm_nav()
    # @clearMsg()
    @render_nav(@opts.section)
    @$el.html(_.template($('#t-books-index').html())())
    @books.each(@renderBook, @)

  renderBook: (book)->
    $('#book-items').append(_.template($('#t-book-item').html())(book: book.toJSON()))
