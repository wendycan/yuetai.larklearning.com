Yuetai.Views.Blogs ||= {}

class Yuetai.Views.Blogs.RandomView extends Yuetai.Views.Base
  el: $('#main-content')

  events:
    'click #random' : 'randomBlog'
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
            _this.render()
        )         
    )
  
  render: ->
    @fetchBlogs()

  fetchBlogs: ->
    _this = @
    async.filter @blog_list, 
      (id, callback)->  
        $.ajax(
          url: "#{Yuetai.ApiPrefix}/blogs/#{id}?auth_token=#{_this.token}"
          type: 'GET'
          success: (data)->
            _this.blogs.push data
            callback(true)
        )
      , 
        ->
          _this.renderBlog(_this.blogs[0])

  renderBlog: (blog)->
    if blog.language == 'markdown'
      blog.body = @converter.makeHtml(blog.body)
    $('#random-blog').html(_.template($('#t-random-blog').html())({blog: blog}))

  randomBlog: ->
