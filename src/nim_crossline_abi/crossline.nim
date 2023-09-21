import 
  std/options,  
  crossline_abi

type 
    clColorE* = CrosslineColorE
    clRowsCols* = object 
        rows*: int 
        cols*: int
    clCompletionFuncT* = proc(prefix: string) : seq[string];


proc getWelcomeMessage*(): string = "Hello, World!"

const CL_BUFFER_LENGTH = 512;

##########################
# READING LINES/CHAR API #
##########################
proc clReadLine*(prompt: string, initial: string = ""): Option[string] =
  var s = newString(CL_BUFFER_LENGTH);
  if initial.len > 0:
    #XXX: Pretty sure there has to be an easier way to do this...
    var buf: array[CL_BUFFER_LENGTH, char]
    copyMem(buf[0].addr, initial[0].addr, initial.len + 1)
    var bs = cast[cstring](buf[0].addr)
    if crosslineReadline2(prompt.cstring, bs, buf.len.cint) != nil:
        s = $bs
        result = some(s)
  elif crosslineReadline(prompt.cstring, s.cstring, s.len.cint) != nil:
    result = some(s)

iterator clIterateReadLine*(prompt: string): string =
    while true:
        let maybeLine = clReadLine(prompt)
        if maybeLine.isNone:
            break
        yield maybeLine.get()

proc clGetCharCode*(): int = crosslineGetch().int
proc clSetDelimiters*(del: string) = crosslineDelimiterSet(del.cstring)

#############
# COLOR API #
#############
proc clSetColor*(color: CrosslineColorE) = crosslineColorSet(color)
proc clSetPromptColor*(color: CrosslineColorE) = crosslinePromptColorSet(color)


###############
# HISTORY API #
###############
proc clHistorySave*(fileName: string) {.raises: [ IOError ] .} = 
    if crosslineHistorySave(fileName.cstring) != 0:
        raise newException(IOError, "History save failed") 

proc clHistoryLoad*(fileName: string) {.raises: [ IOError ] .} = 
    if crosslineHistoryLoad(fileName.cstring) != 0:
        raise newException(IOError, "History load failed") 

proc clHistoryShow*() = crosslineHistoryShow()
proc clHistoryClear*() = crosslineHistoryClear()

##############
# PAGING API #
##############
#XXX: I do not fully understand how to use this.
proc clPagingCheck*(lines: int): int = crosslinePagingCheck(lines.cint).int
proc clEnablePaging*() = discard crosslinePagingSet(1)
proc clDisablePaging*() = discard crosslinePagingSet(0)

##############
# CURSOR API #
##############
proc clGetScreen*() : clRowsCols = 
    var rows: cint = 0;
    var cols: cint = 0;
    crosslineScreenGet(rows.addr, cols.addr)
    result = clRowsCols(rows: rows.int, cols: cols.int)

proc clClearScreen*() = crosslineScreenClear()

proc clGetCursor*() : clRowsCols = 
    var rows: cint = 0;
    var cols: cint = 0;
    discard crosslineCursorGet(rows.addr, cols.addr)
    result = clRowsCols(rows: rows.int, cols: cols.int)

proc clMoveCursor*(rows: int, cols: int) = crosslineCursorSet(rows.cint, cols.cint)
proc clMoveCursor*(rc: clRowsCols) = clMoveCursor(rc.rows, rc.cols)

proc clSetCursor*(rows: int, cols: int) = crosslineCursorSet(rows.cint, cols.cint)
proc clSetCursor*(rc: clRowsCols) = clSetCursor(rc.rows, rc.cols)

proc clHideCursor*() = crosslineCursorHide(1)
proc clShowCursor*() = crosslineCursorHide(0)

###############
# COMPLETIONS #
###############

#proc clCompletionsAdapter(completionF: clCompletionsFuncT) : CrosslineCompletionsT = 
#    return (proc(buf: cstring; pCompletions: ptrCrosslineCompletionsT) = 
#
#            )



