Feature('Android Example Tests');

// Simple test to verify app launches
Scenario('App launches successfully', ({ I }) => {
  I.wait(3); // Wait for app to load
  I.saveScreenshot('app_launched.png');
  // Look for text on the main screen
  I.see('API Demos');
});

// Test that navigates through the app
Scenario('Navigate to Animation section', ({ I }) => {
  I.wait(3);
  
  // Find and tap on Animation category
  I.waitForElement('~Animation', 10); // Using accessibility ID
  I.tap('~Animation');
  I.wait(2);
  
  // Verify we're in the Animation section
  I.see('Bouncing Balls');
  I.saveScreenshot('animation_section.png');
  
  // Go back to main screen
  I.executeScript('mobile: pressKey', {keycode: 4}); // Android back button
});

// Test that demonstrates scrolling
Scenario('Scroll and find element', ({ I }) => {
  I.wait(3);
  
  // Scroll down to find Views
  I.executeScript('mobile: scrollGesture', {
    left: 100, top: 300, width: 200, height: 400,
    direction: 'down',
    percent: 0.5
  });
  
  // Find and tap Views
  I.waitForElement('~Views', 10);
  I.tap('~Views');
  I.wait(2);
  
  // Verify we're in the Views section
  I.see('Controls');
  I.saveScreenshot('views_section.png');
}); 