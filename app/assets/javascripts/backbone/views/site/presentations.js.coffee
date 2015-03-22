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
    $('#presentations').append(_.template($('#t-presentation').html())(presentation: presentation))

  strip: (html)->
    tmp = document.createElement("DIV")
    tmp.innerHTML = html
    tmp.textContent || tmp.innerText || ""

  limit: (text, num)->
    if text.length >= num
      snip = text.substr(0,num)
      snip = snip.concat('...')
    else
      snip = text
    snip
