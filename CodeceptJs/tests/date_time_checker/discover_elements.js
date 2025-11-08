Feature('Discover Elements');

Scenario('Find input elements', ({ I }) => {
    I.wait(3); // Wait for app to load
    I.saveScreenshot('app_loaded.png');
    
    // Try to find elements using different strategies
    console.log('=== Searching for input elements ===');
    
    // Try common Android input field patterns
    try {
        I.seeElement('//android.widget.EditText[1]');
        console.log('✓ Found first EditText element');
    } catch (e) {
        console.log('✗ No EditText elements found');
    }
    
    try {
        I.seeElement('//*[@class="android.widget.EditText"]');
        console.log('✓ Found EditText by class');
    } catch (e) {
        console.log('✗ No EditText by class found');
    }
    
    // Try to find buttons
    try {
        I.seeElement('//android.widget.Button');
        console.log('✓ Found Button element');
    } catch (e) {
        console.log('✗ No Button elements found');
    }
    
    // Try to find elements with text
    try {
        I.see('Check');
        console.log('✓ Found "Check" text');
    } catch (e) {
        console.log('✗ No "Check" text found');
    }
    
    try {
        I.see('Clear');
        console.log('✓ Found "Clear" text');
    } catch (e) {
        console.log('✗ No "Clear" text found');
    }
    
    console.log('=== Element discovery complete ===');
    console.log('Check the screenshot to see the current app state');
}); 