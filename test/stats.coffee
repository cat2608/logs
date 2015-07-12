"use strict"

Test = require("zenrequest").Test

module.exports = ->

  tasks = []
  tasks.push _getStats()
  tasks

# -- Tasks ---------------------------------------------------------------------
_getStats = -> ->
  Test "GET", "api/logs/stats", null, _auth(), "Get stats", 200, (response) ->
    console.log response

# -- Private methods -----------------------------------------------------------
_auth = ->
  "auth": "100002266342173"
