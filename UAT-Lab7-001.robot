*** Settings ***
Library           SeleniumLibrary
Suite Setup       Open Browser To Form Page
Suite Teardown    Close Browser

*** Variables ***
${SERVER}          localhost:7272
${CHROME_BROWSER_PATH}    /Users/mink/Desktop/ChromeForTesting/chrome-mac-arm64/Google Chrome for Testing.app/Contents/MacOS/Google Chrome for Testing
${CHROME_DRIVER_PATH}     /Users/mink/Desktop/ChromeForTesting/chromedriver-mac-arm64/chromedriver
${BROWSER}         Chrome
${FORM_URL}        http://${SERVER}/form.html
${COMPLETE_URL}    http://${SERVER}/complete.html

# Input Data for Success
${FIRST_NAME}      Somsong
${LAST_NAME}       Sandee
${DESTINATION}     Europe
${CONTACT_PERSON}  Sodsai Sandee
${RELATIONSHIP}    Mother
${EMAIL}           somsong@kkumail.com
${PHONE_NO}        081-111-1234

*** Keywords ***
Open Browser To Form Page
    Open Browser    ${FORM_URL}    ${BROWSER}
    Maximize Browser Window
    Title Should Be    Customer Inquiry

Input Form Details
    Input Text    id:firstname    ${FIRST_NAME}
    Input Text    id:lastname     ${LAST_NAME}
    Input Text    id:destination   ${DESTINATION}
    Input Text    id:contactperson    ${CONTACT_PERSON}
    Input Text    id:relationship  ${RELATIONSHIP}
    Input Text    id:email         ${EMAIL}
    Input Text    id:phone      ${PHONE_NO}

Submit Form
    Click Button    id:submitButton

Verify Submission Success
    Wait Until Location Is    ${COMPLETE_URL}    timeout=5s
    Location Should Be    ${COMPLETE_URL}

*** Test Cases ***
001: Open Form
    [Documentation]    เปิดฟอร์ม
    Open Browser To Form Page

002: Record Success
    [Documentation]    กรอกข้อมูลที่ครบถ้วน
    Input Form Details
    Submit Form
    Verify Submission Success