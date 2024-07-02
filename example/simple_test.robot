*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${URL}  https://www.example.com
${TITLE}  Example Domain
${CHROME_OPTIONS}  headless, no-sandbox, disable-dev-shm-usage

*** Test Cases ***
Open Browser and Check Title
    Open Browser  ${URL}  browser=chrome  options=${CHROME_OPTIONS}
    Title Should Be  ${TITLE}
    [Teardown]  Close Browser
