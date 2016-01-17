Yuetai.Views.Settings ||= {}

class Yuetai.Views.Settings.ShowView extends Yuetai.Views.Base
  el: $('#main-content')

  events:
    'submit #user-setting' : 'updateUser'
    'change #webchat' : 'updateWebchat'
    'change #avator' : 'updateAvator'

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
      webchat: form.find('.settings-webchat img').attr('src')
      email: form.find('#email').val()
      avator: form.find('.settings-avator img').attr('src')
    }
    @account.save data
    , success: ->
        alertify.success('保存成功。')
      error: ->
        alertify.error('保存失败，稍后重试。')

  updateWebchat: (e)->
    file = e.currentTarget.files[0]
    @uploadImg(file, $('.settings-webchat img'))

  updateAvator: (e)->
    file = e.currentTarget.files[0]
    @uploadImg(file, $('.settings-avator img'))

  uploadImg: (file, elImg)->
    formData = new FormData()
    formData.append('upload_file', file)
    $.ajax
      type: 'POST'
      url: "/api/v1/upload"
      data: formData
      processData: false
      contentType: false
      headers:
        'Auth-Token': @account.get('auth_token')
      success: (data)->
        elImg.attr('src', data.file_path)
