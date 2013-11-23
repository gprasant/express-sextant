
sextant = (app) ->
  app.get '/routes', (req, res) ->
    res.format
      text: ->
        res.send 200, "routes text"
      json: ->
        res.send 200, app.routes

module.exports = sextant