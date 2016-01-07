class Yuetai.Models.Blog extends Backbone.Model
  defaults:
    title: ""
    body: ""
    id : ""
    tag_list: ""
    user_id: ""

  sync: Yuetai.Common.api_sync

  urlRoot: "#{Yuetai.ApiPrefix}/blogs"

  idAttribute: "id"

  isNew: ->
    !!@get('newbl')

class Yuetai.Collections.Blogs extends Backbone.Collection
  model: Yuetai.Models.Blog
  url: "#{Yuetai.ApiPrefix}/blogs"

  sync: Yuetai.Common.api_sync

  initialize: ->
    @unsync = true
    mute_unsync = ->
      @unsync = false
    @once('sync', mute_unsync, @)
