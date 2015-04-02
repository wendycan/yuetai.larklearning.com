Yuetai.Views.Blogs ||= {}

class Yuetai.Views.Blogs.BlogsView extends Backbone.View
  el: $('#main-content')

  initialize: (opts)->
    @blogs = new Yuetai.Collections.Blogs(opts)
    @converter = new Showdown.converter()
    @renderBlogs()

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
    $('#y-blogs').append(_.template($('#t-blog').html())(blog: blog))
  strip: (html)->
    tmp = document.createElement("DIV")
    tmp.innerHTML = html
    tmp.textContent || tmp.innerText || ""

  limit: (text, num)->
    if text.length >= num
      snip = text.substr(0,num)
      snip = snip.concat('...')
    else
      snip = text
    snip
