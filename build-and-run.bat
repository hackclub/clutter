@echo off
echo Building Docker image for Clutter app...
docker build -t clutter-app .

if %ERRORLEVEL% EQU 0 (
    echo.
    echo Build successful! Starting container...
    echo The app will be available at http://localhost:3000
    echo Press Ctrl+C to stop the container
    echo.
    docker run -p 3000:80 clutter-app
) else (
    echo.
    echo Build failed! Please check the error messages above.
    pause
)
