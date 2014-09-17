class Yuetai.Models.Article extends Backbone.Model
  defaults:
    name: ""
    body: ""
    id : ""
    tag_id: ""
    author_id: ""

  idAttribute: "id"

class Yuetai.Collections.Articles extends Backbone.Collection
  model: Yuetai.Models.Article
  url: "#{Yuetai.ApiPrefix}/articles"

  sync: Yuetai.Common.api_sync

  initialize: ->
    @unsync = true
    mute_unsync = ->
      @unsync = false
    @once('sync', mute_unsync, @)
