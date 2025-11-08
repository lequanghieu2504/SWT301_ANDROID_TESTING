Feature('Android Navigation');

Scenario('Explore App UI', ({ I }) => {
  I.wait(5); // Wait for app to fully load
  
  // Take a screenshot of the initial state
  I.saveScreenshot('before_navigation.png');
  
  // Try to tap using supported clickGesture command
  I.executeScript('mobile: clickGesture', {x: 300, y: 500});
  I.wait(2);
  
  // Take a screenshot after tapping
  I.saveScreenshot('after_tap.png');
  
  // Navigate back using Android pressKey command
  I.executeScript('mobile: pressKey', {keycode: 4}); // 4 is the keycode for back button
  I.wait(2);
  
  // Try scrolling using supported scrollGesture command
  I.executeScript('mobile: scrollGesture', {
    left: 100, top: 300, width: 200, height: 400,
    direction: 'down',
    percent: 0.5
  });
  I.wait(2);
  
  // Take a final screenshot
  I.saveScreenshot('after_scroll.png');
}); 