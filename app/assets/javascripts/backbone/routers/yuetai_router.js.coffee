class Yuetai.Routers.Engines extends Backbone.Router
  routes:
    '' : 'index_blogs'

    'blogs' : 'index_blogs'
    'blogs/new' : 'new_blog'
    'blogs/:id' : 'show_blog'

    'series' : 'index_series'
    'series/new' : 'new_series'
    'series/:id' : 'show_series'

    'presentations' : 'index_presentations'
    'presentations/new' : 'new_presentation'
    'presentations/:id' : 'show_presentation'

    'settings' : 'show_settings'

  initialize: ->
    @account = new Yuetai.Models.Account()

  index_blogs: ->
    @blogs_view.undelegateEvents() if @blogs_view
    @blogs_view = new Yuetai.Views.Blogs.IndexView(@)

  new_blog: ->
    @blog_new_view.undelegateEvents() if @blog_new_view
    @blog_new_view = new Yuetai.Views.Blogs.NewView(@)

  show_blog: (id)->
    opts =
      blog_id: id
    @blog_view.undelegateEvents() if @blog_view
    @blog_view = new Yuetai.Views.Blogs.ShowView(@, opts)

  index_series: ->
    @series_view.undelegateEvents() if @series_view
    @series_view = new Yuetai.Views.Series.IndexView(@)

  new_series: ->
    @series_new_view.undelegateEvents() if @series_new_view
    @series_new_view = new Yuetai.Views.Series.NewView(@)

  show_series: (id)->
    opts =
      series_id: id
    @series_view.undelegateEvents() if @series_view
    @series_view = new Yuetai.Views.Series.ShowView(@, opts)

  index_presentations: ->
    @presentations_view.undelegateEvents() if @presentations_view
    @presentations_view = new Yuetai.Views.Presentations.IndexView(@)

  new_presentation: ->
    @presentation_new_view.undelegateEvents() if @presentation_new_view
    @presentation_new_view = new Yuetai.Views.Presentations.NewView(@)

  show_presentation: (id)->
    opts =
      presentation_id: id
    @presentation_view.undelegateEvents() if @presentation_view
    @presentation_view = new Yuetai.Views.Presentations.ShowView(@, opts)

  show_settings: ->

  # index : ->
  #   opts =
  #     calevel: 'articles'
  #   @index_view.undelegateEvents() if @index_view
    # @index_view = new Yuetai.Views.Site.IndexView(@, opts)
