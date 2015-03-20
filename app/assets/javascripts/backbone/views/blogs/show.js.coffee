Yuetai.Views.Blogs ||= {}

class Yuetai.Views.Blogs.ShowView extends Yuetai.Views.Base
  el: $('#main-content')

  render: ->
    # @rm_nav()
    # @clearMsg()
    # @render_nav(@opts.section)
    @blog = new Yuetai.Models.Blog(id: @opts.blog_id)
    @fetchBlog()

  fetchBlog: ->
    @blog.fetch(
      success: =>
        @renderBlog()
    )

  renderBlog: ->
    @$el.html(_.template($('#t-blog-show').html())(blog: @blog.toJSON()))

    # snip = @strip(blog.get('body'))
    # snip = @limit(snip, 300)
    # author = @authors.get(blog.get('author_id'))
    # article.set('created_at', @handleDate(article.get('created_at')))
    # $('#blogs-items').append(_.template($('#t-article-item').html())(
    #   {
    #     article: article.toJSON(),
    #     article_snip: snip
    #     author: author.toJSON()
    #   }
    # ))
