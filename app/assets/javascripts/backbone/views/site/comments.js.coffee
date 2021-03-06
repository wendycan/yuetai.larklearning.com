Yuetai.Views.Comments ||= {}

class Yuetai.Views.Comments.CommentsView extends Yuetai.Views.Base
  el: $('#content')

  events:
    'submit #comment-form form' : 'submitForm'
    'submit .comment-body form' : 'updateForm'
    'click .remove-btn' : 'removeComment'
    'click .edit-btn' : 'editComment'
    'click .cancel-edit-btn' : 'cancelEdit'
    'click .at-user-btn' : 'toggleUserList'
    'click #at-user-list li' : 'selectAtUser'

  initialize: (opts)->
    @currentUser = opts.currentUser
    @article = opts.article
    @comments = new Yuetai.Collections.Comments(opts.comments)
    @renderAtUserList()
    @renderNewComment()
    @renderComments()

  toggleUserList: ->
    $('#at-user-list').toggle()

  selectAtUser: (e)->
    $form = $(e.currentTarget).closest('.comment-form')
    $textarea = $form.find('textarea')
    value = $textarea.val()
    name = $(e.currentTarget).text()
    if value.length > 0
      value += ' @#{name} '
    else
      value += "@#{name} "
    $textarea.val(value)
    $textarea.focus()

  renderAtUserList: ->
    $.ajax
      url: "#{Yuetai.ApiPrefix}/articles/#{@article.id}/comment_users"
      type: 'GET'
      success: (users)=>
        for user in users
          @renderAtUser(user)

  renderAtUser: (user)->
    if @currentUser && (user == @currentUser.username) then return
    $('#at-user-list').append("<li>#{user}</li>")

  renderComments: ->
    $('#comments').empty()
    @comments.each((comment)=> @renderComment(comment.toJSON()))

  renderNewComment: ->
    if @currentUser
      $('#comment-form').html(_.template($('#t-comment-form').html())(Object.assign({}, @currentUser, {text: ''})))
    else
      $('#comment-form').html(_.template($('#t-comment-form-empty').html())())

  renderComment: (comment)->
    comment = comment
    comment.date = jQuery.timeago(comment.created_at)
    comment.current_user_id = @currentUser && @currentUser.id
    text = comment.text
    username = text.match(/@[\w\d_\u4e00-\u9fa5]+/)
    comment.text = text.replace(/@[\w\d_\u4e00-\u9fa5]+/, "<span>#{username}</span>")
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

  editComment: (e)->
    $comment = $(e.currentTarget).closest('.comment')
    commentId = $comment.data 'id'
    text = $comment.find('.comment-body .text').text()
    $comment.find('.comment-body .text').hide()
    $comment.find('.comment-body .comment-edit').show().html(_.template($('#t-comment-edit-form').html())({
      text: text
    }))

  cancelEdit: (e)->
    $(e.currentTarget).closest('.comment-edit').hide()
    $(e.currentTarget).closest('.comment-body').find('.text').show()

  updateForm: (e)->
    e.preventDefault()
    $comment = $(e.currentTarget).closest('.comment')
    commentId = $comment.data('id')
    text = $(e.currentTarget).find('textarea').val()
    if !text then return
    $.ajax
      url: "#{Yuetai.ApiPrefix}/articles/#{@article.id}/comments/#{commentId}"
      type: 'PUT'
      headers:
        'Auth-Token': @currentUser.authentication_token
      data:
        text: text
      success: (data)=>
        $comment.find('.comment-body .comment-edit').hide()
        $comment.find('.comment-body .text').text(text).show()
