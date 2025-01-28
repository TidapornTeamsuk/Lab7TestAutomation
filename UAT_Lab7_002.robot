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

# Error Messages
${DESTINATION_ERROR}   Please enter your destination.
${EMAIL_ERROR}         Please enter a valid email address.
${PHONE1_ERROR}         Please enter a phone number.
${PHONE2_ERROR}         Please enter a valid phone number, e.g., 081-234-5678, 081 234 5678, or 081.234.5678.


*** Keywords ***
Open Browser To Form Page
    Open Browser    ${FORM_URL}    ${BROWSER}
    Maximize Browser Window
    Title Should Be    Customer Inquiry

Submit Form
    Click Button    id:submitButton

Verify Error Message
    [Arguments]    ${error_message}
    Element Should Contain    id:errors    ${error_message}

*** Test Cases ***
001: Empty Destination
    [Documentation]    กรอกข้อมูลบางช่อง โดยไม่กรอก Destination
    Input Text    id:firstname    ${FIRST_NAME}
    Input Text    id:lastname     ${LAST_NAME}
    Input Text    id:contactperson    ${CONTACT_PERSON}
    Input Text    id:relationship  ${RELATIONSHIP}
    Input Text    id:email         ${EMAIL}
    Input Text    id:phone      ${PHONE_NO}
    Submit Form
    Verify Error Message    ${DESTINATION_ERROR}

002: Empty Email
    [Documentation]    กรอกข้อมูลบางช่อง โดยไม่กรอก Email
    Input Text    id:firstname    ${FIRST_NAME}
    Input Text    id:lastname     ${LAST_NAME}
    Input Text    id:destination   ${DESTINATION}
    Input Text    id:contactperson    ${CONTACT_PERSON}
    Input Text    id:relationship  ${RELATIONSHIP}
    Input Text    id:phone      ${PHONE_NO}
    Submit Form
    Verify Error Message    ${EMAIL_ERROR}

003: Invalid Email
    [Documentation]    กรอกข้อมูล Email ไม่ถูกต้อง
    Input Text    id:firstname    ${FIRST_NAME}
    Input Text    id:lastname     ${LAST_NAME}
    Input Text    id:destination   ${DESTINATION}
    Input Text    id:contactperson    ${CONTACT_PERSON}
    Input Text    id:relationship  ${RELATIONSHIP}
    Input Text    id:email         somsong@
    Input Text    id:phone      ${PHONE_NO}
    Submit Form
    Verify Error Message    ${EMAIL_ERROR}

004: Empty Phone Number
    [Documentation]    กรอกข้อมูลบางช่อง โดยไม่กรอก Phone Number
    Input Text    id:firstname    ${FIRST_NAME}
    Input Text    id:lastname     ${LAST_NAME}
    Input Text    id:destination   ${DESTINATION}
    Input Text    id:contactperson    ${CONTACT_PERSON}
    Input Text    id:relationship  ${RELATIONSHIP}
    Input Text    id:email         ${EMAIL}
    Submit Form
    Verify Error Message    ${PHONE1_ERROR}

005: Invalid Phone Number
    [Documentation]    กรอกข้อมูล Phone Number ไม่ถูกต้อง
    Input Text    id:firstname    ${FIRST_NAME}
    Input Text    id:lastname     ${LAST_NAME}
    Input Text    id:destination   ${DESTINATION}
    Input Text    id:contactperson    ${CONTACT_PERSON}
    Input Text    id:relationship  ${RELATIONSHIP}
    Input Text    id:email         ${EMAIL}
    Input Text    id:phone      191
    Submit Form
    Verify Error Message    ${PHONE2_ERROR}
