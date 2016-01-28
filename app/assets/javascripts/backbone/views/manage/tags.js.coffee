Yuetai.Views.Manage ||= {}

class Yuetai.Views.Manage.TagsView extends Yuetai.Views.Base
  el: $('#main-content')

  events:
    'click .tag-edit' : 'editTag'
    'click .tag-remove' : 'removeTag'
    'click .tag-save' : 'saveTag'

  render: ->
    @$el.html(_.template($('#t-manage-tags').html())())
    @tags = new Yuetai.Collections.Tags
    @fetchTags()

  editTag: ->

  removeTag: ->

  saveTag: ->

  fetchTags: ->
    @tags.fetch
      success: =>
        @renderTags()

  renderTags: ->
    @tags.each @renderTag, @

  renderTag: (tag, i)->
    html = _.template($('#t-manage-tag').html()) _.extend(tag.toJSON(), {index: i+1})
    $(@el).find('tbody').append html

  createTag: ->

  deleteTag: ->

