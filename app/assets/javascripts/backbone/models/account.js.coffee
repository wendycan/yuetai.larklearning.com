class Yuetai.Models.Account extends Backbone.Model
  defaults:
    email: ''
    password: true
    auth_token: ''
    unsync: true
    username: ''

  sync: Yuetai.Common.api_sync

  urlRoot: "#{Yuetai.ApiPrefix}/users"

  fetch_account: (opts)->
    success = opts.success
    _this = this
    $.ajax(
      url: '/dashboard/index.json'
      success: (data, status, xhr)->
        data.unsync = false
        _this.set(data)
        if (success)
          success(data, status, xhr)
    )


class Yuetai.Collections.Accounts extends Backbone.PageableCollection
  model: Yuetai.Models.Account
  url: "#{Yuetai.ApiPrefix}/users"

  sync: Yuetai.Common.api_sync

  state:
    pageSize: 10

  parseState: (resp, queryParams, state, options)->
    totalRecords: resp.total_entries
    totalPages: resp.total_pages

  parseRecords: (resp, options)->
    resp.users

  initialize: ->
    @unsync = true
    mute_unsync = ->
      @unsync = false
    @once('sync', mute_unsync, @)
