class Yuetai.Routers.Engines extends Backbone.Router
  routes:
    '' : 'index_blogs'

    'blogs' : 'index_blogs'
    'blogs/:id' : 'show_blog'

    'series' : 'index_series'
    'series/:id' : 'show_series'

    'presentations' : 'index_presentations'
    'presentations/:id' : 'show_presentation'

    'settings' : 'show_settings'

  initialize: ->
    @blogs = new Yuetai.Collections.Blogs()
    @account = new Yuetai.Models.Account()

  index_blogs: ->
    @blogs_view.undelegateEvents() if @blogs_view
    @blogs_view = new Yuetai.Views.Blogs.IndexView(@)
    @blogs_view.render()

  show_blog: ->
    @blog_view.undelegateEvents() if @blog_view
    @blog_view = new Yuetai.Views.Blogs.ShowView(@)
    @blog_view.render()

  index_series: ->
    @series_view.undelegateEvents() if @series_view
    @series_view = new Yuetai.Views.Series.IndexView(@)
    @series_view.render()

  show_series: ->
    @series_view.undelegateEvents() if @series_view
    @series_view = new Yuetai.Views.Series.ShowView(@)
    @series_view.render()


  index_presentations: ->
    @presentations_view.undelegateEvents() if @presentations_view
    @presentations_view = new Yuetai.Views.Presentations.ShowView(@)
    @presentations_view.render()

  show_presentation: ->
    @presentation_view.undelegateEvents() if @presentation_view
    @presentation_view = new Yuetai.Views.Presentations.ShowView(@)
    @presentation_view.render()

  show_settings: ->

  # index : ->
  #   opts =
  #     calevel: 'articles'
  #   @index_view.undelegateEvents() if @index_view
    # @index_view = new Yuetai.Views.Site.IndexView(@, opts)
