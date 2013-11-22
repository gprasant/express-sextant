express = require "express"
request = require "request"
bond    = require "bondjs"
{ok:expect, equal, deepEqual} = require "assert"

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
      callRoutes = (done_here) ->
        request "http://localhost:3000/routes", (_err, _res, _body) ->
          err = _err
          response = _res
          body = _body
          done_here()
      callRoutes(done)

    it "should be available", ->
      expect !err
      equal 200, response.statusCode

    describe "returning app.routes", ->
      test_routes = null
      before (done)->
        test_routes = {"some": "routes"}
        bond(app, 'routes').to test_routes
        sextant = (require "..")(app)
        callRoutes(done)


      it "should get app.routes in response", ->
        deepEqual test_routes, JSON.parse body




