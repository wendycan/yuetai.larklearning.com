class Yuetai.Routers.Engines extends Backbone.Router
  routes:
    '' : 'index'
    'books' : 'index_books'
    'books/:id' : 'show_book'

    # 'books/:id/excerpts' : 'index_excerpts'
    'books/:id/excerpts/:excerpt_id' : 'show_excerpt'

    'articles' : 'index_articles'
    'articles/:id' : 'show_article'

    'authors' : 'index_authors'
    'authors/:id' : 'show_author'

    'tags' : 'index_tags'
    'tags/:id' : 'show_tag'

  initialize: ->
    @books = new Yuetai.Collections.Books()
    @articles = new Yuetai.Collections.Articles()
    @tags = new Yuetai.Collections.Tags()
    @authors = new Yuetai.Collections.Authors()

  index : ->
    opts =
      calevel: 'articles'
    @index_view.undelegateEvents() if @index_view
    @index_view = new Yuetai.Views.Site.IndexView(@, opts)

  index_books: ->
    opts =
      section: 'books'
      calevel: 'books'
    @books_view.undelegateEvents() if @books_view
    @books_view = new Yuetai.Views.Books.IndexView(@, opts)

  show_book: (book_id)->
    opts =
      section: 'books'
      calevel: 'excerpts'
      book_id: book_id
    @book_view.undelegateEvents() if @book_view
    @book_view = new Yuetai.Views.Books.ShowView(@, opts)

  index_excerpts: (book_id)->
    opts =
      section: 'books'
      calevel: 'excerpts'
    @excerpts_view.undelegateEvents() if @excerpts_view
    @excerpts_view = new Yuetai.Views.Excerpts.IndexView(@, opts)

  show_excerpt: (book_id, excerpt_id)->
    opts =
      section: 'books'
      calevel: 'excerpts'
      book_id: book_id
      excerpt_id: excerpt_id
    @excerpt_view.undelegateEvents() if @excerpt_view
    @excerpt_view = new Yuetai.Views.Excerpts.ShowView(@, opts)

  index_articles: ->
    opts =
      section: 'articles'
      calevel: 'articles'
    @articles_view.undelegateEvents() if @articles_view
    @articles_view = new Yuetai.Views.Articles.IndexView(@, opts)

  show_article: (article_id)->
    opts =
      section: 'articles'
      calevel: 'articles'
      article_id: article_id
    @article_view.undelegateEvents() if @article_view
    @article_view = new Yuetai.Views.Articles.ShowView(@, opts)

  index_tags: ->
    opts =
      section: 'tags'
      calevel: 'tags'
    @tags_view.undelegateEvents() if @tags_view
    @tags_view = new Yuetai.Views.Tags.IndexView(@, opts)

  show_tag: (tag_id)->
    opts =
      section: 'tags'
      calevel: 'tags'
      tag_id: tag_id
    @tag_view.undelegateEvents() if @tag_view
    @tag_view = new Yuetai.Views.Tags.ShowView(@, opts)

  index_authors: ->
    opts =
      section: 'authors'
      calevel: 'authors'
    @authors_view.undelegateEvents() if @authors_view
    @authors_view = new Yuetai.Views.Authors.IndexView(@, opts)

  show_author: (author_id)->
    opts =
      section: 'authors'
      calevel: 'authors'
      author_id: author_id
    @author_view.undelegateEvents() if @author_view
    @author_view = new Yuetai.Views.Authors.ShowView(@, opts)

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
