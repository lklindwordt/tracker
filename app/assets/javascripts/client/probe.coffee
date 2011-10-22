###
codename:tracker probe
Monitor mouse movement and provide absolute coordinates used
to position elements attached to the DOM
###
class Probe
  constructor: (@menu) ->
    @dX = @dY = 0
    @oldE = null

  # update Probe position
  updateDelta: (e) =>
    @dX = e.clientX
    @dY = e.clientY

    if e.srcElement != @oldE
      @elemChanged e.srcElement

    if e.altKey
      new Note @dX, @dY, e.srcElement

    @oldE = e.srcElement

  #
  elemChanged: (elem) ->
    if @oldE != null
      @oldE.style.opacity = '1.0'
      delete @oldE.onmouseup
      @oldE.onmouseup = null

    elem.style.opacity = '0.5'
    elem.onmouseup = @lockSelection

  #
  lockSelection: =>
    delete @oldE.onmouseup

    @oldE.onmouseup = null
    @oldE.style.backgroundColor = '#cccccc'

    @menu.lockSelection @oldE

# find x position of element in DOM
Probe::findX = (elem) ->
  curleft = 0;
  if elem.offsetParent?
    while(elem.offsetParent)
      curleft += elem.offsetLeft
      elem = elem.offsetParent;
  else
    if elem.x
      curleft = elem.x

  curleft

# find y position of element in DOM
Probe::findY = (obj) ->
  curtop = 0;
  if obj.offsetParent?
    while(obj.offsetParent)
      curtop += obj.offsetTop
      obj = obj.offsetParent
  else
    if obj.y
      curtop = obj.y;

  curtop

Probe::evalXPath = (aExpr) ->
  aNode = document.body
  xpe = new XPathEvaluator()
  doc = aNode.ownerDocument
  doc or= aNode.ownerDocument.documentElement
  nsResolver = xpe.createNSResolver doc
  result = xpe.evaluate aExpr, aNode, nsResolver, 0, null
  found = []
  res = null

  while (res = result.iterateNext())
    found.push(res)

  found[0]

Probe::getElementXPath = (elt) ->
  path = ""
  while elt && elt.nodeType == 1
    idx = Probe::getElementIdx elt
    xname = elt.tagName
    if elt.id
      console.log elt.id
      xname = "id('#{elt.id}')"
      path = xname + "/#{path}"
      break
    else
      xname += "[" + idx + "]"
      path = "/" + xname + path
      elt = elt.parentNode

  console.log path
  path

Probe::getElementIdx = (elt) ->
  count = 1
  sib = elt.previousSibling
  while sib
    if(sib.nodeType == 1 && sib.tagName == elt.tagName)
      count = count + 1
    sib = sib.previousSibling
  count