class Yuetai.Views.Base extends Backbone.View

  initialize: (router, @opts = {})->
    @router = router
    @books = router.books
    @opts = opts
    @initBooks()
    # if @account.get('unsync')
    #   @account.fetch_account(
    #     success: (data)=>
    #       @auth_token = @account.get('token')
    #       $('.top-bar a.user-section').html(@account.get('email'))
    #       @render() if @opts.calevel is 'account'
    #       @initEngines()
    #     error: ->
    #       window.location.href = '/login'
    #   )
    # else
    #   @auth_token = @account.get('token')
    #   @render() if @opts.calevel is 'account'
    #   @initEngines()

  initBooks: ->
    if @books.unsync
      @books.fetch(
        headers:
          'Authorization' : "token #{@auth_token}"
        success: (books)=>
          # if @opts.engine_name
          #   @engine = @books.get(@opts.engine_name)
          #   if !!@engine
          #     @initDomains()
          #     @initDocuments()
          #   else
          #     @alertMsg('warning', 'Engine Not Found')
          #     return
          @render() if @opts.calevel is 'books'
        error: (books, resp)=>
          @alertMsg('warning', resp.responseText)
      )
    else
      # if @opts.engine_name
      #   @engine = @engines.get(@opts.engine_name)
      #   if !!@engine
      #     @initDomains()
      #     @initDocuments()
      #   else
      #     @alertMsg('warning', 'Engine Not Found')
      #     return
      @render() if @opts.calevel is 'books'

  initDomains: ->
    @domains = @engine.domains()
    if @domains.unsync
      @domains.fetch(
        headers:
          'Authorization' : "token #{@auth_token}"
        success: (domains)=>
          @render() if @opts.calevel is 'domains'
        error: (domains, resp)=>
          @alertMsg('warning', resp.responseText)
      )
    else
      @render() if @opts.calevel is 'domains'

  initDocuments: ->
    @documents = @engine.documents()
    if @documents.unsync
      @documents.fetch(
        headers:
          'Authorization' : "token #{@auth_token}"
        success: (documents)=>
          @render() if @opts.calevel is 'documents'
        error: (documents, resp)=>
          if resp.status is 404
            @render() if @opts.calevel is 'documents'
          else
            @alertMsg('warning', resp.responseText)
      )
    else
      @render() if @opts.calevel is 'documents'

  render_nav: (current_section)->
    $('#main-nav').html(_.template($('#t-subnav').html())({engine: @engine.toJSON()}))
    $('.sub-nav dd').removeClass('active')
    $(".sub-nav .#{current_section}").addClass('active')

  rm_nav: ->
    $('.alert-container').empty()
    $('#main-nav').empty()

  handleError: (form, error)->
    form.find('label').removeClass('error')
    form.find('small').removeClass('error')
    form.find('small').text('')
    _.each(error,
          (v, k)=>
            if v instanceof Array
              msg = v.join(',')
            else
              msg = v
            form.find(".attr-#{k} label").addClass('error')
            form.find(".attr-#{k} small").addClass('error')
            form.find(".attr-#{k} small").text(msg)
          )

  decodeArray: (arr_str)->
    _arr = arr_str.split(',')
    el.trim() for el in _arr

  encodeArray: (arr)->
    arr.join(',')

  alertMsg: (type, msg)->
    $('.alert-container').html(_.template($("#t-alert-#{type}").html())({msg: msg}))

  clearMsg: ->
    $('.alert-container').empty()

  navBack: (e)->
    e.preventDefault()
    e.stopPropagation()
    window.history.back()

  fetchData: (url_pst, fun, range, callback)->
    if !range
      range = 'day'
    url = "#{@engine.url()}/#{url_pst}"
    end = new Date()
    start = new Date()
    interval = 'hour'
    switch range
      when 'day'
        interval = 'hour'
        start = start.setDate(end.getDate() - 1)
      when 'week'
        interval = 'day'
        start = start.setDate(end.getDay() - 7)
      when 'month'
        interval = 'week'
        start = start.setMonth(end.getMonth() - 1)
      when 'quarter'
        start = start.setMonth(end.getMonth() - 3)
        interval = 'month'
      when 'year'
        start = start.setFullYear(end.getFullYear() - 1)
        interval = 'quarter'
    if fun == 'top'
      interval = 0
    Yuetai.ajax(
      url: url
      type: 'GET'
      data:
        start: start
        end: end.getTime()
        function: fun
        interval: interval
      headers:
        'Authorization' : "token #{@auth_token}"
      success: callback
    )
