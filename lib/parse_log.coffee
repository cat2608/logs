"use strict"

Hope    = require("zenserver").Hope
Redis   = require("zenserver").Redis
fs      = require "fs"
path    = require "path"
folder  = "#{__dirname}/../"

Parse =
  logs: (file) ->
    promise = new Hope.Promise()
    Redis.run "EXISTS", "path", (error, result) ->
      if result
        promise.done null, null
      else
        stream = fs.createReadStream path.join(folder, file),
            flags     : 'r'
            encoding  : 'utf-8'
            fd        : null
        requests = []

        stream.on "data", (data) ->
          logs = data.match(/\n/)["input"].split(/\n/)
          logs.splice(-1, 1)
          lines = (line.split(/\s/).splice(2, 11) for line in logs)
          parameters = {}

          for line in lines
            for content in line
              c = content.split("=")
              parameters[c[0]] = c[1]
            requests.push(parameters)
            parameters = {}

        stream.on "end", ->
          promise.done null, requests
          __writeLog requests
    promise

__writeLog = (requests) ->
  for log in requests
    Redis.run "RPUSH", "path", log.path
    sum = parseInt(log.connect.slice(0, -2)) + parseInt(log.service.slice(0, -2))
    Redis.run "LPUSH", "median", sum
    Redis.run "LPUSH", "dyno", log.dyno

  Redis.run "SET", "average", (sum / requests.length)

module.exports = Parse
