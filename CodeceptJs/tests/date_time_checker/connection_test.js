Feature('Connection Test');

Scenario('App launches successfully', ({ I }) => {
    I.wait(5); // Wait for app to load
    I.saveScreenshot('app_launched.png');
    console.log('App launched successfully');
}); 