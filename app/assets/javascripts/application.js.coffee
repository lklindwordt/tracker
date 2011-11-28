#= require require.js
#= require handlebars
#= require_tree ../templates

require.config {
  baseUrl: "/assets"
}

require ['jquery'], ($) ->