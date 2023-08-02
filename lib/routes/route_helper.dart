import 'package:food_delivery_app/pages/Food/popular_food_details.dart';
import 'package:food_delivery_app/pages/Food/recommended_food_details.dart';
import 'package:food_delivery_app/pages/address/add_address_page.dart';
import 'package:food_delivery_app/pages/auth/sign_in_page.dart';
import 'package:food_delivery_app/pages/auth/sign_up_page.dart';
import 'package:food_delivery_app/pages/cart/cart_page.dart';
import 'package:food_delivery_app/pages/home/home_page.dart';
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

  static String getInitial() => initial;
  static String getSplashPage() => splashPage;
  static String getPopularFood(int pageId) => '$popularFood?pageId=$pageId';
  static String getRecommendedFood(int pageId) => '$recommendedFood?pageId=$pageId';
  static String getCartPage() => cartPage;
  static String getLoginPage() => login;
  static String getRegisterPage() => register;
  static String getAddAddressPage() => addAddress;
  static String getPickAddressPage() => pickAddressMap;

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
          return  AddAddressPage();
        },
        transition: Transition.fadeIn,
    ),
    GetPage(
        name: pickAddressMap,
        page: () {
          PickAddressMap _pickAddress = Get.arguments;
          return _pickAddress;
        },
        transition: Transition.fadeIn,
    ),
  ];
}
