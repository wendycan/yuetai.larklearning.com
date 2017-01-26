Yuetai.Views.Notebooks ||= {}

class Yuetai.Views.Notebooks.IndexView extends Yuetai.Views.Base
  el: $('#main-content')

  events:
    'click .notebook .delete' : 'deleteNotebook'
    'click #import-btn' : 'importNotebooks'

  render: ->
    # @rm_nav()
    # @clearMsg()
    # @render_nav(@opts.section)
    @$el.html(_.template($('#t-notebooks').html())())
    # @notebooks = new Yuetai.Collections.Notebooks
    # @fetchNotebooks()
    @fetchUnImportedNotebooks()

  fetchUnImportedNotebooks: ->
    $.ajax({
      url: '/api/v1/notebooks/import',
      headers: {
        'Auth-Token': Yuetai.auth_token
      }
      success: (res) ->
        $('#unImported-num').text res.unread_emails
    });

  importNotebooks: ->
    $.ajax({
      url: '/api/v1/notebooks/import',
      type: 'PUT',
      headers: {
        'Auth-Token': Yuetai.auth_token
      }
      success: (res) =>
        alert('导入成功')
        setTimeout (-> window.location.reload()), 1000
    });

  # fetchNotebooks: ->
  #   @notebooks.fetch(
  #     success: =>
  #       @renderNotebooks()
  #       @renderPagination()
  #   )
  #
  # renderPagination: ->
  #   paginator = new Paginator
  #     collection: @notebooks
  #
  #   $("#paginator").html paginator.render().$el
  #   @listenTo @notebooks, "reset", =>
  #     @renderNotebooks()
  #
  # renderNotebooks: ->
  #   $('#notebooks').empty()
  #   @notebooks.each(@renderNotebook, @)
  #
  # renderNotebook: (notebook)->
  #   $('#notebooks').append(_.template($('#t-notebook').html())(notebook: notebook))
  #
  # deleteNotebook: (e)->
  #   $this = $(e.currentTarget).parents('li.notebook')
  #   notebook = @notebooks.get(parseInt($this.data('id')))
  #   if confirm('确定删除选中此博客？')
  #     notebook.destroy(
  #       success: =>
  #         $this.remove()
  #     )
