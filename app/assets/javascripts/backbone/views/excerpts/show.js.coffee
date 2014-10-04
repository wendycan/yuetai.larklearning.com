Yuetai.Views.Excerpts ||= {}

class Yuetai.Views.Excerpts.ShowView extends Yuetai.Views.Base
  el: $('#main-content')

  render: ->
    # @rm_nav()
    # @clearMsg()
    book = @books.get(@opts.book_id)
    excerpts = book.excerpts()
    @render_nav(@opts.section)
    if excerpts.length > 0
      excerpt = excerpts.get(@opts.excerpt_id)
      author = @authors.get(excerpt.get('author_id'))
      @$el.html(_.template($('#t-excerpt-show').html())({
        excerpt: excerpt.toJSON()
        book: book.toJSON()
        author: author.toJSON()
      }))
    else
      @$el.html('<h3>empty</h3>')
