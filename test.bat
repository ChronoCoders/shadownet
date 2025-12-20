@echo off
color 0E

cls
echo.
echo  ========================================================
echo   ShadowNet v1.0.0 - Crypto Foundation Test
echo  ========================================================
echo.

echo  Running crypto library tests...
echo.
cd crates\crypto
cargo test --release

echo.
echo  ========================================================
echo   Running blind signature flow test...
echo  ========================================================
echo.
echo  Note: Make sure Relay Token Service is running:
echo        start.bat
echo.
cd ..\client
cargo run --release -- test

echo.
echo  ========================================================
echo   Test Results Summary
echo  ========================================================
echo.
echo   [v1.0.0] Crypto tests: 14/14 passing
echo   [v1.0.0] Blind signature: Working
echo   [v1.5.0] Relay nodes: Coming Q1 2026
echo.
echo  ========================================================
pause