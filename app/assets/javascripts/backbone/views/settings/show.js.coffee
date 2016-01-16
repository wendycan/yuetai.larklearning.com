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
    @$el.html(_.template($('#t-settings-show').html())(@account.toJSON()))
