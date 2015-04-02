Yuetai.Views.Blogs ||= {}

class Yuetai.Views.Blogs.IndexView extends Yuetai.Views.Base
  el: $('#main-content')

  events:
    'click .blog .delete' : 'deleteArticle'

  render: ->
    # @rm_nav()
    # @clearMsg()
    # @render_nav(@opts.section)
    @$el.html(_.template($('#t-blogs').html())())
    @blogs = new Yuetai.Collections.Blogs
    @converter = new Showdown.converter()
    @fetchBlogs()

  fetchBlogs: ->
    @blogs.fetch(
      success: =>
        @renderBlogs()
    )

  renderBlogs: ->
    @blogs.each(@renderBlog, @)

  renderBlog: (blog)->
    if blog.get('language') == 'markdown'
      snip = @strip(@converter.makeHtml(blog.get('body')))
    else
      snip = @strip(blog.get('body'))
    snip = @limit(snip, 300)
    blog = blog.toJSON()
    blog.body = snip
    $('#blogs').append(_.template($('#t-blog').html())(blog: blog))
  
  deleteArticle: (e)->
    $this = $(e.currentTarget).parents('li.blog')
    blog = @blogs.get(parseInt($this.data('id')))
    if confirm('确定删除选中此博客？')
      blog.destroy(
        success: =>
          $this.remove()
      )
