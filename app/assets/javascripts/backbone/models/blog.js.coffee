class Yuetai.Models.Blog extends Backbone.Model
  defaults:
    title: ""
    body: ""
    id : ""
    tag_list: ""
    user_id: ""
    visited_count: ""

  sync: Yuetai.Common.api_sync

  urlRoot: "#{Yuetai.ApiPrefix}/blogs"

  idAttribute: "id"

  isNew: ->
    !!@get('newbl')

class Yuetai.Collections.Blogs extends Backbone.PageableCollection
  model: Yuetai.Models.Blog
  url: "#{Yuetai.ApiPrefix}/blogs"

  sync: Yuetai.Common.api_sync

  state:
    pageSize: 10

  parseState: (resp, queryParams, state, options)->
    totalRecords: resp.total_entries
    totalPages: resp.total_pages

  parseRecords: (resp, options)->
    resp.blogs

  initialize: ->
    @unsync = true
    mute_unsync = ->
      @unsync = false
    @once('sync', mute_unsync, @)
