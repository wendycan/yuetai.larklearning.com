Yuetai.Views.Presentations ||= {}

class Yuetai.Views.Presentations.EditView extends Yuetai.Views.Base
  el: $('#main-content')

  events:
    'submit #edit-presentations-form' : 'updatePresentations'

  render: ->
    # @rm_nav()
    # @clearMsg()
    # @render_nav(@opts.section)
    @presentations = new Yuetai.Models.Presentations(id: @opts.presentations_id)
    @fetchPresentations()

  fetchPresentations: ->
    @presentations.fetch(
      success: =>
        console.log @presentations
        @$el.html(_.template($('#t-presentations-edit').html())(presentations: @presentations.toJSON()))
    )

  updatePresentations: (e)->
    e.preventDefault()
    e.stopPropagation()
    data = {}
    data.title = @$(e.currentTarget).find('#presentations-title').val()
    data.body = @$(e.currentTarget).find('#presentations-body').val()
    data.tag_id = @$(e.currentTarget).find('#presentations-tag').val()
    data.user_id = @account.id
    data.template = 'presentations'
    @presentations.save(data,
                  success: ->
                    window.location.href = '#presentationss'
    )
