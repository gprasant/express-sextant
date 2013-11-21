express = require "express"

app = express.application ? express.application : express.HTTPServer.prototype

sextant = () ->
  app.get '/routes', (req, res) ->
    res.send "It Works"

module.exports = sextant