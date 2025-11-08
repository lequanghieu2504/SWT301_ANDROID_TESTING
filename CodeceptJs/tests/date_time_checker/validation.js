Feature("Date Time Checker Validation");
//Check a valid date
Scenario("Check a valid date", ({ I }) => {
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/dayInput"]', '14');
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/monthInput"]', '7');
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/yearInput"]', '2005');
    
    I.tap('//*[@resource-id="com.fpt.datetimechecker:id/checkButton"]');
    I.wait(2); // Wait for result to appear
    
    // Check for valid date result in resultText
    I.see('Valid Date: 14/07/2005');
    I.seeElement('//*[@resource-id="com.fpt.datetimechecker:id/resultText"]');
    I.saveScreenshot('valid_date_result.png');
});
//Check an invalid date (feb 29 in a non-leap year)
Scenario('Invalid date - February 29 in non-leap year', ({ I }) => {
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/dayInput"]', '29');
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/monthInput"]', '2');
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/yearInput"]', '2025'); // 2025 is not a leap year
    
    I.tap('//*[@resource-id="com.fpt.datetimechecker:id/checkButton"]');
    I.wait(2); // Wait for result to appear
    
    // Check for error message in resultText
    I.see('29/2/2025 is NOT correct date time !');
    I.seeElement('//*[@resource-id="com.fpt.datetimechecker:id/resultText"]');
    I.saveScreenshot('invalid_date_result.png');
});



//Check a valid leap year date (feb 29 in a leap year)
Scenario('Valid leap year date - February 29', ({ I }) => {
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/dayInput"]', '29');
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/monthInput"]', '2');
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/yearInput"]', '2024'); // 2024 is a leap year
    I.tap('//*[@resource-id="com.fpt.datetimechecker:id/checkButton"]');
    I.wait(2); // Wait for result to appear
    // Check for valid leap year date result in resultText
    I.see('Valid Date: 29/02/2024');
    I.seeElement('//*[@resource-id="com.fpt.datetimechecker:id/resultText"]');
    I.saveScreenshot('valid_leap_year_date_result.png');
});

//Check an out-of-range date (day > 31)
Scenario("Check an out-of-range date", ({ I }) => {
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/dayInput"]', '32');
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/monthInput"]', '7');
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/yearInput"]', '2005');
    
    I.tap('//*[@resource-id="com.fpt.datetimechecker:id/checkButton"]');
    I.wait(2); // Wait for result to appear
    
    // Check for error message in resultText
    I.see('Input data for Day is out of range');
    I.seeElement('//*[@resource-id="com.fpt.datetimechecker:id/resultText"]');
    I.saveScreenshot('out_of_range_day_result.png');
});
//Check an out-of-range date (day < 1)
Scenario("Check an out-of-range date (day < 1)", ({ I }) => {
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/dayInput"]', '0');
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/monthInput"]', '7');
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/yearInput"]', '2005');
    I.tap('//*[@resource-id="com.fpt.datetimechecker:id/checkButton"]');
    I.wait(2); // Wait for result to appear
    // Check for error message in resultText
    I.see('Input data for Day is out of range');
    I.seeElement('//*[@resource-id="com.fpt.datetimechecker:id/resultText"]');
    I.saveScreenshot('out_of_range_day_less_than_1_result.png');
});


//Check an out-of-range month (month > 12)
Scenario("Check an out-of-range month", ({ I }) => {
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/dayInput"]', '14');
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/monthInput"]', '13');
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/yearInput"]', '2005');
    
    I.tap('//*[@resource-id="com.fpt.datetimechecker:id/checkButton"]');
    I.wait(2); // Wait for result to appear
    
    // Check for error message in resultText
    I.see('Input data for Month is out of range');
    I.seeElement('//*[@resource-id="com.fpt.datetimechecker:id/resultText"]');
    I.saveScreenshot('out_of_range_month_result.png');
});

//Check an out-of-range month(month < 1)
Scenario("Check an out-of-range month (month < 1)", ({ I }) => {
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/dayInput"]', '14');
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/monthInput"]', '0');
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/yearInput"]', '2005');
    I.tap('//*[@resource-id="com.fpt.datetimechecker:id/checkButton"]');
    I.wait(2); // Wait for result to appear
    // Check for error message in resultText
    I.see('Input data for Month is out of range');
    I.seeElement('//*[@resource-id="com.fpt.datetimechecker:id/resultText"]');
    I.saveScreenshot('out_of_range_month_less_than_1_result.png');
});
// Check a non-numeric day
Scenario("Check a non-numeric day", ({ I }) => {
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/dayInput"]', 'a');
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/monthInput"]', '7');
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/yearInput"]', '2005');
    
    I.tap('//*[@resource-id="com.fpt.datetimechecker:id/checkButton"]');
    I.wait(2); // Wait for result to appear
    
    // Check for error message in resultText
    I.see('Day must be a number (current input: \'a\')');
    I.seeElement('//*[@resource-id="com.fpt.datetimechecker:id/resultText"]');
    I.saveScreenshot('non_numeric_year_result.png');
});
// Check a non-numeric month
Scenario("Check a non-numeric month", ({ I }) => {
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/dayInput"]', '14');
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/monthInput"]', 'a');
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/yearInput"]', '2005');
    
    I.tap('//*[@resource-id="com.fpt.datetimechecker:id/checkButton"]');
    I.wait(2); // Wait for result to appear
    
    // Check for error message in resultText
    I.see('Month must be a number (current input: \'a\')');
    I.seeElement('//*[@resource-id="com.fpt.datetimechecker:id/resultText"]');
    I.saveScreenshot('non_numeric_year_result.png');
});
// Check a non-numeric year
Scenario("Check a non-numeric year", ({ I }) => {
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/dayInput"]', '14');
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/monthInput"]', '7');
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/yearInput"]', 'a');
    
    I.tap('//*[@resource-id="com.fpt.datetimechecker:id/checkButton"]');
    I.wait(2); // Wait for result to appear
    
    // Check for error message in resultText
    I.see('Year must be a number (current input: \'a\')');
    I.seeElement('//*[@resource-id="com.fpt.datetimechecker:id/resultText"]');
    I.saveScreenshot('non_numeric_year_result.png');
});

//Check an empty field (day)
Scenario("Check an empty field", ({ I }) => {
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/dayInput"]', '');
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/monthInput"]', '7');
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/yearInput"]', '2005');
    
    I.tap('//*[@resource-id="com.fpt.datetimechecker:id/checkButton"]');
    I.wait(2); // Wait for result to appear
    
    // Check for error message in resultText
    I.see('Please fill all fields');
    I.seeElement('//*[@resource-id="com.fpt.datetimechecker:id/resultText"]');
    I.saveScreenshot('empty_field_result.png');
});
//Check clear button ( single field)
Scenario('Clear button clears single field', ({ I }) => {
    // Fill a field first
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/dayInput"]', '14');
    
    // Tap the clear button
    I.tap('//*[@resource-id="com.fpt.datetimechecker:id/clearButton"]');
    I.wait(1);
    
    // Try to submit with empty fields - should get "Please fill all fields" error
    I.tap('//*[@resource-id="com.fpt.datetimechecker:id/checkButton"]');
    I.wait(1);
    
    I.see('Please fill all fields');
    I.seeElement('//*[@resource-id="com.fpt.datetimechecker:id/resultText"]');
    I.saveScreenshot('clear_single_field_result.png');
});

//Check clear button (multiple fields)
Scenario('Clear button clears all fields', ({ I }) => {
    // Fill all fields first
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/dayInput"]', '14');
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/monthInput"]', '7');
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/yearInput"]', '2005');
    
    // Tap the clear button
    I.tap('//*[@resource-id="com.fpt.datetimechecker:id/clearButton"]');
    I.wait(1);
    
    // Try to submit with cleared fields - should get "Please fill all fields" error
    I.tap('//*[@resource-id="com.fpt.datetimechecker:id/checkButton"]');
    I.wait(1);
    
    I.see('Please fill all fields');
    I.seeElement('//*[@resource-id="com.fpt.datetimechecker:id/resultText"]');
    I.saveScreenshot('clear_all_fields_result.png');
});

// Check year out of range (year < 1000)
Scenario("Check year out of range (year < 1000)", ({ I }) => {
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/dayInput"]', '14');
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/monthInput"]', '7');
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/yearInput"]', '999');
    
    I.tap('//*[@resource-id="com.fpt.datetimechecker:id/checkButton"]');
    I.wait(2);
    
    I.see('Input data for Year is out of range');
    I.seeElement('//*[@resource-id="com.fpt.datetimechecker:id/resultText"]');
    I.saveScreenshot('year_out_of_range_low_result.png');
});

// Check year out of range (year > 3000)
Scenario("Check year out of range (year > 3000)", ({ I }) => {
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/dayInput"]', '14');
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/monthInput"]', '7');
    I.fillField('//*[@resource-id="com.fpt.datetimechecker:id/yearInput"]', '3001');
    
    I.tap('//*[@resource-id="com.fpt.datetimechecker:id/checkButton"]');
    I.wait(2);
    
    I.see('Input data for Year is out of range');
    I.seeElement('//*[@resource-id="com.fpt.datetimechecker:id/resultText"]');
    I.saveScreenshot('year_out_of_range_high_result.png');
});

