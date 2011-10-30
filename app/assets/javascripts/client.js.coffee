(($, window, document) ->
  defaults =
    property: 'value'

  class Loader
    constructor:  ->
      @options = $.extend {}, defaults, options

      @_defaults = defaults
      @_name = pluginName

      @init()

    init: ->
      # ToDo
)(jQuery, window, document)