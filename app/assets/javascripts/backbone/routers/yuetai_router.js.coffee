class Yuetai.Routers.Engines extends Backbone.Router
  routes:
    '' : 'index'
    'books' : 'index_books'
    'books/:id' : 'show_book'

    'articles' : 'index_articles'
    'authors' : 'index_authors'
    'tags' : 'index_nodes'

  initialize: ->
    @books = new Yuetai.Collections.Books()

  index : ->
    console.log 'index'

  index_books: ->
    opts =
      section: 'books'
      calevel: 'books'
    @books_view.undelegateEvents() if @books_view
    @books_view = new Yuetai.Views.Books.IndexView(@, opts)

  show_book: (book_id)->
    opts =
      section: 'books'
      calevel: 'books'
      book_id: book_id
    @book_view.undelegateEvents() if @book_view
    @book_view = new Yuetai.Views.Books.ShowView(@, opts)

  # engine_install: (engine_name)->
  #   opts =
  #     engine_name: engine_name
  #     section: 'install'
  #   @install_view.undelegateEvents() if @install_view
  #   @install_view = new TinySou.Views.Engine.InstallView(@, opts)

  # engine_overview: (engine_name)->
  #   opts =
  #     calevel: 'engines'
  #     engine_name: engine_name
  #     section: 'overview'
  #   @overview_view.undelegateEvents() if @overview_view
  #   @overview_view = new TinySou.Views.Engine.OverviewView(@, opts)

  # engine_docs: (engine_name)->
  #   opts =
  #     calevel: 'documents'
  #     engine_name: engine_name
  #     section: 'crawler'
  #   @docs_view.undelegateEvents() if @docs_view
  #   @docs_view = new TinySou.Views.Documents.IndexView(@, opts)

  # engine_doc: (engine_name, doc_id)->
  #   opts =
  #     calevel: 'documents'
  #     engine_name: engine_name
  #     document_id: doc_id
  #     section: 'crawler'
  #   @doc_view.undelegateEvents() if @doc_view
  #   @doc_view = new TinySou.Views.Documents.ShowView(@, opts)
