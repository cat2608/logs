"use strict"

Hope    = require("zenserver").Hope
Redis   = require("zenserver").Redis
C       = require "../common/constants"

module.exports =
  average: ->
    promise = new Hope.Promise()
    Redis.run "GET", "average", (error, result) -> promise.done error, result
    promise

  median: ->
    promise = new Hope.Promise()
    values = []
    Redis.run "SORT", "median", (error, result) ->
      values = (parseInt(number) for number in result)
      if values.length % 2 is 0
        median = (values[values.length / 2] + values[values.length / 2 + 1]) / 2
      else
        median = sorted_values[(size+1)/2]
      promise.done null, median
    promise
