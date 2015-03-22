Yuetai.Views.Presentations ||= {}

class Yuetai.Views.Presentations.PresentationView extends Backbone.View
  el: $('#main-content')

  initialize: (opts)->
    $('nav.top-bar').hide()
    @presentation = new Yuetai.Models.Presentation(opts)
    @converter = new Showdown.converter()
    @renderPresentation()

  renderPresentation: ->
    @data = JSON.parse(@presentation.get('body'))
    @renderPages()
    $('#fullpage').fullpage({
      menu: true
      navigation: true
      navigationPosition: 'right'
      sectionsColor: ['#f2f2f2', '#4BBFC3', '#7BAABE', 'whitesmoke', '#f2f2f2']
      onLeave: (index, nextIndex, direction)=>
        if nextIndex == $('.section').length && $('#back').length == 0
          @$el.append('<a id="back" class="button tiny" href="/presentation" style="position: fixed; bottom: 0; left: 0;">返回</a>')
        else
          $('#back').remove()
    })

  renderPages: ->
    for page in @data.pages
      @renderPage(page)

  renderPage: (page)->
    if @data.language == 'markdown'
      page.content = @converter.makeHtml(page.content)
    @$('#fullpage').append(_.template($('#t-presentation-page').html())(page: page))
