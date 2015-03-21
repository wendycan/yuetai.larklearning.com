Yuetai.Views.Series ||= {}

class Yuetai.Views.Series.IndexView extends Yuetai.Views.Base
  el: $('#main-content')

  events:
    'click .series-item .delete' : 'deleteArticle'

  render: ->
    # @rm_nav()
    # @clearMsg()
    # @render_nav(@opts.section)
    @$el.html(_.template($('#t-series').html())())
    @series = new Yuetai.Collections.Series
    @fetchSeries()

  fetchSeries: ->
    @series.fetch(
      success: =>
        @renderSeries()
    )

  renderSeries: ->
    @series.each(@renderSeriesItem, @)

  renderSeriesItem: (series)->
    # snip = @strip(blog.get('body'))
    # snip = @limit(snip, 300)
    # author = @authors.get(blog.get('author_id'))
    # article.set('created_at', @handleDate(article.get('created_at')))
    $('#series').append(_.template($('#t-series-item').html())(series: series.toJSON()))

  deleteArticle: (e)->
    $this = $(e.currentTarget).parents('li.series-item')
    series = @series.get(parseInt($this.data('id')))
    if confirm('确定删除选中此文章？')
      series.destroy(
        success: =>
          $this.remove()
      )
