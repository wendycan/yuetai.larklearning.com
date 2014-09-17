Yuetai.Views.Articles ||= {}

class Yuetai.Views.Articles.IndexView extends Yuetai.Views.Base
  el: $('#main-content')

  render: ->
    # @rm_nav()
    # @clearMsg()
    @$el.html(_.template($('#t-articles-index').html())())
    @articles.each(@renderArticls, @)

  renderArticls: (articls)->
    $('#articls-items').append(_.template($('#t-articls-item').html())(articls: articls.toJSON()))
