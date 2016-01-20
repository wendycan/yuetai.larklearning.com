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
    $el = $('.article-body')
    tags = ['h1', 'h2', 'h3', 'h4', 'h5', 'h6']
    topIndex = subTopIndex = subberTopIndex = null
    for tag, i in tags
      if $el.find(tag).length > 0
        parents = $el.find(tag)
        if topIndex && subTopIndex
          subberTopIndex = i
        else if topIndex
          subTopIndex = i
        else
          topIndex = i
    header_tags = [tags[topIndex], tags[subTopIndex], tags[subberTopIndex]]
    headers = $el.find(header_tags[0]).toArray()

    o_headers = headers.concat([])
    for h, k in o_headers
      delta = headers.length - o_headers
      if k + 1 > o_headers.length
        subHeaders = $(h).nextAll(o_headers[k+1], header_tags[1]).toArray()
      else
        subHeaders = $(h).nextUntil(o_headers[k+1], header_tags[1]).toArray()
      if subHeaders.length > 0
        # o_subHeaders = subHeaders.concat([])
        # o_subHeaders.reduce (preSubHeader, currSubHeader, m)->
        #   subberHeaders = $(preSubHeader).nextUntil(currSubHeader, header_tags[2]).toArray()
        #   if subberHeaders.length > 0
        #     subHeaders.splice(m, 0, subberHeaders)
        headers.splice(k, 0, subHeaders)
    console.log headers
    # ['h1', 'h1', ['h2', 'h2', ['h3', 'h3', 'h3'], 'h2'], 'h1', 'h1', ['h2', 'h2']]
    headers

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
              html += "<li><a href=''>#{$(subSubItem).text()}</a></li>"
            html += '</ul></li>'
          else
            html += "<li><a href=''>#{$(subItem).text()}</a></li>"
        html += '</ul></li>'
      else
        html += "<li><a href=''>#{$(item).text()}</a></li>"
    html += '</ul>'

    $('.article-category-content').html html
