# kraken

![GitHub](https://img.shields.io/github/license/brilhana/kraken)

Kraken API client in Nim.

# Usage

```nim
import asyncdispatch
import kraken

let kr = newKraken()
let subs = waitFor kr.subscribe(ctBook, @["PI_XBTUSD"])

for x in subs:
    echo x
```
