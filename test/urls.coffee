"use strict"

Test = require("zenrequest").Test

module.exports = ->

  tasks = []
  tasks.push _get_total_request()
  tasks

# -- Tasks ---------------------------------------------------------------------
_get_total_request = -> ->
  Test "GET", "api/logs/total_requests", null, _auth(), "Get total requests per URL", 200

# -- Private methods -----------------------------------------------------------
_auth = ->
  "auth": "100005936523817"
