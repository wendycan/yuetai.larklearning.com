class Yuetai.Models.Blog extends Backbone.Model
  defaults:
    title: ""
    body: ""
    id : ""
    tag_id: ""
    user_id: ""

  idAttribute: "id"

class Yuetai.Collections.Blogs extends Backbone.Collection
  model: Yuetai.Models.Blog
  url: "#{Yuetai.ApiPrefix}/blogs"

  sync: Yuetai.Common.api_sync

  initialize: ->
    @unsync = true
    mute_unsync = ->
      @unsync = false
    @once('sync', mute_unsync, @)
