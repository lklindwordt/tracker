###
codename:tracker login screen
###
class Login
  constructor: (@app) ->
    @createDOMFragment()
    @bindEventHandler()
    #

  # create DOM fragments for the login screen
  createDOMFragment: ->
    div = document.createElement 'div'
    div.id = 'trackerLogin'
    div.style.position = 'fixed'
    div.style.right = '0'
    div.style.top = '20%'
    div.style.background = '#cccccc'
    div.style.padding = '10px'

    usernameLabel = document.createElement 'span'
    usernameLabel.innerHTML = 'Username'
    @usernameInput = document.createElement 'input'
    @usernameInput.setAttribute 'type', 'text'
    @usernameInput.value = ''

    div.appendChild usernameLabel
    div.appendChild (document.createElement 'br')
    div.appendChild @usernameInput
    div.appendChild (document.createElement 'br')

    passwordLabel = document.createElement 'span'
    passwordLabel.innerHTML = 'Password'
    @passwordInput = document.createElement 'input'
    @passwordInput.setAttribute 'type', 'password'
    @passwordInput.value = ''

    div.appendChild passwordLabel
    div.appendChild (document.createElement 'br')
    div.appendChild @passwordInput
    div.appendChild (document.createElement 'br')

    @save = document.createElement 'input'
    @save.setAttribute 'type', 'button'
    @save.value = 'Login'
    div.appendChild @save

    document.getElementsByTagName("body")[0].appendChild div

  # bind event handler for login screen interaction
  bindEventHandler: ->
    @save.onclick = =>
      @authenticate()
      console.log "trying to login"

  #
  authenticate: =>
    params = "email=#{@usernameInput.value}&password=#{@passwordInput.value}"

    req = new XMLHttpRequest()
    req.open "POST", "http://tracker.dev/sessions.js", true

    req.setRequestHeader "Content-type", "application/x-www-form-urlencoded"

    req.onreadystatechange = =>
      if ( req.readyState == 4 )
        if ( req.status == 200 )
          obj = JSON.parse req.responseText
          if obj.success
            @app.authToken = escape(obj.authToken).replace '+', '%2B'
            @app.session = escape(obj.session)
            @app.displayMenu()
            console.log req.getAllResponseHeaders()
            console.log "successfully logged in"

        else
          console.log "ERROR"

    req.send params

  #
  destroy: ->
    login = document.getElementById 'trackerLogin'
    login.parentNode.removeChild login