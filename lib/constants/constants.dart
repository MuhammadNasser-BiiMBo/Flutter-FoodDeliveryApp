class AppConstants{
  //App
  static const String App_Name = "FoodApp";
  static const int App_Version = 1;

  // End points
  static const String BASE_URL = 'http://mvs.bslmeiyu.com';
  // Maps api key => AIzaSyBnDB0HLyjsX3Pvn3BqkEj9fG-XPGcflpw
  // static const String BASE_URL = 'http://127.0.0.1:8000';
  // static const String BASE_URL = 'http://10.0.2.2:8000';
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
  static const String SEARCH_LOCATION_URL = "/api/v1/config/place-api-autocomplete";
  static const String PLACE_DETAILS_URL = "/api/v1/config/place-api-details";

  // orders
  static const String PLACE_ORDER_URL = '/api/v1/customer/order/place';

  // payment End points
  static const String PAYMENT_BASE_URL = 'https://accept.paymob.com/api';
  static const String GET_PAYMENT_AUTH_TOKEN ='/auth/tokens';
  static const String PAYMENT_API_KEY = 'ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2T0RneU56YzNMQ0p1WVcxbElqb2lNVFk1TWpjeE56RTNOaTQxT1RRMk1USWlmUS5uV2xNY29KS05CYmJGMVBpMzFJaVhiRUVadnBocTBBUVNmSnFFYzdJWk1pdFB3bnNRSDZqOU5ibkxWdW4xRDRFcUJVMjNJUEcyaGEyNVpkeEd0dllNZw==';
  static const String GET_ORDER_ID ='/ecommerce/orders';
  static const String GET_PAYMENT_ID ='/acceptance/payment_keys';
  static const String GET_REF_CODE = '/acceptance/payments/pay';
  static String visaUrl = 'https://accept.paymob.com/api/acceptance/iframes/782755?payment_token=$finalToken';
  static String paymentFirstToken = '';
  static String paymentOrderId = '';
  static String finalToken = '';
  static String refCode = '';
  // integration Ids
  static String kioskIntegrationId ='4121135';
  static String cardIntegrationId ='4119296';
  // User shared preferences keys
  static const String TOKEN = "userToken";
  static const String PHONE = "phone";
  static const String PASSWORD = "password";
  static const String USER_ADDRESS = "/user_address";

  // cart
  static const String CART_LIST = 'Cart-List';
  static const String CART_HISTORY_LIST = 'Cart-History-List';

  // payment asset images
  static const String visaImage = 'assets/images/VisaPaymentImage.png';
  static const String refCodeImage = 'assets/images/refCodeImage.png';


}