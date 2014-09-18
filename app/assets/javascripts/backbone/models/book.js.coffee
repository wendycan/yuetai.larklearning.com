class Yuetai.Models.Book extends Backbone.Model
  defaults:
    name: ""
    desc: ""
    id : ""
  idAttribute: "id"

  excerpts: ->
    return @_excerpts if !!@_excerpts
    @_excerpts = new Yuetai.Collections.Excerpts
    @_excerpts.url = "#{@url()}/excerpts"
    return @_excerpts

class Yuetai.Collections.Books extends Backbone.Collection
  model: Yuetai.Models.Book
  url: "#{Yuetai.ApiPrefix}/books"

  sync: Yuetai.Common.api_sync

  initialize: ->
    @unsync = true
    mute_unsync = ->
      @unsync = false
    @once('sync', mute_unsync, @)
