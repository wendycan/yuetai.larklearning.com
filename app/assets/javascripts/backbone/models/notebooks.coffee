class Yuetai.Models.Notebook extends Backbone.Model
  defaults:
    title: ""
    authors: ""
    citation : ""
    notes: []
    id : ""

  sync: Yuetai.Common.api_sync

  urlRoot: "#{Yuetai.ApiPrefix}/notebooks"

  idAttribute: "id"

class Yuetai.Collections.Notebooks extends Backbone.PageableCollection
  model: Yuetai.Models.Notebook
  url: "#{Yuetai.ApiPrefix}/notebooks"

  sync: Yuetai.Common.api_sync
  state:
    pageSize: 10

  parseState: (resp, queryParams, state, options)->
    totalRecords: resp.total_entries
    totalPages: resp.total_pages

  parseRecords: (resp, options)->
    resp.notebooks

  initialize: ->
    @unsync = true
    mute_unsync = ->
      @unsync = false
    @once('sync', mute_unsync, @)
