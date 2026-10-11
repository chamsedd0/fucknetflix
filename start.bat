@echo off
rem One-click launcher: builds the UI if needed, starts the server on port 8080,
rem and opens a free public HTTPS link via Cloudflare Tunnel (if installed).
cd /d "%~dp0"

if not exist node_modules call npm install
if not exist build call npx vite build

start "FuckNetflix server" cmd /k "npm start"

set "CF=cloudflared"
where cloudflared >nul 2>nul
if errorlevel 1 set "CF=%ProgramFiles(x86)%\cloudflared\cloudflared.exe"
if not exist "%CF%" (
  where cloudflared >nul 2>nul
  if errorlevel 1 (
    echo.
    echo cloudflared is not installed, so only you can open http://localhost:8080
    echo Install it once with:  winget install Cloudflare.cloudflared
    echo then run this file again to get a public link for your partner.
    pause
    exit /b
  )
)

echo.
echo Send your partner the https://....trycloudflare.com link printed below.
echo.
"%CF%" tunnel --url http://localhost:8080
