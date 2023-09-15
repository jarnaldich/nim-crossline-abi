import 
  std/options,  
  crossline_abi

proc getWelcomeMessage*(): string = "Hello, World!"

const CL_BUFFER_LENGTH = 512;

##!! Todo: Use this as an iterator...
proc clReadLine*(prompt: string): Option[string] =
  var s = newString(CL_BUFFER_LENGTH);
  if crosslineReadline(prompt.cstring, s.cstring, s.len.cint) != nil:
    result = some(s)


