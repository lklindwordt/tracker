(($, window, document) ->
  defaults =
    property: 'value'

  class Project
    constructor: (options = {}) ->
      console.log options

  class window.Loader
    constructor:  (options) ->
      @options = $.extend {}, defaults, options

      @_defaults = defaults
      @_project = null

      @init()

    init: ->
      initializeProject()

    projectOptions: ->
      @options.project || { id: 'foo' }

    initializeProject: ->
      @_project ?= new Project @projectOptions()
      window.project = @_project

)(jQuery, window, document)