import 'package:food_delivery_rezky/pages/cart/cart_page.dart';
import 'package:food_delivery_rezky/pages/food/popular_food_detail.dart';
import 'package:food_delivery_rezky/pages/food/recommended_food_detail.dart';
import 'package:food_delivery_rezky/pages/home/main_food_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String cartPage = "/cart-page";
  static const String initial = '/';
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recomended-food";
  static List<GetPage> routes = [
    GetPage(name: initial, page: () => MainFoodPage()),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters["page"];
          return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters["page"];
          return RecommendedFoodDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cartPage,
        page: () {
          return CartPage();
        },
        transition: Transition.fadeIn),
  ];

  static String getInitial() => '$initial';

  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';

  static String getRecommendedFood(int pageId, String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';

  static String getCartPage() => '$cartPage';
}
