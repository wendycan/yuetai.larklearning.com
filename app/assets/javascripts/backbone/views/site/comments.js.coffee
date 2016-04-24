Yuetai.Views.Comments ||= {}

class Yuetai.Views.Comments.CommentsView extends Yuetai.Views.Base
  el: $('#content')

  initialize: (opts)->
    @currentUser = opts.currentUser
    @comments = new Yuetai.Collections.Comments(opts.comments)
    @renderNewComment()
    @renderComments()

  renderComments: ->
    $('#comments').empty()
    @comments.each(@renderComment, @)

  renderNewComment: ->
    if @currentUser
      $('#comment-form').html(_.template($('#t-comment-form').html())(@currentUser))
    else
      $('#comment-form').html(_.template($('#t-comment-form-empty').html())())

  renderComment: (comment)->
    comment = comment.toJSON()
    comment.date = jQuery.timeago(comment.created_at)
    $('#comments').append(_.template($('#t-comment').html())(comment))
