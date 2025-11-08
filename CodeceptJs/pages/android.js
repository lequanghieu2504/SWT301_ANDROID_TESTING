const { I } = inject();

module.exports = {
  // Define UI elements
  fields: {
    appTitle: 'API Demos',
    animation: 'Animation',
    app: 'App',
    content: 'Content',
    views: 'Views'
  },

  // Define actions
  navigateToCategory(category) {
    I.waitForElement(`//*[@text="${category}"]`, 10);
    I.tap(`//*[@text="${category}"]`);
  },

  goBack() {
    // Use touchPerform instead of pressKey for more reliable back navigation
    I.touchPerform([
      { action: 'tap', options: { x: 50, y: 1500 }} // This is typically where Android back button is
    ]);
  },
  
  // Add more methods as needed
}; 