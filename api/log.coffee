"use strict"

Parse     = require("../lib/parse_log").logs("server.log")
Requests  = require "../lib/get_requests"

module.exports = (server) ->

  server.get "/api/logs/total_requests", (request, response) ->
    Requests.count request.parameters.user_id, (error, result) ->
      response.ok()



