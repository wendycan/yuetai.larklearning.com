Yuetai.Views.Blogs ||= {}

class Yuetai.Views.Blogs.RandomView extends Yuetai.Views.Base
  el: $('#main-content')

  events:
    'click .random-btn' : 'randomBlog'

  initialize: (opts)->
    @converter = new Showdown.converter()
    @blog_list = []
    @result_list = []
    _this = @
    @blogs = []
    @count = 0

    $.ajax(
      url: '/random.xml'
      # url: '/random-dev.xml'
      type: 'GET'
      dataType: "xml"
      success: (xml)->
        $(xml).find("blog_list blog").each ->
          _this.blog_list.push $(this).find('id').text()
        $(xml).find("result_list blog").each ->
          _this.result_list.push $(this).find('id').text()
        _this.render()
    )         
  
  render: ->
    @fetchBlogs()

  fetchBlogs: ->
    _this = @
    async.filter @blog_list, 
      (id, callback)->  
        $.ajax(
          url: "#{Yuetai.ApiPrefix}/articles/#{id}?template=blog"
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
    index = 0
    i = 0
    delay = 75
    run = =>
      if index >= @blogs.length
        index = index%@blogs.length
      if @blogs[index].language == 'markdown'
        @blogs[index].body = @converter.makeHtml(@blogs[index].body)
      if i > 10
        delay = delay * 1.1
      if i > 20
        id = @result_list[(@count++)%@result_list.length]
        blog = @findBlogById(id)
        $('#random-blog').html(_.template($('#t-random-blog').html())({blog: blog}))
        return
      $('#random-blog').html(_.template($('#t-random-blog').html())({blog: @blogs[index]}))
      index++
      i++
      setTimeout(run, delay)
    run()

  findBlogById: (id)->
    for blog in @blogs
      if blog.id == parseInt(id)
        return blog