const { I } = inject();

module.exports = {
  // UI Elements
  elements: {
    title: 'API Demos',
    animation: '~Animation',
    app: '~App',
    content: '~Content',
    graphics: '~Graphics',
    media: '~Media',
    views: '~Views'
  },
  
  // Actions
  verifyOnMainScreen() {
    I.waitForElement(this.elements.title, 10);
    I.see(this.elements.title);
    return this;
  },
  
  navigateTo(category) {
    I.waitForElement(category, 10);
    I.tap(category);
    I.wait(2);
    return this;
  },
  
  goToAnimationSection() {
    return this.navigateTo(this.elements.animation);
  },
  
  goToAppSection() {
    return this.navigateTo(this.elements.app);
  },
  
  goToViewsSection() {
    return this.navigateTo(this.elements.views);
  },
  
  goBack() {
    I.executeScript('mobile: pressKey', {keycode: 4});
    I.wait(1);
    return this;
  },
  
  scrollDown() {
    I.executeScript('mobile: scrollGesture', {
      left: 100, top: 300, width: 200, height: 400,
      direction: 'down',
      percent: 0.5
    });
    I.wait(1);
    return this;
  }
}; 