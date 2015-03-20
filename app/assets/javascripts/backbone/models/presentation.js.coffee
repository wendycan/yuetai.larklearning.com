class Yuetai.Models.Presentation extends Backbone.Model
  defaults:
    title: ""
    body: ""
    id : ""
    tag_id: ""
    user_id: ""

  sync: Yuetai.Common.api_sync

  urlRoot: "#{Yuetai.ApiPrefix}/presentations"

  idAttribute: "id"

  isNew: ->
    !!@get('newpr')

class Yuetai.Collections.Presentations extends Backbone.Collection
  model: Yuetai.Models.Presentation
  url: "#{Yuetai.ApiPrefix}/presentations"

  sync: Yuetai.Common.api_sync

  initialize: ->
    @unsync = true
    mute_unsync = ->
      @unsync = false
    @once('sync', mute_unsync, @)
