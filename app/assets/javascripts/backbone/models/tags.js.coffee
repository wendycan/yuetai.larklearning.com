class Yuetai.Models.Tag extends Backbone.Model
  defaults:
    id : ""
    name: ""
    created_at: ""

  sync: Yuetai.Common.api_sync

  urlRoot: "#{Yuetai.ApiPrefix}/tags"

  idAttribute: "id"

  isNew: ->
    !!@get('newbl')

class Yuetai.Collections.Tags extends Backbone.Collection
  model: Yuetai.Models.Tag
  url: "#{Yuetai.ApiPrefix}/tags"

  sync: Yuetai.Common.api_sync

  initialize: ->
    @unsync = true
    mute_unsync = ->
      @unsync = false
    @once('sync', mute_unsync, @)
