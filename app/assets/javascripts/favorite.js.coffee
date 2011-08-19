$ = jQuery

# el is a jQuery selector object, or array
$.favorite = (el, options) ->
  defaults =
    title: "Bug Tracking",
    url: "javascript:(function()%7Bvar%20script=document.createElement('script');script.type='text/javascript';script.src='http://tracker-javascript.dev/tools/tracker.min.js?'+(new%20Date().getTime());document.getElementsByTagName('body')%5B0%5D.appendChild(script);%7D)()",
    log: true
  
  favorite = this
  $el = el
  
  init = (options) ->
    log "Favorite -> init"
    $el.click ->
      # Firefox
      if window.sidebar
        window.sidebar.addPanel defaults.title, defaults.url, "";
      else if document.all
        window.external.AddFavorite url, title
             
  log = (msg) ->
    console.log msg if defaults.log
    
  init options
  
  
# plugin instanciator
$.fn.favorite = (options) ->
  this.each ->
    new $.favorite $(this), options