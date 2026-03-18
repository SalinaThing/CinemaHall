@echo off
echo ================================================
echo  KumariCinema - Auto Setup Script
echo ================================================
echo.

REM Find Oracle DLL in packages folder and copy to bin
set ORACLE_DLL=..\packages\Oracle.ManagedDataAccess.12.2.1100\lib\net40\Oracle.ManagedDataAccess.dll

if exist "%ORACLE_DLL%" (
    echo Found Oracle DLL. Copying to bin folder...
    if not exist "bin" mkdir bin
    copy /Y "%ORACLE_DLL%" "bin\Oracle.ManagedDataAccess.dll"
    echo SUCCESS: Oracle.ManagedDataAccess.dll copied to bin\
) else (
    echo Oracle DLL not found in packages folder.
    echo Please run in VS Package Manager Console:
    echo   Install-Package Oracle.ManagedDataAccess -Version 12.2.1100
    echo Then run this script again.
)

echo.
echo Now open Visual Studio, Rebuild, and press F5.
pause
