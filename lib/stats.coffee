"use strict"

Hope    = require("zenserver").Hope
Redis   = require("zenserver").Redis
C       = require "../common/constants"

module.exports =
  average: ->
    promise = new Hope.Promise()
    Redis.run "GET", "average", (error, result) -> promise.done error, result
    promise
