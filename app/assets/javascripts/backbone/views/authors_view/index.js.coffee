Yuetai.Views.Authors ||= {}

class Yuetai.Views.Authors.IndexView extends Yuetai.Views.Base
  el: $('#main-content')

  render: ->
    # @rm_nav()
    # @clearMsg()
    @$el.html(_.template($('#t-authors-index').html())())
    @authors.each(@renderAuthor, @)

  renderAuthor: (author)->
    $('#author-items').append(_.template($('#t-author-item').html())(author: author.toJSON()))
