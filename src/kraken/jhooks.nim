import decimal
import std/[json]
import strutils
import times
import uuids

const isoTime = "yyyy-MM-dd'T'HH:mm:ss'.'ffffffzzz"

proc fromJsonHook*(x: var DecimalType, j: JsonNode) =
  x = newDecimal(j.getStr)

proc fromJsonHook*(x: var UUID, j: JsonNode) =
  x = parseUUID(j.getStr())

proc fixTimeStr(x: var string) =
  var dotIdx = x.find('.')

  if dotIdx < 0:
    x.insert(".000000", 19)
  else:
    var l = 0
    while x[dotIdx + 1 + l] in '0'..'9':
      l.inc
    if l < 6:
      x.insert(repeat('0', 6 - l), dotIdx + 1 + l)

proc fromJsonHook*(x: var Time, j: JsonNode) =
  var timeStr = j.getStr
  fixTimeStr(timeStr)
  x = parseTime(timeStr, isoTime, utc())
