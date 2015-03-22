Yuetai.Views.Series ||= {}

class Yuetai.Views.Series.ShowView extends Yuetai.Views.Base
  el: $('#main-content')

  events:
    'click .cancel' : 'navBack'
    'click .delete-article' : 'deleteArticle'

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

  deleteArticle: ->
    if confirm('确定删除此文章？')
      @series.destroy(
        success: =>
          window.location.href = '#series'
      )
