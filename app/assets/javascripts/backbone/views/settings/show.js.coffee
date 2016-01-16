Yuetai.Views.Settings ||= {}

class Yuetai.Views.Settings.ShowView extends Yuetai.Views.Base
  el: $('#main-content')

  events:
    'click .cancel' : 'navBack'
    'click .delete-article' : 'deleteArticle'

  render: ->
    # @rm_nav()
    # @clearMsg()
    # @render_nav(@opts.section)
    console.log @account.toJSON()
    level_name = '普通用户'
    switch @account.get('level')
      when 2
        level_name = '高级用户'
      when 1
        level_name = '中级用户'
    data = @account.toJSON()
    data.level_name = level_name
    @$el.html(_.template($('#t-settings-show').html())(data))
