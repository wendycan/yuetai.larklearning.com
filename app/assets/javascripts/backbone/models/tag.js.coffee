class Yuetai.Models.Tag extends Backbone.Model
  defaults:
    name: ""
    desc: ""
    id : ""
  idAttribute: "id"

  articles: ->
    return @_articles if !!@_articles
    @_articles = new Yuetai.Collections.Articles
    @_articles.url = "#{@url()}/articles"
    return @_articles

class Yuetai.Collections.Tags extends Backbone.Collection
  model: Yuetai.Models.Tag
  url: "#{Yuetai.ApiPrefix}/tags"

  sync: Yuetai.Common.api_sync

  initialize: ->
    @unsync = true
    mute_unsync = ->
      @unsync = false
    @once('sync', mute_unsync, @)
