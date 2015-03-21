Yuetai.Views.Presentations ||= {}

class Yuetai.Views.Presentations.ShowView extends Yuetai.Views.Base
  el: $('#main-content')

  events:
    'click .cancel' : 'navBack'
    'click .delete-article' : 'deleteArticle'

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

  deleteArticle: ->
    if confirm('确定删除此演示文稿？')
      @presentation.destroy(
        success: =>
          window.location.href = '#presentations'
      )
