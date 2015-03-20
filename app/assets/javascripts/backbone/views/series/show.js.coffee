Yuetai.Views.Series ||= {}

class Yuetai.Views.Series.ShowView extends Yuetai.Views.Base
  el: $('#main-content')

  render: ->
    # @rm_nav()
    # @clearMsg()
    # @render_nav(@opts.section)
    @series = new Yuetai.Models.Series(id: @opts.series_id)
    @fetchSeries()

  fetchSeries: ->
    @series.fetch(
      success: =>
        @renderSeries()
    )

  renderSeries: ->
    @$el.html(_.template($('#t-series-show').html())(series: @series.toJSON()))
