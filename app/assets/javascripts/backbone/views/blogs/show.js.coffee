Yuetai.Views.Blogs ||= {}

class Yuetai.Views.Blogs.ShowView extends Yuetai.Views.Base
  el: $('#main-content')

  events:
    'click .cancel' : 'navBack'
    'click .delete-article' : 'deleteArticle'

  render: ->
    # @rm_nav()
    # @clearMsg()
    # @render_nav(@opts.section)
    @blog = new Yuetai.Models.Blog(id: @opts.blog_id)
    @fetchBlog()
    @converter = new Showdown.converter()

  fetchBlog: ->
    @blog.fetch(
      success: =>
        @renderBlog()
    )

  renderBlog: ->
    blog = @blog.toJSON()
    if blog.language == 'markdown'
      blog.body = @converter.makeHtml(blog.body)
    @$el.html(_.template($('#t-blog-show').html())(blog: blog))

  deleteArticle: ->
    if confirm('确定删除此博客？')
      @blog.destroy(
        success: =>
          window.location.href = '#blogs'
      )

