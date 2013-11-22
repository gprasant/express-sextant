
sextant = (app) ->
  app.get '/routes', (req, res) ->
    res.send 200, app.routes

module.exports = sextant