# Date Time Checker Testing Guide

## Prerequisites
- Node.js (v14 or higher)
- Android Studio
- Visual Studio Code
- Java Development Kit (JDK)
- Git

## Setup Instructions

### 1. Clone and Install Dependencies
```sh
# Clone the repository - DON'T DOWNLOAD ZIP FILE
git clone <repository-url>
cd CodeceptJs

# Install sdk
add sdk path to environment variable

# Install dependencies
npm install
# Install Appium globally - skip if already installed
npm install -g appium

# Start Appium server
appium
# Run all tests
npx codeceptjs run

# Run specific test file
npx codeceptjs run tests/date_time_checker/validation.js

# Run with detailed steps
npm run codeceptjs
## FINISH

# Check connected devices
adb devices

# Restart ADB server
adb kill-server
adb start-server

# Clear Appium
npm uninstall -g appium
npm install -g appium
