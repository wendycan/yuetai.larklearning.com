class Yuetai.Routers.Engines extends Backbone.Router
  routes:
    '' : 'index'
    '!/books' : 'index_books'
    '!/books/:id' : 'show_book'

    '!/articles' : 'index_articles'
    '!/articles/:id' : 'show_article'

  initialize: ->
    @articles = new Yuetai.Collections.Articles()

  # index : ->
  #   opts =
  #     calevel: 'articles'
  #   @index_view.undelegateEvents() if @index_view
    # @index_view = new Yuetai.Views.Site.IndexView(@, opts)
