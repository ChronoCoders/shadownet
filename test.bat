@echo off
color 0E

cls
echo.
echo  ========================================================
echo   ShadowNet System Test
echo  ========================================================
echo.

echo  Running crypto library tests...
echo.
cd crates\crypto
cargo test --release

echo.
echo  ========================================================
echo   Running client test...
echo  ========================================================
echo.
cd ..\..
cd crates\client
cargo run --release -- test

echo.
echo  ========================================================
echo   Test Results Summary
echo  ========================================================
echo.
echo   Crypto tests: Check output above
echo   Client test: Check output above
echo.
echo  ========================================================
echo   Tests complete
echo  ========================================================
pause