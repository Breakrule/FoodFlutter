import 'package:food_delivery_rezky/controller/cart_controller.dart';
import 'package:food_delivery_rezky/controller/popular_product_controller.dart';
import 'package:food_delivery_rezky/controller/recommended_product_controller.dart';
import 'package:food_delivery_rezky/data/api/api_client.dart';
import 'package:food_delivery_rezky/data/repository/cart_repo.dart';
import 'package:food_delivery_rezky/data/repository/popular_product_repo.dart';
import 'package:food_delivery_rezky/data/repository/recommended_product_repo.dart';
import 'package:food_delivery_rezky/utils/app_constant.dart';
import 'package:get/get.dart';

Future<void> init() async {
  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //Repo
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo());

  //controller
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
