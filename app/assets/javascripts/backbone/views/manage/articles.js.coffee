Yuetai.Views.Manage ||= {}

class Yuetai.Views.Manage.ArticlesView extends Yuetai.Views.Base
  el: $('#main-content')

  events:
    'click .tag-edit' : 'editTag'

  render: ->
    @$el.html(_.template($('#t-manage-articles').html())())
    @articles = new Yuetai.Collections.Blogs
    @fetchBlogs()

  fetchBlogs: ->
    @articles.fetch
      success: (blogs)=>
        @renderBlogs(blogs)

  renderBlogs: ->
    @articles.each @renderBlog, @

  renderBlog: (blog, i)->
    html = _.template($('#t-manage-article').html()) _.extend(blog.toJSON(), {snipBody: @limit(@strip(blog.get('body')), 50), index: i})
    $(@el).find('tbody').append html

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
