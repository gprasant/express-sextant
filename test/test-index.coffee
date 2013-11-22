express = require "express"
request = require "request"
{ok:expect, equal} = require "assert"

describe "sextant", ->
  app = express()

  before (done)->
    sextant = (require "..")(app)
    app.listen 3000
    done()

  describe "GET /routes", ->
    [err, response, body] = [null, null, null]
    callRoutes = null
    before (done)->
      callRoutes = () ->
        request "http://localhost:3000/routes", (_err, _res, _body) ->
          err = _err
          response = _res
          body = _body
          done()
      callRoutes()

    it "should be available", ->
      expect !err
      equal 200, response.statusCode

    it "should get app.routes in response"




