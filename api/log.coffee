"use strict"

Hope      = require("zenserver").Hope
Parse     = require("../lib/parse_log").logs("server.log")
Requests  = require "../lib/get_requests"
Stats     = require "../lib/stats"

module.exports = (server) ->

  server.get "/api/logs/total_requests", (request, response) ->
    Requests.count(request.session).then (error, result) ->
      if error
        response.badRequest()
      else
        response.json result

  server.get "/api/logs/stats", (request, response) ->
    tasks = []
    tasks.push Stats.average
    tasks.push Stats.median
    tasks.push Stats.mode
    Hope.join(tasks).then (error, results) ->
      response.json
        average: results[0]
        median : results[1]
        mode   : results[2]
