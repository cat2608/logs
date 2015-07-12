"use strict"

Test = require("zenrequest").Test

module.exports = ->

  tasks = []
  tasks.push _getTotalRquest()
  tasks

# -- Tasks ---------------------------------------------------------------------
_getTotalRquest = -> ->
  Test "GET", "api/logs/total_requests", null, _auth(), "Get total requests per URL", 200, (response) ->
    console.log response

# -- Private methods -----------------------------------------------------------
_auth = ->
  "auth": "100005936523817"
