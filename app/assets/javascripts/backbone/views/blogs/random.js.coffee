Yuetai.Views.Blogs ||= {}

class Yuetai.Views.Blogs.RandomView extends Yuetai.Views.Base
  el: $('#main-content')

  # events:
    # 'click .cancel' : 'navBack'
    # 'click .delete-article' : 'deleteArticle'

  initialize: (opts)->
    @converter = new Showdown.converter()
    @blog_list = []
    @result_list = []
    _this = @
    @blogs = []
    
    $.ajax(
      url: '/dashboard/index.json'
      type: 'GET'
      success: (data)->
        _this.token = data.auth_token
        $.ajax(
          url: '/random.xml'
          type: 'GET'
          dataType: "xml"
          success: (xml)->
            $(xml).find("blog_list blog").each ->
              _this.blog_list.push $(this).find('id').text()
            $(xml).find("result_list blog").each ->
              _this.result_list.push $(this).find('id').text()
            _this.startRender()
        )         
    )

  render: ->
    # @rm_nav()
    # @clearMsg()
    # @render_nav(@opts.section)
    # @blog = new Yuetai.Models.Blog(id: @opts.blog_id)
    # @fetchBlog()
    # @converter = new Showdown.converter()

  # fetchBlog: ->
  #   @blog.fetch(
  #     success: =>
  #       @renderBlog()
  #   )

  # renderBlog: ->
  #   blog = @blog.toJSON()
  #   if blog.language == 'markdown'
  #     blog.body = @converter.makeHtml(blog.body)
  #   @$el.html(_.template($('#t-blog-show').html())(blog: blog))

  # deleteArticle: ->
  #   if confirm('确定删除此博客？')
  #     @blog.destroy(
  #       success: =>
  #         window.location.href = '#blogs'
  #     )
  startRender: ->
    @fetchBlogs()

  fetchBlogs: ->
    _this = @
    for id in @blog_list
      $.ajax(
        url: "#{Yuetai.ApiPrefix}/blogs/#{id}?auth_token=#{_this.token}"
        type: 'GET'
        success: (data)->
          _this.blogs.push data
      )
