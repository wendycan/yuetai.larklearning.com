class Yuetai.Models.Author extends Backbone.Model
  defaults:
    name: ""
    email: ""
    desc: ""
    id : ""
  idAttribute: "id"

class Yuetai.Collections.Authors extends Backbone.Collection
  model: Yuetai.Models.Author
  url: "#{Yuetai.ApiPrefix}/authors"

  sync: Yuetai.Common.api_sync

  initialize: ->
    @unsync = true
    mute_unsync = ->
      @unsync = false
    @once('sync', mute_unsync, @)
