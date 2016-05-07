Yuetai.Views.Presentations ||= {}

class Yuetai.Views.Presentations.PresentationsView extends Backbone.View
  el: $('#main-content')

  initialize: (opts)->
    @presentations = new Yuetai.Collections.Presentations(opts)
    @converter = new Showdown.converter()
    @renderPresentations()

  renderPresentations: ->
    @presentations.each(@renderPresentation, @)

  renderPresentation: (presentation)->
    data = JSON.parse(presentation.get('body'))
    if presentation.get('language') == 'markdown'
      snip = @strip(@converter.makeHtml(data.pages[0].content))
    else
      snip = @strip(data.pages[0].content)
    snip = @limit(snip, 300)
    presentation = presentation.toJSON()
    presentation.content = snip
    presentation.date = jQuery.timeago(presentation.created_at)
    $('#presentations').append(_.template($('#t-presentation').html())(presentation: presentation))

  strip: (html)->
    html.replace(/<\/?[^>]+(>|$)/g, "")

  limit: (text, num)->
    if text.length >= num
      snip = text.substr(0,num)
      snip = snip.concat('...')
    else
      snip = text
    snip
