class AppConstants {
  static const String APP_NAME = "Food Express";
  static const int APP_VERSION = 1;

  static const String BASE_URL = "http://10.0.2.2:3000";

  //food endpoints
  static const String POPULAR_PRODUCT_URI = "/api/products/popular";

  //orders endpoints
  static const String ORDERS_URI = "/api/orders";

  //auth endpoints
  static const String REGISTER_URI = "/api/auth/register";
  static const String LOGIN_URI = "/api/auth/login";
  static const String USER_INFO_URI = "/api/user/info";

  static const String TOKEN = "FoodExpress";
  static const String USER_ID = 'user-id';
  static const String CART_LIST = "cart-list";
  static const String CART_HISTORY_LIST = "cart-history-list";
}
