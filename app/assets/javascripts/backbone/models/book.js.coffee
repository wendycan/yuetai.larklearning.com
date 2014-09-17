class Yuetai.Models.Book extends Backbone.Model
  defaults:
    name: ""
    desc: ""
    id : ""
  idAttribute: "id"
  # isNew: ->
  #   !!@get('neweg')

  # excerpts: ->
  #   return @_domains if !!@_domains
  #   @_domains = new Yuetai.Collections.Domains
  #   @_domains.url = "#{Yuetai.ApiPrefix}/engines/#{@id}/domains"
  #   return @_domains

  # documents: ->
  #   return @_documents if !!@_documents
  #   @_documents = new Yuetai.Collections.Documents
  #   @_documents.url = "#{Yuetai.ApiPrefix}/engines/#{@id}/collections/page/documents"
  #   return @_documents

class Yuetai.Collections.Books extends Backbone.Collection
  model: Yuetai.Models.Book
  url: "#{Yuetai.ApiPrefix}/books"

  sync: Yuetai.Common.api_sync

  initialize: ->
    @unsync = true
    mute_unsync = ->
      @unsync = false
    @once('sync', mute_unsync, @)
