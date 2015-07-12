"use strict"

Hope    = require("zenserver").Hope
fs      = require "fs"
path    = require "path"
folder  = "#{__dirname}/../"

Parse =
  logs: (file) ->
    promise = new Hope.Promise()
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
  file_name = path.join folder, "logs/server.json"
  fs.writeFile file_name, JSON.stringify(requests, null, 0)

module.exports = Parse
