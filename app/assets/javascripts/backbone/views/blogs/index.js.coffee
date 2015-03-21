Yuetai.Views.Blogs ||= {}

class Yuetai.Views.Blogs.IndexView extends Yuetai.Views.Base
  el: $('#main-content')

  events:
    'click .delete' : 'deleteArticle'

  render: ->
    # @rm_nav()
    # @clearMsg()
    # @render_nav(@opts.section)
    @$el.html(_.template($('#t-blogs').html())())
    @blogs = new Yuetai.Collections.Blogs
    @fetchBlogs()

  fetchBlogs: ->
    @blogs.fetch(
      success: =>
        @renderBlogs()
    )

  renderBlogs: ->
    @blogs.each(@renderBlog, @)

  renderBlog: (blog)->
    # snip = @strip(blog.get('body'))
    # snip = @limit(snip, 300)
    # author = @authors.get(blog.get('author_id'))
    # article.set('created_at', @handleDate(article.get('created_at')))
    $('#blogs').append(_.template($('#t-blog').html())(blog: blog.toJSON()))

  deleteArticle: (e)->
    $this = $(e.currentTarget).parents('li.blog')
    blog = @blogs.get(parseInt($this.data('id')))
    if confirm('确定删除选中此博客？')
      blog.destroy(
        success: =>
          $this.remove()
      )
