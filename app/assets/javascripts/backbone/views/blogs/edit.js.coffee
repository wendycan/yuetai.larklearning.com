Yuetai.Views.Blogs ||= {}

class Yuetai.Views.Blogs.EditView extends Yuetai.Views.Base
  el: $('#main-content')

  events:
    'submit #edit-blog-form' : 'updateBlog'
    'click .cancel' : 'navBack'

  render: ->
    # @rm_nav()
    # @clearMsg()
    # @render_nav(@opts.section)
    @blog = new Yuetai.Models.Blog(id: @opts.blog_id)
    @converter = new Showdown.converter();
    @fetchBlog()
    console.log(blog)


  fetchBlog: ->
    @blog.fetch(
      success: =>
        _this = this
        @$el.html(_.template($('#t-blog-edit').html())(blog: @blog.toJSON()))

        @editor = ace.edit('blog-edit-body')
        MarkdownMode = require("ace/mode/markdown").Mode
        HtmlMode = require("ace/mode/html").Mode
        @editor.setTheme("ace/theme/ambiance")
        @editor.setFontSize(18)
        @editor.renderer.setShowGutter(false)
        @editor.renderer.setShowPrintMargin(false)

        if @blog.get('language') == 'markdown'
          @editor.getSession().setMode(new MarkdownMode())
          $('#edit-blog-form input#markdown').prop('checked', true)
        else
          @editor.getSession().setMode(new HtmlMode())
          $('#edit-blog-form input#html').prop('checked', true)

        @editor.getSession().setValue(@blog.get('body'))

        $('#edit-blog-form input[name=language]').change( ->
          if $(this).val() == 'markdown'
            _this.editor.getSession().setMode(new MarkdownMode())
          else
            _this.editor.getSession().setMode(new HtmlMode())
        )
    )

  updateBlog: (e)->
    e.preventDefault()
    e.stopPropagation()
    data = {}
    data.title = @$(e.currentTarget).find('#blog-title').val()
    # data.body = @converter.makeHtml(@editor.getSession().getValue());
    data.body = @editor.getSession().getValue();
    data.tag_id = @$(e.currentTarget).find('#blog-tag').val()
    data.user_id = @account.id
    data.template = 'blog'

    data.language = @$(e.currentTarget).find('input[name=language]:checked').val()
    @blog.save(data,
                  success: ->
                    window.location.href = '#blogs'
    )
