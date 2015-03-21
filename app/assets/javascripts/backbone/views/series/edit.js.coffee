Yuetai.Views.Series ||= {}

class Yuetai.Views.Series.EditView extends Yuetai.Views.Base
  el: $('#main-content')

  events:
    'submit #edit-series-form' : 'updateSeries'

  render: ->
    # @rm_nav()
    # @clearMsg()
    # @render_nav(@opts.section)
    @series = new Yuetai.Models.Series(id: @opts.series_id)
    @fetchSeries()

  fetchSeries: ->
    @series.fetch(
      success: =>
        console.log @series
        @$el.html(_.template($('#t-series-edit').html())(series: @series.toJSON()))
    )

  updateSeries: (e)->
    e.preventDefault()
    e.stopPropagation()
    data = {}
    data.title = @$(e.currentTarget).find('#series-title').val()
    data.body = @$(e.currentTarget).find('#series-body').val()
    data.tag_id = @$(e.currentTarget).find('#series-tag').val()
    data.user_id = @account.id
    data.template = 'series'
    @series.save(data,
                  success: ->
                    window.location.href = '#series'
    )
