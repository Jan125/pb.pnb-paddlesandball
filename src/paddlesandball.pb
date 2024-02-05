
Global Library.i = 0


Procedure Render(WaitTime.i)
  StartDrawing(CanvasOutput(1))
  Box(0, 0, 100*4, 100*4, $000000)
  Box((-2+ValF(PeekS(CallFunction(Library, "EvalString", @"(Element 1 (Get Paddle.1.Position))"))))*4, (-7+ValF(PeekS(CallFunction(Library, "EvalString", @"(Element 2 (Get Paddle.1.Position))"))))*4, 5*4, 15*4, $FFFFFF)
  Box((-2+ValF(PeekS(CallFunction(Library, "EvalString", @"(Element 1 (Get Paddle.2.Position))"))))*4, (-7+ValF(PeekS(CallFunction(Library, "EvalString", @"(Element 2 (Get Paddle.2.Position))"))))*4, 5*4, 15*4, $FFFFFF)
  Circle(ValF(PeekS(CallFunction(Library, "EvalString", @"(Element 1 (Get Ball.Position))")))*4, ValF(PeekS(CallFunction(Library, "EvalString", @"(Element 2 (Get Ball.Position))")))*4, 2*4, $FFFFFF)
  
  StopDrawing()
  Delay(WaitTime)
  
EndProcedure


CompilerSelect #PB_Compiler_Processor 
  CompilerCase #PB_Processor_x86
    Library = OpenLibrary(#PB_Any, "pnb.dll")
  CompilerCase #PB_Processor_x64
    Library = OpenLibrary(#PB_Any, "pnb64.dll")
  CompilerDefault
    CompilerError "Only x86 and x64 supported."
CompilerEndSelect

If Not Library
  MessageRequester("Error", "Required library pnb.dll/pnb64.dll not found in directory."+#CRLF$+"This program will terminate.")
  End
EndIf
OpenConsole()
  WindowGL = OpenWindow(#PB_Any, #PB_Ignore, #PB_Ignore, 400, 400, "PNB/paddlesandball", #PB_Window_SystemMenu|#PB_Window_MinimizeGadget)
  CanvasGadget(1, 0, 0, 400, 400)
  
String.s = "(Function (Render) Do (Invoke None "+Str(@Render())+" (Integer WaitTime)) With (WaitTime) As (100))"
CallFunction(Library, "EvalString", @String.s)

File = ReadFile(#PB_Any, "pnbpaddlesandball.pnb", #PB_File_SharedRead|#PB_File_SharedWrite)
String = ReadString(File, #PB_File_IgnoreEOL)
CloseFile(File)
CallFunction(Library, "EvalString", @String)
Repeat
Repeat
  event = WaitWindowEvent()
  Select event
    Case #PB_Event_CloseWindow
      End
  EndSelect
Until event
ForEver