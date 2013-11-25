{first, map, pluck} = require 'underscore'

sextant = (app) ->
  app.get '/routes', (req, res) ->
    res.format
      text: ->
        res.send 200, "routes text"
      json: ->
        res.send 200, app.routes

  app.get '/routes.json', (req, res) ->
    routes = first map app.routes, (val, key) -> val
    routes_model = map routes, (x) ->
      "method": x.method
      "path":   x.path
      "params": x.params

    res.json
      "routes": routes_model
      "routes_orig": app.routes


module.exports = sextant