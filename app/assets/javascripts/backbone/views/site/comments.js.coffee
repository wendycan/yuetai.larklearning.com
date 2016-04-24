Yuetai.Views.Comments ||= {}

class Yuetai.Views.Comments.CommentsView extends Backbone.View
  el: $('#comments')

  initialize: (opts)->
    @comments = new Yuetai.Collections.Comments(opts)
    @renderComments()

  renderComments: ->
    $('#comments').empty()
    @comments.each(@renderComment, @)

  renderComment: (comment)->
    comment = comment.toJSON()
    comment.date = jQuery.timeago(comment.created_at)
    $('#comments').append(_.template($('#t-comment').html())(comment))
