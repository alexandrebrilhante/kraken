import httpclient
import ws

const REAL* = "https://futures.kraken.com/derivatives/api/v3"

type
  Kraken* = ref object
    http*: AsyncHttpClient
    url*: string
    ws*: WebSocket

proc newKraken*(url = REAL): Kraken =
  let http = newAsyncHttpClient()
  Kraken(http: http, url: url)
