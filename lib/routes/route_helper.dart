import 'package:food_delivery_app/pages/Food/popular_food_details.dart';
import 'package:food_delivery_app/pages/Food/recommended_food_details.dart';
import 'package:food_delivery_app/pages/cart/cart_page.dart';
import 'package:food_delivery_app/pages/home/home_page.dart';
import 'package:food_delivery_app/pages/home/main_food_page.dart';
import 'package:food_delivery_app/pages/splash/splash_screen.dart';
import 'package:get/get.dart';


class RouteHelper {
  static const String initial = '/';
  static const String splashPage = '/splash-page';
  static const String popularFood = '/popular-food';
  static const String recommendedFood = '/recommended-food';
  static const String cartPage = '/cart-page';

  static String getInitial() => initial;
  static String getSplashPage() => splashPage;
  static String getPopularFood(int pageId) => '$popularFood?pageId=$pageId';
  static String getRecommendedFood(int pageId) => '$recommendedFood?pageId=$pageId';
  static String getCartPage() => '$cartPage';

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
  ];
}
