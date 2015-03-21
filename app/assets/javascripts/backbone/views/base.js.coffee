class Yuetai.Views.Base extends Backbone.View

  initialize: (router, opts = {})->
    @router = router
    @account = router.account
    @opts = opts

    if @account.get('unsync')
      @account.fetch_account(
        success: (data)=>
          Yuetai.auth_token = @account.get('auth_token')
          # $('.top-bar a.user-section').html(@account.get('email'))
          @render()
        error: ->
          window.location.href = '/user/sign_in'
      )
    else
      Yuetai.auth_token = @account.get('auth_token')
      @render()

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

  handleDate: (date)->
    d = new Date(date)
    d_s = "#{d.getHours()}:#{d.getMinutes()}-#{d.getMonth() + 1}月#{d.getDate()}日-#{d.getFullYear()}年"
    d_s

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
