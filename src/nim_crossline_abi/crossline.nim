import 
  crossline_abi

proc getWelcomeMessage*(): string = "Hello, World!"

const CL_BUFFER_LENGTH = 512;

proc clReadLine*(prompt: string): string =
  var s = newString(CL_BUFFER_LENGTH);
  result = s
  discard crosslineReadline(prompt.cstring, s.cstring, s.len.cint)