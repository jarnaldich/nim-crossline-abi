# This is just an example to get you started. A typical hybrid package
# uses this file as the main entry point of the application.

import 
  std/options,
  nim_crossline_abi/crossline

when isMainModule:
  echo(getWelcomeMessage())
  clPromptColorSet(clColorE.CROSSLINE_FGCOLOR_CYAN)
  var line = clReadLine(">> ", "Default line")
  echo line
  for line in  clIterateReadLine("Prompt>>"):
    clColorSet(clColorE.CROSSLINE_FGCOLOR_MAGENTA)
    echo(line)