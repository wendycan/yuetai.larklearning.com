Yuetai.Views.Presentations ||= {}

class Yuetai.Views.Presentations.NewView extends Yuetai.Views.Base
  el: $('#main-content')

  events:
    'submit #new-presentation-form' : 'createBlog'
    'click .cancel' : 'navBack'
    'click #new-presentation-form #add-page' : 'addPage'

  render: ->
    # @rm_nav()
    # @clearMsg()
    # @render_nav(@opts.section)
    @$el.html(_.template($('#t-presentation-new').html())())
    @presentations = new Yuetai.Collections.Presentations

    @count = 0
    @data = {
      theme: 'default'
      language: 'markdown'
      pages: []
    }

    @converter = new Showdown.converter()
    @editor = ace.edit('new-page-editor')
    MarkdownMode = require("ace/mode/markdown").Mode
    HtmlMode = require("ace/mode/html").Mode

    @editor.setTheme("ace/theme/ambiance")
    @editor.setFontSize(18)
    @editor.getSession().setMode(new MarkdownMode())
    @editor.renderer.setShowGutter(false)
    @editor.renderer.setShowPrintMargin(false)

  createBlog: (e)->
    e.preventDefault()
    e.stopPropagation()
    data = {}
    data.title = @$(e.currentTarget).find('#presentation-title').val()
    data.body = JSON.stringify(@data)
    data.tag_id = @$(e.currentTarget).find('#presentation-tag').val()
    data.user_id = @account.id
    data.newpr = @$(e.currentTarget).find('#newpr').val()
    data.template = 'presentation'
    data.language = @data.language
    @presentations.create(data,
                  success: ->
                    window.location.href = '#presentations'
    )

  addPage: ->
    page_content = @editor.getSession().getValue()
    page = {
      id: @count++
      content: page_content
    }
    @data.pages.push page
    @renderPage(page)

  renderPage: (page)->
    if @data.language == 'markdown'
      page.content = @converter.makeHtml(page.content)
    $('#new-presentation-pages').append(_.template($('#t-presentation-page').html())(page: page))
