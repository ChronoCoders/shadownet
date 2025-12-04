@echo off
echo.
echo ========================================================
echo  Setting up PostgreSQL Database for ZKDIP
echo ========================================================
echo.

echo Creating database 'zkdip'...
psql -U postgres -c "CREATE DATABASE zkdip;"

echo.
echo Database created successfully!
echo.
echo To run migrations, the services will auto-migrate on startup.
echo.
pause
