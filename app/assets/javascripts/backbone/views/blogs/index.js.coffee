Yuetai.Views.Blogs ||= {}

class Yuetai.Views.Blogs.IndexView extends Yuetai.Views.Base
  el: $('#main-content')

  render: ->
    # @rm_nav()
    # @clearMsg()
    # @render_nav(@opts.section)
    @$el.html(_.template($('#t-blogs').html())())
    # @blogs.each(@renderArticle, @)

  renderArticle: (blog)->
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
