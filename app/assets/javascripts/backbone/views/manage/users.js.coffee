Yuetai.Views.Manage ||= {}

class Yuetai.Views.Manage.UsersView extends Yuetai.Views.Base
  el: $('#main-content')

  events:
    'click .tag-edit' : 'editTag'

  render: ->
    @users = new Yuetai.Collections.Accounts
    @fetchUser()

  fetchUser: ->
    @users.fetch
      success: =>
        @$el.html _.template($('#t-manage-users').html())({users_count: @users.state.totalRecords})
        $('.users-nav').addClass('active').siblings().removeClass('active')
        @renderUsers()
        @renderPagination()

  renderPagination: ()->
    paginator = new Paginator
      collection: @users

    $("#paginator").html paginator.render().$el
    @listenTo @users, "reset", =>
      @renderUsers()

  renderUsers: ->
    $(@el).find('tbody').empty()
    @users.each @renderUser, @

  renderUser: (user, i)->
    html = _.template($('#t-manage-user').html()) _.extend(user.toJSON(), {index: i+1})
    $(@el).find('tbody').append html
