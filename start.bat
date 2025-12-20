@echo off
color 0A

cls
echo.
echo  ========================================================
echo.
echo   _____ _               _                 _   _      _   
echo  / ____^| ^|             ^| ^|               ^| \ ^| ^|    ^| ^|  
echo ^| (___ ^| ^|__   __ _  __^| ^| _____      __ ^|  \^| ^| ___^| ^|_ 
echo  \___ \^| '_ \ / _` ^|/ _` ^|/ _ \ \ /\ / / ^| . ` ^|/ _ \ __^|
echo  ____) ^| ^| ^| ^| (_^| ^| (_^| ^| (_) \ V  V /  ^| ^|\  ^|  __/ ^|_ 
echo ^|_____/^|_^| ^|_^|\__,_^|\__,_^|\___/ \_/\_/   ^|_^| \_^|\___^|\__^|
echo.
echo  ========================================================
echo   Anonymous Onion Routing Network
echo   Privacy * Security * Performance
echo  ========================================================
echo.
echo  Starting Services...
echo  ========================================================
echo.

echo  [1/1] Starting Relay Token Service (Port 3001)...
start "ShadowNet - Relay Token Service" cmd /k "color 0B && title ShadowNet - Relay Token Service && cd crates\blind-token-service && cargo run --release"
timeout /t 3 /nobreak >nul

echo.
echo  ========================================================
echo   Services Started Successfully!
echo  ========================================================
echo.
echo   - Relay Token Service : http://localhost:3001
echo.
echo  ========================================================
echo   Note: v1.0.0 includes crypto foundation only.
echo   Relay nodes coming in v1.5.0 (Q1 2026)
echo  ========================================================
echo.
echo   Press any key to exit...
echo  ========================================================
pause >nul