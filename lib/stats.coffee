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
        median = sorted_values[(size+1)/2]
      promise.done null, median
    promise

  mode: ->
    promise = new Hope.Promise()
    frequency = {}
    max = 0
    result = ""
    _getSorted().then (error, values) ->
      for i, index in values
        frequency[values[index]] = (frequency[values[index]] or 0) + 1
        if frequency[values[index]] > max
          max = frequency[values[index]]
          result = values[index]
      promise.done null, result
    promise

_getSorted = ->
  promise = new Hope.Promise()
  Redis.run "SORT", "median", (error, result) ->
    values = (parseInt(number) for number in result)
    promise.done null, values
  promise

