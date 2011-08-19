$ = jQuery

# el is a jQuery selector object, or array
$.screen = (el, options) ->
  defaults =
    log: true
  
  navigation = this
  $el = el
  
  init = (options) ->
     $el.height($(window).height())
     $(window).resize ->
       $el.height($(window).height())
    
  init options
  
  
# plugin instanciator
$.fn.screen = (options) ->
  this.each ->
    new $.screen $(this), options