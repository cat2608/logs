"use strict"

Test = require("zenrequest").Test

module.exports = ->

  tasks = []
  tasks.push _getMedian()
  tasks

# -- Tasks ---------------------------------------------------------------------
_getMedian = -> ->
  Test "GET", "api/logs/stats", null, _auth(), "Get median", 200

# -- Private methods -----------------------------------------------------------
_auth = ->
  "auth": "100005936523817"
