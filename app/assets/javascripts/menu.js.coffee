define "menu", ["jquery", "point"], ($, Point) ->
  class Menu
    constructor: ->

    render: ->
      $("body").append JST["menu"] {}
      @applyEventBindings()

    applyEventBindings: ->
      @$menu = $ ".tracker-menu"
      @$menu.find(".create-annotation").on 'click', @createAnnotationMenu

    createAnnotationMenu: =>
      $("body").append $("""<div class="tracker-overlay"></div>""")
      $(".tracker-overlay").on 'click', (e) ->
        {offsetX, offsetY} = e
        console.log offsetX, offsetY, e
        new Point offsetX, offsetY, $(document).width(), $(document).height()

