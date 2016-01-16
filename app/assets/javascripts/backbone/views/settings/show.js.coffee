Yuetai.Views.Settings ||= {}

class Yuetai.Views.Settings.ShowView extends Yuetai.Views.Base
  el: $('#main-content')

  events:
    'submit #user-setting' : 'updateUser'

  render: ->
    # @rm_nav()
    # @clearMsg()
    # @render_nav(@opts.section)
    level_name = '普通用户'
    switch @account.get('level')
      when 2
        level_name = '高级用户'
      when 1
        level_name = '中级用户'
    data = @account.toJSON()
    data.level_name = level_name
    @$el.html(_.template($('#t-settings-show').html())(data))

  updateUser: (e)->
    form = $(e.currentTarget)
    data = {
      username: form.find('#username').val()
      desc: form.find('#desc').val()
      github: form.find('#github').val()
      webchat: form.find('#webchat').val()
      email: form.find('#email').val()
      avator: form.find('#avator').val()
    }
    @account.save data
    , success: ->
        alertify.success('保存成功。')
      error: ->
        alertify.error('保存失败，稍后重试。')
