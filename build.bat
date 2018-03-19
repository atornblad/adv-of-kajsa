@echo off

IF [%1_%2]==[_] (
  GOTO :PAL
)

IF /i [%1_%2]==[NTSC_] (
  GOTO :NTSC
)

IF /i [%1_%2]==[PAL_] (
  GOTO :PAL
)

IF /i [%1_%2]==[DEBUG_] (
  GOTO :PALDEBUG
)

IF /i [%1_%2]==[PAL_DEBUG] (
  GOTO :PALDEBUG
)

IF /i [%1_%2]==[DEBUG_PAL] (
  GOTO :PALDEBUG
)

IF /i [%1_%2]==[NTSC_DEBUG] (
  GOTO :NTSCDEBUG
)

IF /i [%1_%2]==[DEBUG_NTSC] (
  GOTO :NTSCDEBUG
)

choice /C:NP /m "Please select NTSC or PAL"
IF ERRORLEVEL 2 GOTO :PAL1
IF ERRORLEVEL 1 GOTO :NTSC1
GOTO :END

:PAL1
choice /C:DN /m "Please select DEBUG or NORMAL"
IF ERRORLEVEL 2 GOTO :PAL
IF ERRORLEVEL 1 GOTO :PALDEBUG
GOTO :END

:NTSC1
choice /C:DN /m "Please select DEBUG or NORMAL"
IF ERRORLEVEL 2 GOTO :NTSC
IF ERRORLEVEL 1 GOTO :NTSCDEBUG
GOTO :END

:PALDEBUG
  echo Building PAL DEBUG version
  ca65 -D REGION=1 -D DEBUG=1 -g main.s
  ld65 --dbgfile main.dbg -t nes -o first.nes main.o
  GOTO :END

:NTSCDEBUG
  echo Building NTSC DEBUG version
  ca65 -D REGION=0 -D DEBUG=1 -g main.s
  ld65 --dbgfile main.dbg -t nes -o first.nes main.o
  GOTO :END

:PAL
  echo Building PAL version
  ca65 -D REGION=1 -g main.s
  ld65 --dbgfile main.dbg -t nes -o first.nes main.o
  GOTO :END

:NTSC
  echo Building NTSC version
  ca65 -D REGION=0 -g main.s
  ld65 --dbgfile main.dbg -t nes -o first.nes main.o
  GOTO :END
  
:END