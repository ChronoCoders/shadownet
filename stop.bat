@echo off
color 0C

cls
echo.
echo  ========================================================
echo   Stopping All ShadowNet Services...
echo  ========================================================
echo.

taskkill /F /FI "WINDOWTITLE eq ShadowNet*" /T 2>nul
if %errorlevel%==0 (
    echo  [OK] All ShadowNet services stopped
) else (
    echo  [--] No ShadowNet services running
)

echo.
echo  ========================================================
echo   All services stopped
echo  ========================================================
echo.
pause