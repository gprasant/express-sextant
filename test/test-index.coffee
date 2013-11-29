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
    opts =
      json: true
    before (done)->
      callRoutes = (path = "routes", done_here) ->
        opts.url = "http://localhost:3000/#{path}"
        request opts, (_err, _res, _body) ->
          err = _err
          response = _res
          body = _body
          done_here()
      callRoutes("routes", done)

    it "should be available", ->
      expect !err
      equal 200, response.statusCode

    it "should render the routes table", ->
      expect body.match /table id=\"routes\"/

    describe "returning app.routes", ->
      test_routes = null
      before (done)->
        test_routes = {"some": "routes"}
        bond(app, 'routes').to test_routes
        sextant = (require "..")(app)
        callRoutes("routes.json", done)


      it "should get app.routes in response", ->
        deepEqual test_routes, body.app_routes





