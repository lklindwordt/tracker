(($, window, document) ->
  defaults =
    property: 'value'

  class window.Loader
    constructor:  (options) ->
      @options = $.extend {}, defaults, options

      @_defaults = defaults

      @init()

    init: ->
      # ToDo

)(jQuery, window, document)