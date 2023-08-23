import 'package:food_delivery_app/pages/Food/popular_food_details.dart';
import 'package:food_delivery_app/pages/Food/recommended_food_details.dart';
import 'package:food_delivery_app/pages/address/add_address_page.dart';
import 'package:food_delivery_app/pages/auth/sign_in_page.dart';
import 'package:food_delivery_app/pages/auth/sign_up_page.dart';
import 'package:food_delivery_app/pages/cart/cart_page.dart';
import 'package:food_delivery_app/pages/home/home_page.dart';
import 'package:food_delivery_app/pages/payment/ReferenceCodePage.dart';
import 'package:food_delivery_app/pages/payment/card_payment_page.dart';
import 'package:food_delivery_app/pages/payment/payment_screen.dart';
import 'package:food_delivery_app/pages/splash/splash_screen.dart';
import 'package:get/get.dart';
import '../pages/address/pick_address_page.dart';


class RouteHelper {
  static const String initial = '/';
  static const String splashPage = '/splash-page';
  static const String popularFood = '/popular-food';
  static const String recommendedFood = '/recommended-food';
  static const String cartPage = '/cart-page';
  static const String login = '/login-page';
  static const String register = '/register-page';
  static const String addAddress = '/add-address';
  static const String pickAddressMap = '/pick-address';
  // static const String payment = '/payment';
  static const String refCodePayment = '/payment/ref-code';
  static const String cardPayment = '/payment/card';
  static const String paymentMethods = '/payment-methods';
  // static const String orderSuccess = '/order-successful';

  static String getInitial() => initial;
  static String getSplashPage() => splashPage;
  static String getPopularFood(int pageId) => '$popularFood?pageId=$pageId';
  static String getRecommendedFood(int pageId) => '$recommendedFood?pageId=$pageId';
  static String getCartPage() => cartPage;
  static String getLoginPage() => login;
  static String getRegisterPage() => register;
  static String getAddAddressPage() => addAddress;
  static String getPickAddressPage() => pickAddressMap;
  static String getPaymentMethods() => paymentMethods;
  static String getRefCodePayment() => refCodePayment;
  static String getCardPayment() => cardPayment;
  // static String getPaymentPage(String id , int userId) => '$payment?id=$id&userId=$userId';
  // static String getOrderSuccessPage(String orderID,String status) => '$orderSuccess?id=$orderID&status=$status';

  static List<GetPage> routes = [
    GetPage(
        name: initial,
        page: () {
          return const HomePage();
        },
        transition: Transition.fadeIn
    ),
    GetPage(
        name: popularFood,
        page: () {
          var pageId =Get.parameters['pageId'];
          return  PopularFoodDetails(pageId:int.parse(pageId!));
        },
        transition: Transition.fadeIn
    ),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId =Get.parameters['pageId'];
          return  RecommendedFoodDetails(pageId: int.parse(pageId!),);
        },
        transition: Transition.fadeIn
    ),
    GetPage(
        name: cartPage,
        page: () {
          return const CartPage();
        },
        transition: Transition.fadeIn,
    ),
    GetPage(
        name: splashPage,
        page: () {
          return const SplashScreen();
        },
        transition: Transition.fadeIn,
    ),
    GetPage(
        name: login,
        page: () {
          return  SignInPage();
        },
        transition: Transition.fadeIn,
    ),
    GetPage(
        name: register,
        page: () {
          return  SignUpPage();
        },
        transition: Transition.fadeIn,
    ),
    GetPage(
        name: addAddress,
        page: () {
          return const AddAddressPage();
        },
        transition: Transition.fadeIn,
    ),
    GetPage(
        name: paymentMethods,
        page: () {
          return const PaymentMethodsScreen();
        },
        transition: Transition.fadeIn,
    ),
    GetPage(
        name: refCodePayment,
        page: () {
          return const ReferenceCodePage();
        },
        transition: Transition.fadeIn,
    ),
    GetPage(
        name: cardPayment,
        page: () {
          return const CardPaymentScreen();
        },
        transition: Transition.fadeIn,
    ),
    GetPage(
        name: pickAddressMap,
        page: () {
          PickAddressMap pickAddress = Get.arguments;
          return pickAddress;
        },
        transition: Transition.fadeIn,
    ),
    // GetPage(
    //     name: payment,
    //     page: () {
    //
    //       return PaymentPage(orderModel: OrderModel(id: int.parse(Get.parameters['id']!), userId:  int.parse(Get.parameters['userId']!)));
    //     },
    //     transition: Transition.fadeIn,
    // ),
    // GetPage(
    //     name: orderSuccess,
    //     page: () {
    //       return OrderSuccessPage(
    //         orderID:Get.parameters['id']!,
    //         status:Get.parameters['status'].toString().contains('success')?1:0,
    //       );
    //     },
    //     transition: Transition.fadeIn,
    // ),
  ];
}
