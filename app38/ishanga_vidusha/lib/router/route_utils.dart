enum AppPage {
  splash,
  login,
  home,
  error,
  onBoarding,
}

extension AppPageExtension on AppPage {
  String get toPath {
    switch (this) {
      case AppPage.home:
        return "/";
      case AppPage.login:
        return "/login";
      case AppPage.splash:
        return "/splash";
      case AppPage.error:
        return "/error";
      case AppPage.onBoarding:
        return "/start";
      default:
        return "/";
    }
  }

  String get toName {
    switch (this) {
      case AppPage.home:
        return "HOME";
      case AppPage.login:
        return "LOGIN";
      case AppPage.splash:
        return "SPLASH";
      case AppPage.error:
        return "ERROR";
      case AppPage.onBoarding:
        return "START";
      default:
        return "HOME";
    }
  }

  String get toTitle {
    switch (this) {
      case AppPage.home:
        return "My App";
      case AppPage.login:
        return "My App Log In";
      case AppPage.splash:
        return "My App Splash";
      case AppPage.error:
        return "My App Error";
      case AppPage.onBoarding:
        return "Welcome to My App";
      default:
        return "My App";
    }
  }
}
