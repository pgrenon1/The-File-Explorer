SHIFT & GOTO :%~1

:GETLASTPATHELEMENT
  SETLOCAL
  for %%f in ("%~1") do set name=%%~nxf
  ( 
    ENDLOCAL
    SET "%2=%name%"
  )
  EXIT /b

:GETFILEPARENT
  SETLOCAL
  for %%a in ("%~1") do for %%b in ("%%~dpa\.") do set "name=%%~nxb"
  ( 
    ENDLOCAL
    SET "%2=%name%"
  )
  EXIT /B 0