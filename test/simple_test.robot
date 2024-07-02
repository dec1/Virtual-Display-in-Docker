*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${URL}  https://www.example.com
${TITLE}  Example Domain

*** Test Cases ***
Open Browser and Check Title
    ${options}=  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys, selenium.webdriver
    Call Method  ${options}  add_argument  --headless
    Call Method  ${options}  add_argument  --no-sandbox
    Call Method  ${options}  add_argument  --disable-dev-shm-usage
    Create Webdriver  Chrome  options=${options}
    Go To  ${URL}
    Title Should Be  ${TITLE}
    [Teardown]  Close Browser
