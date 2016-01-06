Yuetai.Views.Blogs ||= {}

class Yuetai.Views.Blogs.NewView extends Yuetai.Views.Base
  el: $('#main-content')

  events:
    'submit #new-blog-form' : 'createBlog'
    'click .cancel' : 'navBack'

  renderSimdEditor: ->
    toolbar = ['title', 'bold', 'italic', 'underline', 'strikethrough', 'fontScale', 'color', '|', 'ol', 'ul', 'blockquote', 'code', 'table', '|', 'link', 'image', 'hr', '|', 'indent', 'outdent', 'alignment']
    $('#blog-new-body').html('<textarea></textarea>')
    @editor = new Simditor
      textarea: $('#blog-new-body textarea')
      toolbar: toolbar

  render: ->
    # @rm_nav()
    # @clearMsg()
    # @render_nav(@opts.section)
    @$el.html(_.template($('#t-blog-new').html())())
    @blogs = new Yuetai.Collections.Blogs
    @renderSimdEditor()

  getValue: ->
    @editor.getValue()

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
    data.language = 'simditor'
    @blogs.create data
    , success: ->
      window.location.href = '#blogs'
