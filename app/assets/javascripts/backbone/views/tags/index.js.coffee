Yuetai.Views.Tags ||= {}

class Yuetai.Views.Tags.IndexView extends Yuetai.Views.Base
  el: $('#main-content')

  render: ->
    @rm_nav()
    @clearMsg()
    @render_nav(@opts.section)
    @$el.html(_.template($('#t-engines').html())())
    @engines.each(@renderEngine, @)

  renderEngine: (engine)->
    $('.engines-list').append(_.template($('#t-engine').html())({engine: engine.toJSON()}))
