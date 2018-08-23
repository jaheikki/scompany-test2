# scompany-test2

Normal robot case:

```
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

```

The RobotFW test report of normal case should look like this:

 <img src="https://raw.githubusercontent.com/jaheikki/scompany-test2/master/robot-normal-test-report.png" width="600" height="300">

BDD-style Robot test suite:

```
*** Settings ***
Force Tags  bdd
Library     fi.jarih.robottesting.SelenideKeywords

*** Variables ***
${BROWSER}                        chrome
${MAIN_URL}                       https://github.com/login
${LOGIN_USER}                     ${EMPTY}
${LOGIN_PASSWORD}                 ${EMPTY}

*** Test Cases ***
Login Selenide Github testcase
    Given Github sign in page should be open
    When I log into Github
    Then Github main page is displayed

*** Keywords ***
Github sign in page should be open
    [Documentation]
    openSelenideBrowser  ${MAIN_URL}  ${BROWSER}

I log into Github
    [Documentation]
    loginSelenideGithub  ${LOGIN_USER}  ${LOGIN_PASSWORD}

Github main page is displayed
    [Documentation]
    verifyWereOnGithubMainPage  Pull requests
```

The RobotFW test report of BDD case should look like this:

 <img src="https://raw.githubusercontent.com/jaheikki/scompany-test2/master/robot-bdd-test-report.png" width="600" height="300">
