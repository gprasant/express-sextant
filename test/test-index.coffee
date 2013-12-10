express = require "express"
request = require "request"
bond    = require "bondjs"
should  = require "should"
{ok:expect, equal, deepEqual} = require "assert"

describe "sextant", ->
  [err, response, body, server] = [null, null, null, null]
  callRoutes = null
  app = express()

  before (done)->
    sextant = (require "..")(app)
    opts =
      json: true
    callRoutes = (path = "routes", done_here) ->
      opts.url = "http://localhost:3000/#{path}"
      request opts, (_err, _res, _body) ->
        err = _err
        response = _res
        body = _body
        done_here()

    server = app.listen 3000
    done()

  describe "=> GET /routes", ->
    before (done)->
      callRoutes("routes", done)

    describe "when development environment", ->
      it "should be available", ->
        expect !err
        equal 200, response.statusCode

      it "should render the routes table", ->
        expect body.match /table id=\"routes\"/

  describe "=> GET /routes.json", ->
    test_routes = null
    before (done)->
      test_routes =
        "get":    [{path: "/routes", method: "get"}]
        "put":    [{path: "/routes", method: "put"}]
        "post":   [{path: "/routes", method: "post"}]
        "delete": [{path: "/routes", method: "delete"}]
      bond(app, 'routes').to test_routes
      sextant = (require "..")(app)
      callRoutes("routes.json", done)

    describe "=> body.app_routes", ->
      it "should get app.routes in response", ->
        deepEqual test_routes, body.app_routes

    describe "=> body.routes", ->
      it "should get routes for all HTTP methods", ->
        equal 4, body.routes.length
        body.routes.should.includeEql({method: "get", path: "/routes"})
        body.routes.should.includeEql({method: "put", path: "/routes"})
        body.routes.should.includeEql({method: "post", path: "/routes"})
        body.routes.should.includeEql({method: "delete", path: "/routes"})

  after ->
    server.close()

describe "Non Development envionment", ->

  [server, app] = [null, null]
  before (done)->
    m_settings =
      env: "production"
    app = express()
    bond(app, 'settings').to m_settings
    (require "..")(app)
    server = app.listen 3000
    done()

  it "should not be available", ->
    equal 'production', app.settings.env
    request "http://localhost:3000/routes", (_err, _res, _body) ->
      err = _err
      response = _res
      body = _body
      equal 404, response.statusCode

  after ->
    server.close()
