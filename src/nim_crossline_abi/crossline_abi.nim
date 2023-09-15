
# Example: const myHeader = currentSourcePath().splitPath.head & "/myHeader.h"
{.compile: "../../vendor/Crossline/crossline.c" .}

type
  CrosslineColorE* {.size: sizeof(cint).} = enum
    CROSSLINE_FGCOLOR_DEFAULT = 0x00, CROSSLINE_FGCOLOR_BLACK = 0x01,
    CROSSLINE_FGCOLOR_RED = 0x02, CROSSLINE_FGCOLOR_GREEN = 0x03,
    CROSSLINE_FGCOLOR_YELLOW = 0x04, CROSSLINE_FGCOLOR_BLUE = 0x05,
    CROSSLINE_FGCOLOR_MAGENTA = 0x06, CROSSLINE_FGCOLOR_CYAN = 0x07,
    CROSSLINE_FGCOLOR_WHITE = 0x08, CROSSLINE_FGCOLOR_MASK = 0x7F,
    CROSSLINE_FGCOLOR_BRIGHT = 0x80, CROSSLINE_BGCOLOR_BLACK = 0x0100,
    CROSSLINE_BGCOLOR_RED = 0x0200, CROSSLINE_BGCOLOR_GREEN = 0x0300,
    CROSSLINE_BGCOLOR_YELLOW = 0x0400, CROSSLINE_BGCOLOR_BLUE = 0x0500,
    CROSSLINE_BGCOLOR_MAGENTA = 0x0600, CROSSLINE_BGCOLOR_CYAN = 0x0700,
    CROSSLINE_BGCOLOR_WHITE = 0x0800, CROSSLINE_BGCOLOR_MASK = 0x7F00,
    CROSSLINE_BGCOLOR_BRIGHT = 0x8000, CROSSLINE_UNDERLINE = 0x10000

const
  CROSSLINE_BGCOLOR_DEFAULT = CROSSLINE_FGCOLOR_DEFAULT
  CROSSLINE_COLOR_DEFAULT = CROSSLINE_FGCOLOR_DEFAULT

##  Main API to read a line, return buf if get line, return NULL if EOF.

proc crosslineReadline*(prompt: cstring; buf: cstring; size: cint): cstring {.
    importc: "crossline_readline" .}
##  Same with crossline_readline except buf holding initial input for editing.

proc crosslineReadline2*(prompt: cstring; buf: cstring; size: cint): cstring {.
    importc: "crossline_readline2" .}
##  Set move/cut word delimiter, default is all not digital and alphabetic characters.

proc crosslineDelimiterSet*(delim: cstring) {.importc: "crossline_delimiter_set" .}
##  Read a character from terminal without echo

proc crosslineGetch*(): cint {.importc: "crossline_getch" .}
##
##  History APIs
##
##  Save history to file

proc crosslineHistorySave*(filename: cstring): cint {.
    importc: "crossline_history_save" .}
##  Load history from file

proc crosslineHistoryLoad*(filename: cstring): cint {.
    importc: "crossline_history_load" .}
##  Show history in buffer

proc crosslineHistoryShow*() {.importc: "crossline_history_show" .}
##  Clear history

proc crosslineHistoryClear*() {.importc: "crossline_history_clear" .}
##
##  Completion APIs
##

type
  CrosslineCompletionsT* = object
  CrosslineCompletionCallback* = proc (buf: cstring;
                                    pCompletions: ptr CrosslineCompletionsT)

##  Register completion callback

proc crosslineCompletionRegister*(pCbFunc: CrosslineCompletionCallback) {.
    importc: "crossline_completion_register" .}
##  Add completion in callback. Word is must, help for word is optional.

proc crosslineCompletionAdd*(pCompletions: ptr CrosslineCompletionsT; word: cstring;
                            help: cstring) {.importc: "crossline_completion_add" .}
##  Add completion with color.

proc crosslineCompletionAddColor*(pCompletions: ptr CrosslineCompletionsT;
                                 word: cstring; wcolor: CrosslineColorE;
                                 help: cstring; hcolor: CrosslineColorE) {.
    importc: "crossline_completion_add_color" .}
##  Set syntax hints in callback

proc crosslineHintsSet*(pCompletions: ptr CrosslineCompletionsT; hints: cstring) {.
    importc: "crossline_hints_set" .}
##  Set syntax hints with color

proc crosslineHintsSetColor*(pCompletions: ptr CrosslineCompletionsT;
                            hints: cstring; color: CrosslineColorE) {.
    importc: "crossline_hints_set_color" .}
##
##  Paging APIs
##
##  Enable/Disble paging control

proc crosslinePagingSet*(enable: cint): cint {.importc: "crossline_paging_set" .}
##  Check paging after print a line, return 1 means quit, 0 means continue
##  if you know only one line is printed, just give line_len = 1

proc crosslinePagingCheck*(lineLen: cint): cint {.importc: "crossline_paging_check" .}
##
##  Cursor APIs
##
##  Get screen rows and columns

proc crosslineScreenGet*(pRows: ptr cint; pCols: ptr cint) {.
    importc: "crossline_screen_get" .}
##  Clear current screen

proc crosslineScreenClear*() {.importc: "crossline_screen_clear" .}
##  Get cursor postion (0 based)

proc crosslineCursorGet*(pRow: ptr cint; pCol: ptr cint): cint {.
    importc: "crossline_cursor_get" .}
##  Set cursor postion (0 based)

proc crosslineCursorSet*(row: cint; col: cint) {.importc: "crossline_cursor_set" .}
##  Move cursor with row and column offset, row_off>0 move up row_off lines, <0 move down abs(row_off) lines
##  =0 no move for row, similar with col_off

proc crosslineCursorMove*(rowOff: cint; colOff: cint) {.  importc: "crossline_cursor_move" .}
##  Hide or show cursor

proc crosslineCursorHide*(bHide: cint) {.importc: "crossline_cursor_hide" .}
##
##  Color APIs
##
##  Set text color, CROSSLINE_COLOR_DEFAULT will revert to default setting
##  `\t` is not supported in Linux terminal, same below. Don't use `\n` in Linux terminal, same below.

proc crosslineColorSet*(color: CrosslineColorE) {.importc: "crossline_color_set" .}
##  Set default prompt color

proc crosslinePromptColorSet*(color: CrosslineColorE) {.
    importc: "crossline_prompt_color_set" .}