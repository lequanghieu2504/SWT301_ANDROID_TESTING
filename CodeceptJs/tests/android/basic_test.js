Feature('Android Testing');

Scenario('Basic App Launch Test', ({ I }) => {
  I.wait(5); // Wait for app to fully load
  
  // Take a screenshot to see what's on the screen
  I.saveScreenshot('app_launch.png');
  
  // Wait a bit more to make sure the app is fully initialized
  I.wait(5);
  
  // Take another screenshot
  I.saveScreenshot('app_initialized.png');
}); 