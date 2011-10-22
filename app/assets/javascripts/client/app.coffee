###
codename:tracker App
###
class App
  constructor: ->
    @initializeSession()

  # check if a valid session exists. if so, display menu
  # else, display the login screen
  initializeSession: =>
    obj = localStorage['tracker_authToken']

    if obj
      @authToken = obj
      @session = localStorage['tracker_sessionToken']
      @displayMenu()
    else
      @displayLogin()

  # display a list of fetched notes
  displayNotes: (notes) ->
    onMouseOver = (elem) ->
      () ->
        elem.show()

    onMouseOut = (elem) ->
      () ->
        elem.hide()

    nots = {}
    for note in notes
      elem = Probe::evalXPath note.element

      if elem?
        elem.style.backgroundColor = '#cccccc'

      x = Probe::findX elem
      y = Probe::findY elem

      if nots.hasOwnProperty note.element
        n = nots[note.element]
        n.addNote note.note
      else
        n = new Note x, y, note.note

      elem.onmouseover = onMouseOver n
      elem.onmouseout = onMouseOut n

      nots[note.element] = n
  #
  displayMenu: =>
    if @login
      @login.destroy()

    localStorage['tracker_authToken'] = @authToken
    localStorage['tracker_sessionToken'] = @session

    @menu = new Menu @

  #
  displayLogin: ->
    @login = new Login @

new App()