class AppConstants{
  //App
  static const String App_Name = "FoodApp";
  static const int App_Version = 1;

  // End points
  static const String BASEURL = 'http://mvs.bslmeiyu.com';
  static const String POPULAR_PRODUCT_URL = "/api/v1/products/popular";
  static const String RECOMMENDED_PRODUCT_URL = "/api/v1/products/recommended";
  static const String UPLOAD_URL = "/uploads/";
  static const String REGISTRATION_URL = "/api/v1/auth/register";
  static const String LOGIN_URL = "/api/v1/auth/login";
  static const String USER_INFO_URL = "/api/v1/customer/info";
  // Location
  static const String GEOCODE_URL = "/api/v1/config/geocode-api";
  static const String ADD_USER_ADDRESS_URL = "/api/v1/customer/address/add";
  static const String ADDRESS_LIST_URL = "/api/v1/customer/address/list";
  static const String ZONE_URL = "/api/v1/config/get-zone-id";

  // User shared preferences keys
  static const String TOKEN = "userToken";
  static const String PHONE = "phone";
  static const String PASSWORD = "password";
  static const String USER_ADDRESS = "/user_address";

  // cart
  static const String CART_LIST = 'Cart-List';
  static const String CART_HISTORY_LIST = 'Cart-History-List';


}