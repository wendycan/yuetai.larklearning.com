class Yuetai.Views.Base extends Backbone.View

  initialize: (router, @opts = {})->
    @router = router
    @books = router.books
    @articles = router.articles
    @tags = router.tags
    @authors = router.authors

    @opts = opts

    @initAuthors()

  initBooks: ->
    if @books.unsync
      @books.fetch(
        headers:
          'Authorization' : "token #{@auth_token}"
        success: (books)=>
          for book in @books.models
            excerpts = book.excerpts()
            @initExcerpts(excerpts)
          @render() if @opts.calevel is 'books'
        error: (books, resp)=>
          @alertMsg('warning', resp.responseText)
      )
    else
      @render() if @opts.calevel is 'books'
      @render() if @opts.calevel is 'excerpts'

  initExcerpts: (excerpts)->
    if excerpts.unsync
      excerpts.fetch(
        headers:
          'Authorization' : "token #{@auth_token}"
        success: (excerpts)=>
          @render() if @opts.calevel is 'excerpts'
        error: (excerpts, resp)=>
          @alertMsg('warning', resp.responseText)
      )
    else
      @render() if @opts.calevel is 'excerpts'

  initTagArticles: (articles)->
    if articles.unsync
      articles.fetch(
        headers:
          'Authorization' : "token #{@auth_token}"
        success: (articles)=>
          @render() if @opts.calevel is 'articles'
        error: (articles, resp)=>
          @alertMsg('warning', resp.responseText)
      )
    else
      @render() if @opts.calevel is 'articles'

  initArticles: ->
    if @articles.unsync
      @articles.fetch(
        headers:
          'Authorization' : "token #{@auth_token}"
        success: (articles)=>
          @render() if @opts.calevel is 'articles'
        error: (articles, resp)=>
          @alertMsg('warning', resp.responseText)
      )
    else
      @render() if @opts.calevel is 'articles'

  initTags: ->
    if @tags.unsync
      @tags.fetch(
        headers:
          'Authorization' : "token #{@auth_token}"
        success: (tags)=>
          @render() if @opts.calevel is 'tags'
          for tag in @tags.models
            articles = tag.articles()
            @initTagArticles(articles)
          @initArticles()
        error: (tags, resp)=>
          @alertMsg('warning', resp.responseText)
      )
    else
      @render() if @opts.calevel is 'tags'
      @initArticles()

  initAuthors: ->
    if @authors.unsync
      @authors.fetch(
        headers:
          'Authorization' : "token #{@auth_token}"
        success: (authors)=>
          @render() if @opts.calevel is 'authors'
          @initBooks()
          @initTags()
        error: (authors, resp)=>
          @alertMsg('warning', resp.responseText)
      )
    else
      @render() if @opts.calevel is 'authors'
      @initArticles()
      @initBooks()
      @initTags()

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
    $('.sidebar li').removeClass('active')
    $(".sidebar .#{current_section}").addClass('active')

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

  strip: (html)->
    tmp = document.createElement("DIV")
    tmp.innerHTML = html
    tmp.textContent || tmp.innerText || ""

  limit: (text, num)->
    if text.length >= num
      snip = text.substr(0,num)
      snip = snip.concat('...')
    else
      snip = text
    snip
