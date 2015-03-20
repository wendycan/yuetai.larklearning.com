Yuetai.Views.Presentations ||= {}

class Yuetai.Views.Presentations.ShowView extends Yuetai.Views.Base
  el: $('#main-content')

  render: ->
    # @rm_nav()
    # @clearMsg()
    # @render_nav(@opts.section)
    @$el.html(_.template($('#t-presentation').html())())
    # @Presentations.each(@renderArticle, @)
