Yuetai.Views.Books ||= {}

class Yuetai.Views.Books.ShowView extends Yuetai.Views.Base
  el: $('#main-content')

  render: ->
    # @rm_nav()
    # @clearMsg()
    @render_nav(@opts.section)
    @book = @books.get(@opts.book_id)
    @$el.html(_.template($('#t-book-show').html())(book: @book.toJSON()))
    excerpts = @book.excerpts()
    excerpts.each(@renderExcerpt, @)

   renderExcerpt: (excerpt)->
    snip = @limit(@strip(excerpt.get('body')), 300)
    $('#book-excerpts').append(_.template($('#t-book-excerpt').html())(excerpt: excerpt.toJSON(), excerpt_snip: snip, book_id: @book.id))
