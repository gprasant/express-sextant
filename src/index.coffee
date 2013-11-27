{first, map, pluck} = require 'underscore'

sextant = (app) ->
  app.engine 'html', require('ejs').renderFile

  app.get '/routes', (req, res) ->
    res.format
      html: ->
        res.render "#{__dirname}/../views/routes.html"

  app.get '/routes.json', (req, res) ->
    routes = first map app.routes, (val, key) -> val
    routes_model = map routes, (x) ->
      "method": x.method
      "path":   x.path
      "params": x.params

    res.json
      "routes": routes_model
      "app_routes": app.routes


module.exports = sextant