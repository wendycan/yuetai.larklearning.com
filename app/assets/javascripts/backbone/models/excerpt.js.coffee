class Yuetai.Models.Excerpt extends Backbone.Model
  defaults:
    id : ""
    body: ""
    book_id: ""
    author_id: ""
    created_at: ""
    updated_at: ""

  idAttribute: "id"

class Yuetai.Collections.Excerpts extends Backbone.Collection
  model: Yuetai.Models.Excerpt
  url: "#{Yuetai.ApiPrefix}/excerpts"

  sync: Yuetai.Common.api_sync

  initialize: ->
    @unsync = true
    mute_unsync = ->
      @unsync = false
    @once('sync', mute_unsync, @)
