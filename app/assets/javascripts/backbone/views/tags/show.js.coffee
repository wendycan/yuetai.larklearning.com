Yuetai.Views.Tags ||= {}

class Yuetai.Views.Tags.ShowView extends Yuetai.Views.Base
  el: $('#main-content')

  render: ->
    @rm_nav()
    @clearMsg()
    @$el.html(_.template($('#t-engines').html())())
    @engines.each(@renderEngine, @)

  renderEngine: (engine)->
    $('.engines-list').append(_.template($('#t-engine').html())({engine: engine.toJSON()}))
