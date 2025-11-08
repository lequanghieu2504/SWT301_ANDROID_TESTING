Step 4: Start Android Emulator
Open Android Studio
Start an emulator (same one you used for development)
Keep it running

Step 5: Start Appium Server
Install Appium: npm install -g appium
Start Appium: appium (in terminal)
Should run on: http://127.0.0.1:4723

Step 6: Create Page Object
Create: pages/DateTimeCheckerPage.js
Define selectors for day input, month input, year input, buttons

Step 7: Write Test Cases
Create: tests/android/date-time-checker.js
Test the 9 intentional bugs:
Empty field validation
Invalid day ranges (0, 32)
Invalid month ranges (0, 13)
Year validation errors
Leap year bugs
Days per month errors
Clear button issues
Step 8: Run Tests - npx codeceptjs run