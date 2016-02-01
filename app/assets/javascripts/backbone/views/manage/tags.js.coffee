Yuetai.Views.Manage ||= {}

class Yuetai.Views.Manage.TagsView extends Yuetai.Views.Base
  el: $('#main-content')

  events:
    'click .tag-edit' : 'editTag'
    'click .tag-remove' : 'removeTag'
    'click .tag-save' : 'saveTag'
    'click .add-tag' : 'toggleAddTag'
    'submit .header-nav-right-popup form' : 'createTag'

  render: ->
    $('.tags-nav').addClass('active').siblings().removeClass('active')
    @tags = new Yuetai.Collections.Tags
    @fetchTags()

  renderPagination: ()->
    paginator = new Paginator
      collection: @tags

    $("#paginator").html paginator.render().$el
    @listenTo @tags, "reset", =>
      @renderTags()

  toggleAddTag: ->
    $('.header-nav-right-popup').toggle()

  editTag: ->

  removeTag: (e)->
    alertify.confirm '确定删除这个标签？', (isOk)=>
      if isOk
        $tr = $(e.currentTarget).closest('tr')
        tag_id = $tr.data('tag-id')
        tag = @tags.findWhere({id: tag_id})
        tag.destroy
          success: ->
            $tr.remove()
            alertify.success('删除成功')


  saveTag: ->

  fetchTags: ->
    @tags.fetch
      success: =>
        @$el.html _.template($('#t-manage-tags').html())({tags_count: @tags.state.totalRecords})
        @renderTags()
        @renderPagination()

  renderTags: ->
    $(@el).find('tbody').empty()
    @tags.each (tag, i)=>
      @renderTag tag, i

  renderTag: (tag, i, isForward)->
    html = _.template($('#t-manage-tag').html()) _.extend(tag.toJSON(), {index: i + 1})
    if isForward
      $(@el).find('tbody').prepend html
    else
      $(@el).find('tbody').append html

  createTag: (e)->
    e.preventDefault()
    value = $(e.currentTarget).find('[name=name]').val()
    if !value then return
    data = {
      name: value
      newbl: $(e.currentTarget).find('#newbl').val()
    }
    @tags.create data,
      success: (tag)=>
        @renderTag(tag, @tags.length - 1, true)
        @toggleAddTag()
        $(e.currentTarget).find('[name=name]').val('')

  deleteTag: ->

