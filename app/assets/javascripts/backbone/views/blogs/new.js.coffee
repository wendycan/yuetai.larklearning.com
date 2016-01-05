Yuetai.Views.Blogs ||= {}

class Yuetai.Views.Blogs.NewView extends Yuetai.Views.Base
  el: $('#main-content')

  events:
    'submit #new-blog-form' : 'createBlog'
    'click .cancel' : 'navBack'

  renderAceEditor: ->
    @editor = ace.edit('blog-new-body')
    MarkdownMode = require("ace/mode/markdown").Mode
    HtmlMode = require("ace/mode/html").Mode

    @editor.setTheme("ace/theme/ambiance")
    @editor.getSession().setMode(new HtmlMode())
    @editor.setFontSize(18)
    @editor.renderer.setShowGutter(false)
    @editor.renderer.setPadding(10)
    @editor.renderer.setShowPrintMargin(false)

    _this = this

    $('#new-blog-form input[name=language]').change( ->
      if $(this).val() == 'markdown'
        _this.editor.getSession().setMode(new MarkdownMode())
      else
        _this.editor.getSession().setMode(new HtmlMode())
    )

  renderSimdEditor: ->
    toolbar = ['title', 'bold', 'italic', 'underline', 'strikethrough', 'fontScale', 'color', '|', 'ol', 'ul', 'blockquote', 'code', 'table', '|', 'link', 'image', 'hr', '|', 'indent', 'outdent', 'alignment']
    $('#blog-new-body').html('<textarea></textarea>')
    @editor = new Simditor
      textarea: $('#blog-new-body textarea')
      toolbar: toolbar

  checkWhichEditor: ->
    language = $('#new-blog-form input[name=language]:checked').val()
    if language is 'simditor'
      @renderSimdEditor()
    else
      @renderAceEditor()

  render: ->
    # @rm_nav()
    # @clearMsg()
    # @render_nav(@opts.section)
    @$el.html(_.template($('#t-blog-new').html())())
    @blogs = new Yuetai.Collections.Blogs

    type = @checkWhichEditor()

  getValue: ->
    if $('#new-blog-form input[name=language]:checked').val() is 'simditor'
      @editor.getValue()
    else
      @editor.getSession().getValue()

  createBlog: (e)->
    e.preventDefault()
    e.stopPropagation()
    data = {}
    data.title = @$(e.currentTarget).find('#blog-title').val()
    data.body = @getValue()
    data.tag_id = @$(e.currentTarget).find('#blog-tag').val()
    data.user_id = @account.id
    data.newbl = @$(e.currentTarget).find('#newbl').val()
    data.template = 'blog'
    data.language = @$(e.currentTarget).find('input[name=language]:checked').val()
    @blogs.create data
    , success: ->
      window.location.href = '#blogs'
