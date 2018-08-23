//package fi.jarih.robottesting;
//
//import com.codeborne.selenide.Condition;
//import com.codeborne.selenide.Configuration;
//import com.codeborne.selenide.Selenide;
//import org.openqa.selenium.By;
//
//import static com.codeborne.selenide.Selenide.$;
//
//public class SelenideKeywords {
//    public static final String ROBOT_LIBRARY_SCOPE = "GLOBAL";
//
//    public static void openSelenideBrowser(String url, String browser) {
//        try {
//            System.out.println("openSelenideBrowser URL: "+url);
//
//            Configuration.browser = browser;
//            Selenide.open(url);
//
//            $(By.xpath("//h1[contains(text(),'Sign in to GitHub')]")).shouldBe(Condition.visible);
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
//
//    public static void loginSelenideGithub(String username, String password) {
//        try {
//
//            $(By.id("login_field")).shouldBe(Condition.visible).val(username);
//            $(By.id("password")).shouldBe(Condition.visible).val(password);
//            $(By.xpath("//input[contains(@type,'submit')]")).shouldBe(Condition.visible).shouldBe(Condition.enabled).click();
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
//
//    public static void verifyWereOnGithubMainPage(String textInMainPage) {
//        try {
//
//            $(By.xpath("//a[contains(text(),'"+textInMainPage+"')]")).shouldBe(Condition.visible);
//            Selenide.sleep(5000);
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//    }
//}
//
