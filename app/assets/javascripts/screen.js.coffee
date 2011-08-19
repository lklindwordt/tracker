$ = jQuery

# el is a jQuery selector object, or array
$.screen = (el, options) ->
  defaults =
    log: true
  
  navigation = this
  $el = el
  
  init = (options) ->
    log("Screen -> init")
    $el.height($(window).height())
    $(window).resize ->
      $el.height($(window).height())
       
  log = (msg) ->
    console.log msg if defaults.log
    
  init options
  
  
# plugin instanciator
$.fn.screen = (options) ->
  this.each ->
    new $.screen $(this), options