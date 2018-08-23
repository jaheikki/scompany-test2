# scompany-test2


This project demoes truly working "login to Github" by running Robot Framework with 2 styles:

1. Normal Robot style but using robotframework-maven-plugin i.e. Java as platform.
2. BDD/Gherkin style of writing Robot, still Java as platform, but keywords are written by Java library, SelenideKeywords.java. Browser is controlled by Selenide Java library so normal Robot keywords are not used at all. This may not be the real use case but just to present extending Robot with Java library.

Note: Normal Robot case (login-system.robot) and BDD Robot case (bdd-selenide-login.robot) cannot be running at the same time because of mixing dependencies in pom.xml (=Selenium stuff from 2 sources). The normal case, i.e. login-system.robot is working by default. If you want to test the bdd-selenide-login.robot:

1. uncomment SelenideKeywords.java
2. uncomment "selenide"-dependency
3. comment "robotframework-selenium2library-java"-dependency

Guide to run tests & get Robot test report:

1. Install git, Java 8 and Maven 3
2. git clone https://github.com/jaheikki/scompany-test2.git
3. cd scompany-test2
3. mvn -Probot -Drobot.login.username="your Github username" -Drobot.login.password="your Github password" clean install -Drobot.tag=normal #or
4. mvn -Probot -Drobot.login.username="your Github username" -Drobot.login.password="your Github password" clean install -Drobot.tag=bdd
   

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
 
 SelenideKeywords.java as keyword library for Robot:
 
 ```
 package fi.jarih.robottesting;

import com.codeborne.selenide.Condition;
import com.codeborne.selenide.Configuration;
import com.codeborne.selenide.Selenide;
import org.openqa.selenium.By;

import static com.codeborne.selenide.Selenide.$;

public class SelenideKeywords {
    public static final String ROBOT_LIBRARY_SCOPE = "GLOBAL";

    public static void openSelenideBrowser(String url, String browser) {
        try {
            System.out.println("openSelenideBrowser URL: "+url);

            Configuration.browser = browser;
            Selenide.open(url);

            $(By.xpath("//h1[contains(text(),'Sign in to GitHub')]")).shouldBe(Condition.visible);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void loginSelenideGithub(String username, String password) {
        try {

            $(By.id("login_field")).shouldBe(Condition.visible).val(username);
            $(By.id("password")).shouldBe(Condition.visible).val(password);
            $(By.xpath("//input[contains(@type,'submit')]")).shouldBe(Condition.visible).shouldBe(Condition.enabled).click();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void verifyWereOnGithubMainPage(String textInMainPage) {
        try {

            $(By.xpath("//a[contains(text(),'"+textInMainPage+"')]")).shouldBe(Condition.visible);
            Selenide.sleep(5000);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}


 ```
