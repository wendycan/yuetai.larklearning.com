class TinySou.Routers.Engines extends Backbone.Router
  routes:
    '' : 'home'
    'books' : 'index_books'
    'articles' : 'index_articles'
    'authors' : 'index_authors'
    'tags' : 'index_nodes'

  initialize: ->
    @engines = new TinySou.Collections.Engines()
    @account = new TinySou.Models.Account()

  index_engines: ->
    opts =
      calevel: 'engines'
    @engines_view.undelegateEvents() if @engines_view
    @engines_view = new TinySou.Views.Engines.IndexView(@, opts)

  new_engine: ->
    opts =
      calevel: 'engines'
    @new_engine_view.undelegateEvents() if @new_engine_view
    @new_engine_view = new TinySou.Views.Engines.NewView(@, opts)

  engine_install: (engine_name)->
    opts =
      calevel: 'engines'
      engine_name: engine_name
      section: 'install'
    @install_view.undelegateEvents() if @install_view
    @install_view = new TinySou.Views.Engine.InstallView(@, opts)

  engine_overview: (engine_name)->
    opts =
      calevel: 'engines'
      engine_name: engine_name
      section: 'overview'
    @overview_view.undelegateEvents() if @overview_view
    @overview_view = new TinySou.Views.Engine.OverviewView(@, opts)

  engine_analytics: (engine_name)->
    opts =
      calevel: 'engines'
      engine_name: engine_name
      section: 'analytics'
    @analytics_view.undelegateEvents() if @analytics_view
    @analytics_view = new TinySou.Views.Engine.AnalyticsView(@, opts)

  engine_docs: (engine_name)->
    opts =
      calevel: 'documents'
      engine_name: engine_name
      section: 'crawler'
    @docs_view.undelegateEvents() if @docs_view
    @docs_view = new TinySou.Views.Documents.IndexView(@, opts)

  engine_doc: (engine_name, doc_id)->
    opts =
      calevel: 'documents'
      engine_name: engine_name
      document_id: doc_id
      section: 'crawler'
    @doc_view.undelegateEvents() if @doc_view
    @doc_view = new TinySou.Views.Documents.ShowView(@, opts)

  engine_manage: (engine_name)->
    opts =
      calevel: 'domains'
      engine_name: engine_name
      section: 'manage'
    @domains_view.undelegateEvents() if @domains_view
    @domains_view = new TinySou.Views.Domains.IndexView(@, opts)

  engine_domain: (engine_name, domain_id)->
    opts =
      calevel: 'domains'
      engine_name: engine_name
      domain_id: domain_id
      section: 'crawler'
    @domain_view.undelegateEvents() if @domain_view
    @domain_view = new TinySou.Views.Domains.ShowView(@, opts)

  engine_domain_new: (engine_name)->
    opts =
      calevel: 'domains'
      engine_name: engine_name
      section: 'crawler'
    @domain_new_view.undelegateEvents() if @domain_new_view
    @domain_new_view = new TinySou.Views.Domains.NewView(@, opts)
