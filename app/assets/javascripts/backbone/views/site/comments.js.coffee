Yuetai.Views.Comments ||= {}

class Yuetai.Views.Comments.CommentsView extends Yuetai.Views.Base
  el: $('#content')

  events:
    'submit #comment-form form' : 'submitForm'
    'click .remove-btn' : 'removeComment'

  initialize: (opts)->
    @currentUser = opts.currentUser
    @article = opts.article
    @comments = new Yuetai.Collections.Comments(opts.comments)
    @renderNewComment()
    @renderComments()

  renderComments: ->
    $('#comments').empty()
    @comments.each((comment)=> @renderComment(comment.toJSON()))

  renderNewComment: ->
    if @currentUser
      $('#comment-form').html(_.template($('#t-comment-form').html())(@currentUser))
    else
      $('#comment-form').html(_.template($('#t-comment-form-empty').html())())

  renderComment: (comment)->
    comment = comment
    comment.date = jQuery.timeago(comment.created_at)
    comment.current_user_id = @currentUser.id
    $('#comments').prepend(_.template($('#t-comment').html())(comment))

  submitForm: (e)->
    e.preventDefault()
    $form =  $(e.currentTarget)
    $textarea = $form.find('textarea')
    text = $textarea.val()
    if !text then return
    $.ajax
      url: "#{Yuetai.ApiPrefix}/articles/#{@article.id}/comments"
      type: 'POST'
      headers:
        'Auth-Token': @currentUser.authentication_token
      data:
        text: text
      success: (data)=>
        @renderComment(data.comment)
        $textarea.val('')

  removeComment: (e)->
    $comment = $(e.currentTarget).closest('.comment')
    commentId = $comment.data 'id'
    status = confirm('确定删除这条评论？')
    if status
      $.ajax
        url: "#{Yuetai.ApiPrefix}/articles/#{@article.id}/comments/#{commentId}"
        type: 'DELETE'
        headers:
          'Auth-Token': @currentUser.authentication_token
        success: (data)=>
          $comment.remove()
