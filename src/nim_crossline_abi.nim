# This is just an example to get you started. A typical hybrid package
# uses this file as the main entry point of the application.

import 
  nim_crossline_abi/crossline

when isMainModule:
  echo(getWelcomeMessage())
  echo(clReadLine("Q passa? "))