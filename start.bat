@echo off
rem One-click launcher: builds the UI if needed, starts the server on port 8080,
rem and publishes it on the fixed Tailscale Funnel link (or a temporary
rem Cloudflare link if Tailscale is not installed).
cd /d "%~dp0"

if not exist node_modules call npm install
if not exist build call npx vite build

start "FuckNetflix server" cmd /k "npm start"

set "TS=%ProgramFiles%\Tailscale\tailscale.exe"
if exist "%TS%" (
  "%TS%" funnel --bg 8080
  echo.
  echo The link above is your permanent address. Share it with your partner.
  echo Keep the "FuckNetflix server" window open while you watch.
  pause
  exit /b
)

set "CF=cloudflared"
where cloudflared >nul 2>nul
if errorlevel 1 set "CF=%ProgramFiles(x86)%\cloudflared\cloudflared.exe"
if not exist "%CF%" (
  where cloudflared >nul 2>nul
  if errorlevel 1 (
    echo.
    echo No tunnel tool found, so only you can open http://localhost:8080
    pause
    exit /b
  )
)

echo.
echo Send your partner the https://....trycloudflare.com link printed below.
echo.
"%CF%" tunnel --url http://localhost:8080
