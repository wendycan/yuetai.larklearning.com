Yuetai.Views.Presentations ||= {}

class Yuetai.Views.Presentations.PresentationView extends Backbone.View
  el: $('#main-content')

  initialize: (opts)->
    @presentation = new Yuetai.Models.Presentation(opts)
    @converter = new Showdown.converter()
    @renderPresentation()

  renderPresentation: ->
    data = JSON.parse(@presentation.get('body'))
    # presentation = @presentation.toJSON()
    # @$el.html(_.template($('#t-presentation-show').html())(presentation: presentation))

  renderPages: ->
    for page in @data.pages
      @renderPage(page)

  renderPage: (page)->
    if @data.language == 'markdown'
      page.content = @converter.makeHtml(page.content)
    # $('#show-presentation-pages').append(_.template($('#t-presentation-page').html())(page: page))
