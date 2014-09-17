Yuetai.Views.Books ||= {}

class Yuetai.Views.Books.ShowView extends Yuetai.Views.Base
  el: $('#main-content')

  render: ->
    # @rm_nav()
    # @clearMsg()
    @render_nav(@opts.section)
    @book = @books.get(@opts.book_id)
    @$el.html(_.template($('#t-book-show').html())(book: @book.toJSON()))