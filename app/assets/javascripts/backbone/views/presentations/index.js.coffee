Yuetai.Views.Presentations ||= {}

class Yuetai.Views.Presentations.IndexView extends Yuetai.Views.Base
  el: $('#main-content')

  events:
    'click .presentation .delete' : 'deleteArticle'

  render: ->
    # @rm_nav()
    # @clearMsg()
    # @render_nav(@opts.section)
    @$el.html(_.template($('#t-presentations').html())())
    @presentations = new Yuetai.Collections.Presentations
    @fetchPresentations()
    @converter = new Showdown.converter()

  fetchPresentations: ->
    @presentations.fetch(
      success: =>
        @renderPresentations()
    )

  renderPresentations: ->
    @presentations.each(@renderPresentation, @)

  renderPresentation: (presentation)->
    content = JSON.parse(presentation.get('body'))
    if presentation.get('language') == 'markdown'
      snip = @strip(@converter.makeHtml(content.pages[0].content))
    else
      snip = @strip(content.pages[0].content)
    snip = @limit(snip, 300)
    presentation = presentation.toJSON()
    presentation.body = snip
    $('#presentations').append(_.template($('#t-presentation').html())(presentation: presentation))

  deleteArticle: (e)->
    $this = $(e.currentTarget).parents('li.presentation')
    presentation = @presentations.get(parseInt($this.data('id')))
    if confirm('确定删除选中此演示文稿？')
      presentation.destroy(
        success: =>
          $this.remove()
      )
