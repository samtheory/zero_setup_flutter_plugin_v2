# 🚀 Project Setup Script for Windows

Write-Host "🚀 Setting up project..." -ForegroundColor Cyan

# Install dependencies
Write-Host "📦 Installing dependencies..." -ForegroundColor Yellow
flutter pub get

# Generate files
Write-Host "⏳ Generating files (this may take a while)..." -ForegroundColor Yellow
dart run build_runner build --delete-conflicting-outputs

Write-Host "✅ Done! Project is ready to run." -ForegroundColor Green
