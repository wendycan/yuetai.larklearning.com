TinySou.Views.Tags ||= {}

class TinySou.Views.Tags.ShowView extends TinySou.Views.Base
  el: $('#main-content')

  render: ->
    @rm_nav()
    @clearMsg()
    @$el.html(_.template($('#t-engines').html())())
    @engines.each(@renderEngine, @)

  renderEngine: (engine)->
    $('.engines-list').append(_.template($('#t-engine').html())({engine: engine.toJSON()}))
