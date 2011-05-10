#!/usr/bin/env coffeeScript
# -*- coding: utf-8 -*-

http = require 'http'
url = require 'url'
fs = require 'fs'
ejs = require './node_modules/ejs'

str = fs.readFileSync 'index.ejs', 'utf-8'
statuscode_data = JSON.parse(fs.readFileSync 'statuscode.json','utf-8')

http.createServer( (req, res) ->

  path = url.parse(req.url).pathname
  code = parseInt path.replace '/' , ''

  if path is '/'
    code = 200
  else if isNaN code
    code = 404

  data = statuscode_data[code]

  if not data
    data = {}
    data.message = 'unknown'
    data.detail = ''

  data.code = code
  data.all = statuscode_data
  res.writeHead code, {'Content-Type': 'text/html; charset=utf-8'}
  res.end ejs.render str,{locals: data}

).listen(8124, "127.0.0.1")