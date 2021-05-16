import decimal

type
  TradeSide* = enum Buy = "buy", Sell = "sell"

  FeedMessage* = object
    feed*: string
    product_id*: string
    side*: TradeSide
    sequence*: int64
    price*: DecimalType
    qty*: DecimalType
    timestamp*: int64
