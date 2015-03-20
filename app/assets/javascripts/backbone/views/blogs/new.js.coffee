Yuetai.Views.Blogs ||= {}

class Yuetai.Views.Blogs.NewView extends Yuetai.Views.Base
  el: $('#main-content')

  events:
    'submit #new-blog-form' : 'createBlog'

  render: ->
    # @rm_nav()
    # @clearMsg()
    # @render_nav(@opts.section)
    @$el.html(_.template($('#t-blog-new').html())())
    @blogs = new Yuetai.Collections.Blogs

  createBlog: (e)->
    e.preventDefault()
    e.stopPropagation()
    data = {}
    data.title = @$(e.currentTarget).find('#blog-title').val()
    data.body = @$(e.currentTarget).find('#blog-body').val()
    data.tag_id = @$(e.currentTarget).find('#blog-tag').val()
    data.user_id = @account.id
    data.newbl = @$(e.currentTarget).find('#newbl').val()
    data.template = 'blog'
    @blogs.create(data,
                  success: ->
                    window.location.href = '#blogs'
    )
