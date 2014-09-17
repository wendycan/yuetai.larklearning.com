Yuetai.Views.Articles ||= {}

class Yuetai.Views.Articles.IndexView extends Yuetai.Views.Base
  el: $('#main-content')

  render: ->
    # @rm_nav()
    # @clearMsg()
    @$el.html(_.template($('#t-articles-index').html())())
    @articles.each(@renderArticles, @)

  renderArticles: (articles)->
    $('#articles-items').append(_.template($('#t-articles-item').html())(articles: articles.toJSON()))
