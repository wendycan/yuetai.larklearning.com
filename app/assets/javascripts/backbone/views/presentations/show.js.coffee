Yuetai.Views.Presentations ||= {}

class Yuetai.Views.Presentations.ShowView extends Yuetai.Views.Base
  el: $('#main-content')

  render: ->
    # @rm_nav()
    # @clearMsg()
    # @render_nav(@opts.section)
    @presentation = new Yuetai.Models.Presentation(id: @opts.presentation_id)
    @fetchPresentation()

  fetchPresentation: ->
    @presentation.fetch(
      success: =>
        @renderPresentation()
    )

  renderPresentation: ->
    @$el.html(_.template($('#t-presentation-show').html())(presentation: @presentation.toJSON()))

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
