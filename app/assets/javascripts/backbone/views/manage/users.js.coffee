Yuetai.Views.Manage ||= {}

class Yuetai.Views.Manage.UsersView extends Yuetai.Views.Base
  el: $('#main-content')

  events:
    'click .tag-edit' : 'editTag'

  render: ->
    @$el.html(_.template($('#t-manage-users').html())())

