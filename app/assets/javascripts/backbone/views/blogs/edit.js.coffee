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

  fetchBlog: ->
    toolbar = ['title', 'bold', 'italic', 'underline', 'strikethrough', 'fontScale', 'color', '|', 'ol', 'ul', 'blockquote', 'code', 'table', '|', 'link', 'image', 'hr', '|', 'indent', 'outdent', 'alignment']
    @blog.fetch
      success: =>
        _this = this
        @$el.html(_.template($('#t-blog-edit').html())(blog: @blog.toJSON()))
        @editor = new Simditor
          textarea: $('#blog-edit-body')
          toolbar: toolbar
        @editor.setValue(@blog.get('body'))

  updateBlog: (e)->
    e.preventDefault()
    e.stopPropagation()
    data = {}
    data.title = @$(e.currentTarget).find('#blog-title').val()
    data.body = @editor.getValue();
    data.tag_id = @$(e.currentTarget).find('#blog-tag').val()
    data.user_id = @account.id
    data.template = 'blog'
    @blog.save data
    , success: ->
      window.location.href = '#blogs'
