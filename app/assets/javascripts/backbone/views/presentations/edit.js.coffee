Yuetai.Views.Presentations ||= {}

class Yuetai.Views.Presentations.EditView extends Yuetai.Views.Base
  el: $('#main-content')

  events:
    'submit #edit-presentations-form' : 'updatePresentations'
    'click .cancel' : 'navBack'

  render: ->
    # @rm_nav()
    # @clearMsg()
    # @render_nav(@opts.section)
    @presentation = new Yuetai.Models.Presentation(id: @opts.presentation_id)
    @fetchPresentation()

  fetchPresentation: ->
    @presentation.fetch(
      success: =>
        @$el.html(_.template($('#t-presentation-edit').html())(presentation: @presentation.toJSON()))
    )

  updatePresentations: (e)->
    e.preventDefault()
    e.stopPropagation()
    data = {}
    data.title = @$(e.currentTarget).find('#presentation-title').val()
    data.body = @$(e.currentTarget).find('#presentation-body').val()
    data.tag_id = @$(e.currentTarget).find('#presentation-tag').val()
    data.user_id = @account.id
    data.template = 'presentation'
    @presentation.save(data,
                  success: ->
                    window.location.href = '#presentationss'
    )
