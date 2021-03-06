Yuetai.Views.Blogs ||= {}

class Yuetai.Views.Blogs.NewView extends Yuetai.Views.Base
  el: $('#main-content')

  events:
    'submit #new-blog-form' : 'createBlog'
    'click .cancel' : 'navBack'
    'click .tags-content .label' : 'selectTag'

  renderSimdEditor: ->
    toolbar = ['title', 'bold', 'italic', 'underline', 'strikethrough', 'fontScale', 'color', '|', 'ol', 'ul', 'blockquote', 'code', 'table', '|', 'link', 'image', 'hr', '|', 'indent', 'outdent', 'alignment']
    language = [
      { name: 'Bash', value: 'bash' }
      { name: 'C++', value: 'c++' }
      { name: 'C#', value: 'cs' }
      { name: 'CSS', value: 'css' }
      { name: 'Erlang', value: 'erlang' }
      { name: 'Less', value: 'less' }
      { name: 'Sass', value: 'sass' }
      { name: 'Diff', value: 'diff' }
      { name: 'CoffeeScript', value: 'coffeescript' }
      { name: 'HTML,XML', value: 'html' }
      { name: 'JSON', value: 'json' }
      { name: 'Java', value: 'java' }
      { name: 'JavaScript', value: 'js' }
      { name: 'Markdown', value: 'markdown' }
      { name: 'Objective C', value: 'objc' }
      { name: 'PHP', value: 'php' }
      { name: 'Perl', value: 'parl' }
      { name: 'Python', value: 'python' }
      { name: 'Ruby', value: 'ruby' }
      { name: 'SQL', value: 'sql'}
    ]
    @editor = new Simditor
      textarea: $('#blog-new-body')
      toolbar: toolbar
      language: language
      upload:
        url: '/api/v1/blogs/upload'
        params: null
        fileKey: 'upload_file'
        connectionCount: 3
        leaveConfirm: '正在上传中，确定离开?'

  render: ->
    @tags = new Yuetai.Collections.Tags
    @fetchTags()
    @$el.html(_.template($('#t-blog-new').html())())
    @blogs = new Yuetai.Collections.Blogs
    @renderSimdEditor()

  fetchTags: ->
    @tags.fetch
      data:
        all: true
      success: (cols, tags)=>
        @$el.find('.tags-content').empty()
        for tag in tags
          @renderTag(tag)

  renderTag: (tag)->
    @$el.find('.tags-content').append _.template($('#t-blog-tag').html())(tag)

  selectTag: (e)->
    $(e.currentTarget).toggleClass('active')

  getValue: ->
    @editor.getValue()

  createBlog: (e)->
    e.preventDefault()
    e.stopPropagation()
    tag_list = []
    @$(e.currentTarget).find('.tags-content .label.active').each ->
      tag_list.push $(this).text()
    data = {}
    data.title = @$(e.currentTarget).find('#blog-title').val()
    data.body = @getValue()
    data.tag_list = tag_list.join(',')
    data.user_id = @account.id
    data.newbl = @$(e.currentTarget).find('#newbl').val()
    data.template = 'blog'
    data.language = 'simditor'
    @blogs.create data
    , success: ->
      window.location.href = '#blogs'
