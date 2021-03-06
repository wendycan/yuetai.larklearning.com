Yuetai.Views.Manage ||= {}

class Yuetai.Views.Manage.ArticlesView extends Yuetai.Views.Base
  el: $('#main-content')

  events:
    'click .tag-edit' : 'editTag'

  render: ->
    @$el.html _.template($('#t-manage').html())()
    @articles = new Yuetai.Collections.Blogs
    @fetchBlogs()

  fetchBlogs: ->
    @articles.fetch
      data:
        all: 'true'
      success: =>
        @$el.find('.dashboard-content-wrap').html _.template($('#t-manage-articles').html())({articles_count: @articles.state.totalRecords})
        $('.articles-nav').addClass('active').siblings().removeClass('active')
        @renderBlogs()
        @renderPagination()

  renderPagination: ->
    @articles.queryParams.all = 'true'
    paginator = new Paginator
      collection: @articles

    $("#paginator").html paginator.render().$el
    @listenTo @articles, "reset", =>
      @renderBlogs()

  renderBlogs: ->
    $(@el).find('tbody').empty()
    @articles.each @renderBlog, @

  renderBlog: (blog, i)->
    html = _.template($('#t-manage-article').html()) _.extend(blog.toJSON(), {snipBody: @limit(@strip(blog.get('body')), 50), index: i + 1})
    $(@el).find('tbody').append html

  strip: (html)->
    html.replace(/<\/?[^>]+(>|$)/g, "")

  limit: (text, num)->
    if text.length >= num
      snip = text.substr(0,num)
      snip = snip.concat('...')
    else
      snip = text
    snip
