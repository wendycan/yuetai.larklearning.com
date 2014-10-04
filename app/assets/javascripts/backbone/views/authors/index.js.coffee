Yuetai.Views.Authors ||= {}

class Yuetai.Views.Authors.IndexView extends Yuetai.Views.Base
  el: $('#main-content')

  render: ->
    # @rm_nav()
    # @clearMsg()
    @render_nav(@opts.section)
    @$el.html(_.template($('#t-authors-index').html())())
    @authors.each(@renderAuthor, @)

  renderAuthor: (author)->
    snip = @strip(author.get('desc'))
    snip = @limit(snip, 300)

    $('#author-items').append(_.template($('#t-author-item').html())({
      author: author.toJSON(),
      author_snip: snip
    }))
