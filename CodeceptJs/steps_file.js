// in this file you can append custom step methods to 'I' object

module.exports = function() {
  return actor({
    // Define custom steps here
    tapOnElement: function(locator) {
      this.waitForElement(locator, 30);
      this.tap(locator);
    },
    
    swipeUp: function() {
      this.touchPerform([
        { action: 'press', options: { x: 300, y: 700 }},
        { action: 'wait', options: { ms: 500 }},
        { action: 'moveTo', options: { x: 300, y: 100 }},
        { action: 'release' }
      ]);
    },
    
    swipeDown: function() {
      this.touchPerform([
        { action: 'press', options: { x: 300, y: 300 }},
        { action: 'wait', options: { ms: 500 }},
        { action: 'moveTo', options: { x: 300, y: 700 }},
        { action: 'release' }
      ]);
    }
  });
} 