*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${URL}  https://www.example.com
${TITLE}  Example Domain

*** Test Cases ***
Open Browser and Check Title
    ${options}=  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys, selenium.webdriver

# normally most chrome chrome functionality would be fine, even without a display,
# as long as we start it with the "headless" option. But to show the  virtual display works, 
# we'll omit the headless option
#
#    Call Method  ${options}  add_argument  --headless
    
    Call Method  ${options}  add_argument  --no-sandbox
    Call Method  ${options}  add_argument  --disable-dev-shm-usage
    Create Webdriver  Chrome  options=${options}
    Go To  ${URL}
    Title Should Be  ${TITLE}
    [Teardown]  Close Browser
