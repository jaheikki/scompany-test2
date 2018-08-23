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