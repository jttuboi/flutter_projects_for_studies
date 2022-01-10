const String SplashPath = '/splash';
const String LoginPath = '/login';
const String CreateAccountPath = '/createAccount';
const String ListItemsPath = '/listItems';
const String DetailsPath = '/details';
const String CartPath = '/cart';
const String CheckoutPath = '/checkout';
const String SettingsPath = '/settings';

enum Pages {
  Splash,
  Login,
  CreateAccount,
  List,
  Details,
  Cart,
  Checkout,
  Settings,
}

const PageConfiguration SplashPageConfig = PageConfiguration(
  key: 'Splash',
  path: SplashPath,
  uiPage: Pages.Splash,
);
const PageConfiguration LoginPageConfig = PageConfiguration(
  key: 'Login',
  path: LoginPath,
  uiPage: Pages.Login,
);
const PageConfiguration CreateAccountPageConfig = PageConfiguration(
  key: 'CreateAccount',
  path: CreateAccountPath,
  uiPage: Pages.CreateAccount,
);
const PageConfiguration ListItemsPageConfig = PageConfiguration(
  key: 'ListItems',
  path: ListItemsPath,
  uiPage: Pages.List,
);
const PageConfiguration DetailsPageConfig = PageConfiguration(
  key: 'Details',
  path: DetailsPath,
  uiPage: Pages.Details,
);
const PageConfiguration CartPageConfig = PageConfiguration(
  key: 'Cart',
  path: CartPath,
  uiPage: Pages.Cart,
);
const PageConfiguration CheckoutPageConfig = PageConfiguration(
  key: 'Checkout',
  path: CheckoutPath,
  uiPage: Pages.Checkout,
);
const PageConfiguration SettingsPageConfig = PageConfiguration(
  key: 'Settings',
  path: SettingsPath,
  uiPage: Pages.Settings,
);

class PageConfiguration {
  const PageConfiguration({
    required this.key,
    required this.path,
    required this.uiPage,
  });

  final String key;
  final String path;
  final Pages uiPage;
}
