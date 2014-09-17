Yuetai.Views.Authors ||= {}

class Yuetai.Views.Authors.ShowView extends Yuetai.Views.Base
  el: $('#main-content')

  render: ->
    # @rm_nav()
    # @clearMsg()
    @author = @authors.get(@opts.author_id)
    @$el.html(_.template($('#t-author-show').html())(author: @author.toJSON()))
