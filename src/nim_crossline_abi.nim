# This is just an example to get you started. A typical hybrid package
# uses this file as the main entry point of the application.

import 
  std/options,
  nim_crossline_abi/crossline,
  nim_crossline_abi/crossline_abi,
  os,
  std/sequtils,
  std/sugar


proc completions(word: string )  : seq[clCompletion] = 
  return [ clCompletion(
            text: "Hola",
            help: "Hola help",
            hint: none(string), 
            color: some(CROSSLINE_FGCOLOR_RED),
            helpColor: none(clColorE),
            hintColor: none(clColorE))].toSeq()

proc completions2(buf: cstring; pCompletions: ptr CrosslineCompletionsT) {.cdecl.} = 
  debugEcho("HOOOOOOOOO")
  crosslineCompletionAdd(pCompletions, "PATATA", "")

when isMainModule:
  clSetPromptColor(clColorE.CROSSLINE_FGCOLOR_CYAN)
  echo "RC", clGetScreen()
  echo "Cursor", clGetCursor()
  clCompletionsRegister(completions)
#  crosslineCompletionRegister(completions2)
  for line in  clIterateReadLine("Prompt>>"):
    clSetColor(clColorE.CROSSLINE_FGCOLOR_MAGENTA)
    echo(line)
    echo "", $(toSeq(walkDir(".")).mapIt(it.path))
    echo "Check", clPagingCheck(100)
    echo "Check", clPagingCheck(1)