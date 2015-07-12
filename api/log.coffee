"use strict"

Parse     = require("../lib/parse_log").logs("server.log")
Requests  = require "../lib/get_requests"

module.exports = (server) ->

  server.get "/api/logs/total_requests", (request, response) ->
    Requests.count(request.session).then (error, result) ->
      if error
        response.badRequest()
      else
        response.json result



