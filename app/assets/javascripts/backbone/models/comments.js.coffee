class Yuetai.Models.Comment extends Backbone.Model
  defaults:
    id : ""
    text: ""
    created_at: ""

  sync: Yuetai.Common.api_sync

  urlRoot: "#{Yuetai.ApiPrefix}/articles/#{70}/comments"

  idAttribute: "id"

  isNew: ->
    !!@get('newbl')

class Yuetai.Collections.Comments extends Backbone.PageableCollection
  model: Yuetai.Models.Comment
  url: "#{Yuetai.ApiPrefix}/articles/#{70}/comments"

  sync: Yuetai.Common.api_sync

  initialize: ->
    @unsync = true
    mute_unsync = ->
      @unsync = false
    @once('sync', mute_unsync, @)
