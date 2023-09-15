# This is just an example to get you started. A typical hybrid package
# uses this file as the main entry point of the application.

import 
  std/options,
  nim_crossline_abi/crossline

when isMainModule:
  echo(getWelcomeMessage())
  while true:
    var res = clReadLine("Q   ...passa? ")
    if res.isNone:
      break