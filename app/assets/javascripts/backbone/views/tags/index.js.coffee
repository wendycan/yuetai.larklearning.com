Yuetai.Views.Tags ||= {}

class Yuetai.Views.Tags.IndexView extends Yuetai.Views.Base
  el: $('#main-content')

  render: ->
    # @rm_nav()
    # @clearMsg()
    @render_nav(@opts.section)
    @$el.html(_.template($('#t-tags-index').html())())
    @tags.each(@renderEngine, @)

  renderEngine: (tag)->
    $('#tag-items').append(_.template($('#t-tag-item').html())({tag: tag.toJSON()}))
