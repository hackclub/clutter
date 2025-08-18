@echo off
echo Building Docker image for Clutter app...
docker build -t clutter-app .

if %ERRORLEVEL% EQU 0 (
    echo.
    echo Build successful! Starting container...
    echo Container is running with port 80 exposed
    echo To access the app, run: docker run -p 3000:80 clutter-app
    echo Or use docker-compose up to start with compose
    echo.
    docker run -d --name clutter-container clutter-app
    echo Container started in background. Use 'docker logs clutter-container' to view logs.
) else (
    echo.
    echo Build failed! Please check the error messages above.
    pause
)
