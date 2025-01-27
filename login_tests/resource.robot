*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
${SERVER}         localhost:7272
${CHROME_BROWSER_PATH}    /Users/mink/Desktop/ChromeForTesting/chrome-mac-arm64/Google Chrome for Testing.app/Contents/MacOS/Google Chrome for Testing
${CHROME_DRIVER_PATH}     /Users/mink/Desktop/ChromeForTesting/chromedriver-mac-arm64/chromedriver
${DELAY}          0
${VALID USER}     demo
${VALID PASSWORD}    mode
${LOGIN URL}      http://${SERVER}/
${WELCOME URL}    http://${SERVER}/welcome.html
${ERROR URL}      http://${SERVER}/error.html

*** Keywords ***
Open Browser To Login Page
    # สร้าง options สำหรับ Chrome
    ${chrome_options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()

    # ตั้งค่า binary_location ให้กับ chrome_options
    ${chrome_options.binary_location}    Set Variable    ${CHROME_BROWSER_PATH}

    # สร้าง service สำหรับ chromedriver
    ${service}    Evaluate    sys.modules['selenium.webdriver.chrome.service'].Service(executable_path="${CHROME_DRIVER_PATH}")

    # สร้าง WebDriver โดยใช้ options และ service
    Create Webdriver    Chrome    options=${chrome_options}    service=${service}

    # ไปที่ URL ที่ต้องการ
    Go To    ${LOGIN URL}
    Login Page Should Be Open

Login Page Should Be Open
    Title Should Be    Login Page

Go To Login Page
    Go To    ${LOGIN URL}
    Login Page Should Be Open

Input Username
    [Arguments]    ${username}
    Input Text    username_field    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    password_field    ${password}

Submit Credentials
    Click Button    login_button

Welcome Page Should Be Open
    Location Should Be    ${WELCOME URL}
    Title Should Be    Welcome Page
