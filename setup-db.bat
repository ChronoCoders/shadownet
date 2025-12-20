@echo off
echo.
echo ========================================================
echo  Setting up PostgreSQL Database for ShadowNet
echo ========================================================
echo.

echo Creating database 'shadownet'...
psql -U postgres -c "CREATE DATABASE shadownet;"

echo.
echo Database created successfully!
echo.
echo To run migrations, the services will auto-migrate on startup.
echo.
pause