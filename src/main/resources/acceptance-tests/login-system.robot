*** Settings ***
Force Tags  normal
Library     Selenium2Library

Suite Setup  Open given Browser And Navigate to Main Page
Suite Teardown  Close Browser

*** Variables ***
${BROWSER}                        chrome
${MAIN_URL}                       https://github.com/login
${LOGIN_USER}                     ${EMPTY}
${LOGIN_PASSWORD}                 ${EMPTY}

*** Test Cases ***
Login Github testcase
    Login Github

*** Keywords ***
Open given Browser And Navigate to Main Page
    [Documentation]
    Open Browser  ${MAIN_URL}  ${BROWSER}
    Wait Until Page Contains    Sign in to GitHub

Login Github
    [Documentation]
    Input Text  id=login_field  ${LOGIN_USER}
    Input Password  id=password  ${LOGIN_PASSWORD}
    Click Button  //input[contains(@type,'submit')]
    Wait Until Page Contains    Pull requests
    Sleep  5s
