"use strict"

Hope    = require("zenserver").Hope
Redis   = require("zenserver").Redis
C       = require "../common/constants"

Requests =
  count: (id) ->
    promise = new Hope.Promise()
    times = {}

    Redis.run "LRANGE", "path", 0, -1, (error, path) ->
      for type of C.URL
        total = path.filter((item) ->
          C.URL[type].replace("{user_id}", id) is item)
        times[type] = total.length
      promise.done null, times
    promise

module.exports = Requests
