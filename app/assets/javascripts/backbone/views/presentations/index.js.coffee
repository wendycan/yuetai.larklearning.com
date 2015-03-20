Yuetai.Views.Presentations ||= {}

class Yuetai.Views.Presentations.IndexView extends Yuetai.Views.Base
  el: $('#main-content')

  render: ->
    # @rm_nav()
    # @clearMsg()
    # @render_nav(@opts.section)
    @$el.html(_.template($('#t-presentations').html())())
    # @Presentations.each(@renderArticle, @)

