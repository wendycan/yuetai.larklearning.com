Yuetai.Views.Blogs ||= {}

class Yuetai.Views.Blogs.NewView extends Yuetai.Views.Base
  el: $('#main-content')

  events:
    'submit #new-blog-form' : 'createBlog'
    'click .cancel' : 'navBack'

  render: ->
    # @rm_nav()
    # @clearMsg()
    # @render_nav(@opts.section)
    @$el.html(_.template($('#t-blog-new').html())())

    @editor = ace.edit('blog-new-body')
    MarkdownMode = require("ace/mode/markdown").Mode
    @editor.setTheme("ace/theme/ambiance")
    @editor.getSession().setMode(new MarkdownMode())
    @converter = new Showdown.converter()
    @blogs = new Yuetai.Collections.Blogs

  createBlog: (e)->
    e.preventDefault()
    e.stopPropagation()
    data = {}
    data.title = @$(e.currentTarget).find('#blog-title').val()
    data.body = @editor.getSession().getValue();
    data.tag_id = @$(e.currentTarget).find('#blog-tag').val()
    data.user_id = @account.id
    data.newbl = @$(e.currentTarget).find('#newbl').val()
    data.template = 'blog'
    data.language = @$(e.currentTarget).find('input[name=language]:checked').val()
    @blogs.create(data,
                  success: ->
                    window.location.href = '#blogs'
    )
