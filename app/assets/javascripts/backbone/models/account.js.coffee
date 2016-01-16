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
