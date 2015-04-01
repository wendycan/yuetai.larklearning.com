Yuetai.Views.Presentations ||= {}

class Yuetai.Views.Presentations.EditView extends Yuetai.Views.Base
  el: $('#main-content')

  events:
    'submit #edit-presentations-form' : 'updatePresentations'
    'click .cancel' : 'navBack'
    'click .pages .page' : 'editPage'
    'click #edit-presentations-form #add-page' : 'addPage'
    'click #edit-presentations-form #update-page' : 'updatePage'

  render: ->
    # @rm_nav()
    # @clearMsg()
    # @render_nav(@opts.section)
    @presentation = new Yuetai.Models.Presentation(id: @opts.presentation_id)
    @fetchPresentation()
    @count = 0
    @data = {
      theme: 'default'
      pages: []
    }
    @converter = new Showdown.converter();

  fetchPresentation: ->
    @presentation.fetch(
      success: =>
        @$el.html(_.template($('#t-presentation-edit').html())(presentation: @presentation.toJSON()))

        @buildPages()

    )

  buildPages: ->
    @editor = ace.edit('edit-page-editor')
    MarkdownMode = require("ace/mode/markdown").Mode
    HtmlMode = require("ace/mode/html").Mode
    @editor.setTheme("ace/theme/ambiance")
    @editor.setFontSize(18)
    @editor.renderer.setShowGutter(false)
    @editor.renderer.setShowPrintMargin(false)
    data = JSON.parse(@presentation.get('body'))

    @data.language = @presentation.get('language')
    @data.pages = data.pages
    @count = @data.pages.length
    
    @renderPages()

    if @presentation.get('language') == markdown
      @editor.getSession().setMode(new MarkdownMode())
    else
      @editor.getSession().setMode(new HtmlMode())

    _this = this

    $('#edit-presentations-form input[name=language]').change( ->
      if $(this).val() == 'markdown'
        _this.editor.getSession().setMode(new MarkdownMode())
        _this.data.language = 'markdown'
      else
        _this.data.language = 'html'
        _this.editor.getSession().setMode(new HtmlMode())
    )

  updatePresentations: (e)->
    e.preventDefault()
    e.stopPropagation()
    data = {}
    data.title = @$(e.currentTarget).find('#presentation-title').val()
    data.body = JSON.stringify(@data)
    data.tag_id = @$(e.currentTarget).find('#presentation-tag').val()
    data.user_id = @account.id
    data.template = 'presentation'
    data.language = @data.language
    @presentation.save(data,
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
    @editor.getSession().setValue('')
    @renderPage(page)

  renderPages: ->
    for page in @data.pages
      @renderPage(page)

  renderPage: (page)->
    if @data.language == 'markdown'
      page.content = @converter.makeHtml(page.content)
    $('#edit-presentation-pages').append(_.template($('#t-presentation-page').html())(page: page))

  editPage: (e)->
    $this = $(e.currentTarget)
    if $this.hasClass('active')
      $this.removeClass('active')
      $('#add-page').show()
      $('#update-page').addClass('hide')
      @editor.getSession().setValue('')
    else
      $('#add-page').hide()
      $('#update-page').removeClass('hide')
      $('.pages .page').removeClass('active')
      $this.addClass('active')
      @editor.getSession().setValue(@data.pages[$this.data('id')].content)

  updatePage: ->    
    page_content = @editor.getSession().getValue()
    $this = $('.pages .page.active')
    page_id = $this.data('id')
    @data.pages[page_id].content = page_content
    if @data.language == 'markdown'
      page_content = @converter.makeHtml(page_content)
    $this.html(page_content)

