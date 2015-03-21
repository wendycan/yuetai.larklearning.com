Yuetai.Views.Presentations ||= {}

class Yuetai.Views.Presentations.NewView extends Yuetai.Views.Base
  el: $('#main-content')

  events:
    'submit #new-presentation-form' : 'createBlog'
    'click .cancel' : 'navBack'

  render: ->
    # @rm_nav()
    # @clearMsg()
    # @render_nav(@opts.section)
    @$el.html(_.template($('#t-presentation-new').html())())
    @presentations = new Yuetai.Collections.Presentations

  createBlog: (e)->
    e.preventDefault()
    e.stopPropagation()
    data = {}
    data.title = @$(e.currentTarget).find('#presentation-title').val()
    data.body = @$(e.currentTarget).find('#presentation-body').val()
    data.tag_id = @$(e.currentTarget).find('#presentation-tag').val()
    data.user_id = @account.id
    data.newpr = @$(e.currentTarget).find('#newpr').val()
    data.template = 'presentation'
    @presentations.create(data,
                  success: ->
                    window.location.href = '#presentations'
    )
