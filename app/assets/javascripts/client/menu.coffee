###
codename:tracker Menu
displays a slide-in/ slide-out menu in the top right corner used to interact with tracker
###
class Menu
  constructor: (@app) ->
    @annotateActive = false
    @probe = new Probe @

    @createDOMFragment()
    @bindEventHandler()

  # displays a textArea with a save button
  displayAnnotationField: ->
    div = document.createElement 'div'
    div.id = 'trackerAnnotationField'

    div.style.position = 'absolute'
    div.style.left = '45%'
    div.style.bottom = '20%'
    div.style.background = '#cccccc'
    div.style.padding = '10px'
    div.style.zIndex = '999'

    @textArea = document.createElement 'textarea'
    @textArea.id = 'trackerTextarea'
    div.appendChild @textArea

    div.appendChild document.createElement 'br'

    @save = document.createElement 'input'
    @save.type = 'button'
    @save.value = 'Save'

    div.appendChild @save
    document.getElementsByTagName("body")[0].appendChild div

    @annotationField = div

    @bindSaveEvent()

  # create menu fragments and attach them to the DOM
  createDOMFragment: ->
    div = document.createElement 'div'
    div.id = 'trackerMenu'

    setupLi = () ->
      li = document.createElement 'li'
      li.style.display = 'inline-block'
      li.style.paddingRight = '10px'
      li

    ul = document.createElement 'ul'
    ul.style.backgroundColor = '#cccccc'
    ul.style.listStyle = 'none'
    ul.style.padding = '10px'
    ul.style.display = 'inline'

    @annotate = document.createElement 'a'
    @annotate.innerHTML = 'annotate element'
    @annotate.id = 'trackerAnnotate'

    li1 = setupLi()
    li1.appendChild @annotate
    ul.appendChild li1

    @showAnnotations = document.createElement 'a'
    @showAnnotations.innerHTML = 'load annotations'
    @showAnnotations.id = 'trackerShowAnnotations'

    li2 = setupLi()
    li2.appendChild @showAnnotations
    ul.appendChild li2

    div.appendChild ul

    clear = document.createElement 'div'
    clear.style.clear = 'both'
    div.appendChild clear

    div.style.position = 'fixed'
    div.style.left = '0'
    div.style.bottom = '0'
    div.style.background = '#cccccc'
    div.style.padding = '10px'
    div.style.minWidth = "#{window.innerWidth}px"
    div.style.width = "#{window.innerWidth}px"

    document.getElementsByTagName("body")[0].appendChild div

  # bind the annotate link action
  bindAnnotateEvent: =>
    @annotate.onclick = =>
      if @annotateActive
        console.log "annotate deactivated"
        delete window.onmousemove
        window.onmousemove = null
        @annotateActive = false
      else
        console.log "annotate activated"
        window.onmousemove = @probe.updateDelta
        @annotateActive = true
      false

  # bind the save event handler
  bindSaveEvent: =>
    @save.onclick = =>
      req = new XMLHttpRequest()

      params =
        note: @textArea.value,
        url: window.location.href,
        position: "#{@probe.dX},#{@probe.dY}"

      if @elem?
        params['element'] = Probe::getElementXPath @elem

      req.open "GET", "http://tracker.dev/notice.js?authenticity_token=#{@app.authToken}&notice=#{JSON.stringify params}", false
      req.setRequestHeader "Content-type", "application/x-www-form-urlencoded"

      req.onreadystatechange = =>
        if ( req.readyState == 4 )
          @annotationField.parentNode.removeChild @annotationField
          @annotationField = null

          if ( req.status == 200 )
            obj = JSON.parse req.responseText
            if obj.success
              console.log "note successfully created"

          else
            console.log "ERROR"

      req.send null

  # load all annotations for the current page
  bindLoadAnnotationsEvent: =>
    @showAnnotations.onclick = =>
      req = new XMLHttpRequest()

      req.open "GET", "http://tracker.dev/notices.json?authenticity_token=#{@app.authToken}&auth_token=#{@app.session}"

      req.onreadystatechange = =>
        if ( req.readyState == 4 )
          if ( req.status == 200 )
            objs = JSON.parse req.responseText
            @app.displayNotes objs

          else
            console.log "ERROR"

      req.send null

  # bind events on menu
  bindEventHandler: ->
    @bindAnnotateEvent()
    @bindLoadAnnotationsEvent()

  # lock selected srcElement
  lockSelection: (elem) ->
    if @annotateActive
      @annotateActive = false
      delete window.onmousemove
      window.onmousemove = null

      @elem = elem

      @displayAnnotationField()

      console.log "selection locked"

