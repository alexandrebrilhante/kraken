import base
export base

import jhooks
export jhooks

import structs
export structs

import asyncdispatch
import httpclient
import logging
import std/[json,jsonutils]
import strutils

const JPARSEOPTIONS = Joptions(allowExtraKeys: true, allowMissingKeys: true)

using
  self: Kraken

proc getData*[T](self; args: seq[string]): Future[T] {.async.} =
  let pStr = args.join("/")
  let res = await self.http.getContent(self.url & "/" & pStr)
  let json = parseJson(res)

  debug json.pretty()
  fromJson(result, json, JPARSEOPTIONS)
