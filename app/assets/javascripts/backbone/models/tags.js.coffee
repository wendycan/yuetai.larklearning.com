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

class Yuetai.Collections.Tags extends Backbone.PageableCollection
  model: Yuetai.Models.Tag
  url: "#{Yuetai.ApiPrefix}/tags"

  sync: Yuetai.Common.api_sync
  state:
    pageSize: 10

  queryParams:
    q: ''

  # parseState: (resp, queryParams, state, options)->
  #   console.log resp
  #   totalRecords: resp.info.total
  #   totalPages: resp.info.total_pages

  # parseRecords: (resp, options)->
  #   docs = []
  #   for r in resp.records
  #     docs.push r.document
  #   docs

  initialize: ->
    @unsync = true
    mute_unsync = ->
      @unsync = false
    @once('sync', mute_unsync, @)
