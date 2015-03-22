Yuetai.Views.Presentations ||= {}

class Yuetai.Views.Presentations.ShowView extends Yuetai.Views.Base
  el: $('#main-content')

  events:
    'click .cancel' : 'navBack'
    'click .delete-article' : 'deleteArticle'

  render: ->
    # @rm_nav()
    # @clearMsg()
    # @render_nav(@opts.section)
    @presentation = new Yuetai.Models.Presentation(id: @opts.presentation_id)
    @converter = new Showdown.converter()
    @count = 0
    @data = {
      theme: 'default'
      language: 'markdown'
      pages: []
    }
    @fetchPresentation()

  fetchPresentation: ->
    @presentation.fetch(
      success: =>
        @renderPresentation()
    )

  renderPresentation: ->
    @data.language = @presentation.get('language')
    @data.pages = JSON.parse(@presentation.get('body')).pages
    @count = @data.pages.length
    @$el.html(_.template($('#t-presentation-show').html())(presentation: @presentation.toJSON()))
    @renderPages()

  renderPages: ->
    for page in @data.pages
      @renderPage(page)

  renderPage: (page)->
    if @data.language == 'markdown'
      page.content = @converter.makeHtml(page.content)
    $('#show-presentation-pages').append(_.template($('#t-presentation-page').html())(page: page))

  deleteArticle: ->
    if confirm('确定删除此演示文稿？')
      @presentation.destroy(
        success: =>
          window.location.href = '#presentations'
      )
