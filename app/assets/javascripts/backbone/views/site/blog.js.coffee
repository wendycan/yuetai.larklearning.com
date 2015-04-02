Yuetai.Views.Blogs ||= {}

class Yuetai.Views.Blogs.BlogView extends Backbone.View
  el: $('#main-content')

  initialize: (opts)->
    @blog = new Yuetai.Models.Blog(opts)
    @converter = new Showdown.converter()
    @renderBlog()

  renderBlog: ->
    blog = @blog.toJSON()
    if blog.language == 'markdown'
      blog.body = @converter.makeHtml(blog.body)
    @$el.html(_.template($('#t-blog-show').html())(blog: blog))
    