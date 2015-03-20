Yuetai.Views.Series ||= {}

class Yuetai.Views.Series.IndexView extends Yuetai.Views.Base
  el: $('#main-content')

  render: ->
    # @rm_nav()
    # @clearMsg()
    # @render_nav(@opts.section)
    @$el.html(_.template($('#t-Series').html())())
    # @Presentations.each(@renderArticle, @)
