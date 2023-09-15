# Package

version       = "0.1.0"
author        = "Joan Arnaldich"
description   = "crossline C library wrapper (readline + libedit extended functionality)"
license       = "MIT"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["nim_crossline_abi"]


# Dependencies

requires "nim >= 2.0.0"
