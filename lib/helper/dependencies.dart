import 'package:food_delivery_rezky/controller/popular_product_controller.dart';
import 'package:food_delivery_rezky/data/api/api_client.dart';
import 'package:food_delivery_rezky/data/repository/popular_product_repo.dart';
import 'package:get/get.dart';

Future<void> init() async {
  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: "http://mvs.bslmeiyu.com"));

  //Repo
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));

  //controller
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
}
