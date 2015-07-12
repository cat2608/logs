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
    _getSorted().then (error, values) ->
      if values.length % 2 is 0
        median = (values[values.length / 2] + values[values.length / 2 + 1]) / 2
      else
        median = values[(values.length + 1) / 2]
      promise.done null, median
    promise

  mode: ->
    promise = new Hope.Promise()
    Hope.shield([ ->
      _getSorted()
    , (error, values) ->
      _getMostFrequent values
    ]).then (error, result) ->
      promise.done error, result
    promise

  dyno: ->
    promise = new Hope.Promise()
    Redis.run "LRANGE", "dyno", 0, -1, (error, values) ->
      _getMostFrequent(values).then (error, result) ->
        promise.done null, result
    promise

# -- Private -------------------------------------------------------------------
_getSorted = ->
  promise = new Hope.Promise()
  Redis.run "SORT", "median", (error, result) ->
    values = (parseInt(number) for number in result)
    promise.done null, values
  promise

_getMostFrequent = (values) ->
  promise = new Hope.Promise()
  frequency = {}
  max = 0
  result = ""
  for i, index in values
    frequency[values[index]] = (frequency[values[index]] or 0) + 1
    if frequency[values[index]] > max
      max = frequency[values[index]]
      result = values[index]
  promise.done null, result
  promise

