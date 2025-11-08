const { setHeadlessWhen, setCommonPlugins } = require('@codeceptjs/configure');

// turn on headless mode when running with HEADLESS=true environment variable
// export HEADLESS=true && npx codeceptjs run
setHeadlessWhen(process.env.HEADLESS);

// enable all common plugins https://github.com/codeceptjs/configure#setcommonplugins
setCommonPlugins();

/** @type {CodeceptJS.MainConfig} */
exports.config = {
  name: 'Date Time Checker Tests',
  tests: './tests/date_time_checker/*.js',
  output: './output',
  helpers: {
    Appium: {
      app: './apps/date-time-checker.apk',
      platform: 'Android',
      device: 'emulator-5554',
      platformVersion: '13',
      host: '127.0.0.1',
      port: 4723,
      path: '/',
      
      desiredCapabilities: {
        automationName: 'UiAutomator2',
        newCommandTimeout: 300,
        autoGrantPermissions: true,
        noReset: true,
        fullReset: false,
        autoLaunch: true,
        sessionOverride: true
      }
    }
  },
  include: {
    I: './steps_file.js'
  },
  bootstrap: null,
  timeout: 10000,
  mocha: {},
  plugins: {
    pauseOnFail: {},
    retryFailedStep: {
      enabled: true
    },
    tryTo: {
      enabled: true
    },
    screenshotOnFail: {
      enabled: true
    }
  }
}; 