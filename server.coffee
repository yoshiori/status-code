#!/usr/bin/env node
# -*- coding: utf-8 -*-

http = require 'http'
url = require 'url'
fs = require 'fs'
statuscode_data = null
fs.readFile('statuscode.json','utf-8', (err, data) ->
        statuscode_data = JSON.parse(data)
)

http.createServer( (req, res) ->
  path = url.parse(req.url).pathname
  code = parseInt path.replace '/' , ''
  if isNaN code
    code = 404
  console.log(typeof code)
  data = statuscode_data[code]

  res.writeHead code, {'Content-Type': 'text/plain; charset=utf-8'}
  res.end """#{code} #{data?.message} \n#{data?.detail}"""
).listen(8124, "127.0.0.1")