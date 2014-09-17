#= require_self
#= require_tree ./common
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.Yuetai =
  Common: {}
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  ApiPrefix: "/apis/v1"
  ajax: (settings = {})->
    opts =
      crossDomain: true
    $.ajax(_.extend(opts, settings))

_.templateSettings =
  escape: /\{\{-([\s\S]+?)\}\}/g
  interpolate: /\{\{=([\s\S]+?)\}\}/g
  evaluate: /\{\{([\s\S]+?)\}\}/g
