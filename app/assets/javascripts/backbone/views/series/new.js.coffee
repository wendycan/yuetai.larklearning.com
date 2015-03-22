Yuetai.Views.Series ||= {}

class Yuetai.Views.Series.NewView extends Yuetai.Views.Base
  el: $('#main-content')

  events:
    'submit #new-series-form' : 'createBlog'
    'click .cancel' : 'navBack'

  render: ->
    # @rm_nav()
    # @clearMsg()
    # @render_nav(@opts.section)
    @$el.html(_.template($('#t-series-new').html())())
    @series = new Yuetai.Collections.Series

  createBlog: (e)->
    e.preventDefault()
    e.stopPropagation()
    data = {}
    data.title = @$(e.currentTarget).find('#series-title').val()
    data.body = @$(e.currentTarget).find('#series-body').val()
    data.tag_id = @$(e.currentTarget).find('#series-tag').val()
    data.user_id = @account.id
    data.newsr = @$(e.currentTarget).find('#newsr').val()
    data.template = 'series'
    @series.create(data,
                  success: ->
                    window.location.href = '#series'
    )
