Yuetai.Views.Authors ||= {}

class Yuetai.Views.Authors.ShowView extends Yuetai.Views.Base
  el: $('#main-content')

  render: ->
    # @rm_nav()
    # @clearMsg()
    @render_nav(@opts.section)
    @author = @authors.get(@opts.author_id)
    if !@author
      @author = ''
    @$el.html(_.template($('#t-author-show').html())(author: @author))
