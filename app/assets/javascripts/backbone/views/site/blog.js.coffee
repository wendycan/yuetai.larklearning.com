Yuetai.Views.Blogs ||= {}

class Yuetai.Views.Blogs.BlogView extends Backbone.View
  el: $('.article-wrap')

  events:
    'click .article-category-btn' : 'toggleCategory'

  initialize: (opts)->
    @blog = new Yuetai.Models.Blog(opts)
    @converter = new Showdown.converter()
    @renderBlog()
    hljs.initHighlightingOnLoad()

  renderBlog: ->
    blog = @blog.toJSON()
    if blog.language == 'markdown'
      blog.body = @converter.makeHtml(blog.body)
    blog.date = jQuery.timeago(blog.created_at)
    $('#main-content').html(_.template($('#t-blog-show').html())(blog: blog))
    @updateCategory()

  toggleCategory: ->
    $('.article-category-content').toggle()

  extractCategory: ->
    # $('#main-content')
    ['h1', 'h1', ['h2', 'h2', ['h3', 'h3', 'h3'], 'h2'], 'h1', 'h1', ['h2', 'h2']]

  updateCategory: ->
    data = @extractCategory()
    html = ''
    html += '<ul>'
    for item in data
      if item instanceof Array
        html += '<li><ul>'
        for subItem in item
          if subItem instanceof Array
            html += '<li><ul>'
            for subSubItem in subItem
              html += "<li>#{subSubItem}</li>"
            html += '</ul></li>'
          else
            html += "<li>#{subItem}</li>"
        html += '</ul></li>'
      else
        html += "<li>#{item}</li>"
    html += '</ul>'

    $('.article-category-content').html html
