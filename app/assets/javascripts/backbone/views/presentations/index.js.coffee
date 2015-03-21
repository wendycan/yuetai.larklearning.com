Yuetai.Views.Presentations ||= {}

class Yuetai.Views.Presentations.IndexView extends Yuetai.Views.Base
  el: $('#main-content')

  events:
    'click .presentation .delete' : 'deleteArticle'

  render: ->
    # @rm_nav()
    # @clearMsg()
    # @render_nav(@opts.section)
    @$el.html(_.template($('#t-presentations').html())())
    @presentations = new Yuetai.Collections.Presentations
    @fetchPresentations()

  fetchPresentations: ->
    @presentations.fetch(
      success: =>
        @renderPresentations()
    )

  renderPresentations: ->
    @presentations.each(@renderPresentation, @)

  renderPresentation: (presentation)->
    # snip = @strip(blog.get('body'))
    # snip = @limit(snip, 300)
    # author = @authors.get(blog.get('author_id'))
    # article.set('created_at', @handleDate(article.get('created_at')))
    $('#presentations').append(_.template($('#t-presentation').html())(presentation: presentation.toJSON()))

  deleteArticle: (e)->
    $this = $(e.currentTarget).parents('li.presentation')
    presentation = @presentations.get(parseInt($this.data('id')))
    if confirm('确定删除选中此演示文稿？')
      presentation.destroy(
        success: =>
          $this.remove()
      )
