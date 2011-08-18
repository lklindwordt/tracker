$ = jQuery
$.setScreen = (el, options) ->
  defaults =
    log: true
  
  plugin = this
  $el = el
  
  plugin.settings = {}
  
  # private methods
  # initialize a new setScreen instance
  init = (options) ->
    console.log("call")
    plugin.settings = $.extend {}, defaults, options
    plugin.el = el
    
      

# setScreen instanciator
$.fn.setScreen = (options) ->
  this.each ->
    new $.setScreen $(this), options