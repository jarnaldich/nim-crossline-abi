# This is just an example to get you started. A typical hybrid package
# uses this file as the main entry point of the application.

import 
  std/options,
  nim_crossline_abi/crossline,
  os,
  std/sequtils,
  std/sugar

when isMainModule:
  echo(getWelcomeMessage())
  clSetPromptColor(clColorE.CROSSLINE_FGCOLOR_CYAN)
  clSetDelimiters("abc")
  var line = clReadLine(">> ", "TaTbTaTb,b,c. D ")
  echo line
  var c = clGetCharCode()
  echo "Code:", c
  for line in  clIterateReadLine("Prompt>>"):
    clSetColor(clColorE.CROSSLINE_FGCOLOR_MAGENTA)
    echo(line)
    echo "", $(toSeq(walkDir(".")).mapIt(it.path))
    echo "Check", clPagingCheck(100)
    echo "Check", clPagingCheck(1)