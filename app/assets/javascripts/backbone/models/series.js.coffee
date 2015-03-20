class Yuetai.Models.Series extends Backbone.Model
  defaults:
    title: ""
    body: ""
    id : ""
    tag_id: ""
    user_id: ""

  sync: Yuetai.Common.api_sync

  urlRoot: "#{Yuetai.ApiPrefix}/blogs"

  idAttribute: "id"

class Yuetai.Collections.Series extends Backbone.Collection
  model: Yuetai.Models.Series
  url: "#{Yuetai.ApiPrefix}/series"

  sync: Yuetai.Common.api_sync

  initialize: ->
    @unsync = true
    mute_unsync = ->
      @unsync = false
    @once('sync', mute_unsync, @)
