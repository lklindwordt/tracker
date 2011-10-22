###
codename:tracker note
###
class Note
  constructor: (@x, @y, @text) ->
    @y = @y - 20

  #
  addNote: (text) ->
    @y = @y - 30
    @text = "#{@text}<br/>#{text}"

  #
  show: ->
    @createDOMFragment()

  #
  hide: ->
    @destroyDOMFragment()

  # remove the note from the DOM, if it exists
  destroyDOMFragment: ->
    if @note?
      @note.parentNode.removeChild @note

  # create a dom element for the given note
  createDOMFragment: ->
    @note = document.createElement 'div'
    @note.className = 'note'
    @note.innerHTML = "#{@text} - (#{@x},#{@y})"

    @note.style.position = 'absolute';
    @note.style.top = "#{@y}px"
    @note.style.left = "#{@x}px"
    @note.style.border = "1px solid #333"
    @note.style.padding = '3px'
    @note.style.backgroundColor = '#969696'
    @note.style.zIndex = '999'

    document.getElementsByTagName("body")[0].appendChild @note
