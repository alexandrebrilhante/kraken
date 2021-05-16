import public
export public

import asyncdispatch
import ws
import std/[json, jsonutils]

const WS_REAL* = "wss://futures.kraken.com/ws/v1"

const JPARSEOPTIONS = Joptions(allowExtraKeys: true, allowMissingKeys: true)

type
  Subscription* = object
    ws: WebSocket

using
  self: Kraken

proc subscribe*(self; channel: string, products: seq[string]): Future[Subscription] {.async.} =
  if self.ws.isNil:
    self.ws = await newWebSocket(WS_REAL)

  let j = %*{
    "event": "subscribe",
    "feed": channel,
    "product_ids": products
  }
  await self.ws.send($j)

  result.ws = self.ws

proc processMsg(j: JsonNode): FeedMessage =
  var msg: FeedMessage

  fromJson(msg, j, JPARSEOPTIONS)

iterator items*(sub: Subscription): FeedMessage =
  var msg: string

  while sub.ws.readyState == Open:
    msg = waitFor sub.ws.receiveStrPacket()
    yield processMsg(parseJson(msg))

iterator pairs*(sub: Subscription): (int, FeedMessage) =
  var i = 0

  for x in sub.items:
    yield (i, x)
    i.inc()
