import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  static double pageViewContainer = screenHeight / 3.66;
  static double pageViewTextContainer = screenHeight / 6.71;
  static double pageView = screenHeight / 2.52;

  //dynamic height padding and margin
  static double height10 = screenHeight / 80.5;
  static double height15 = screenHeight / 53.67;
  static double height20 = screenHeight / 40.25;
  static double height30 = screenHeight / 26.83;
  static double height45 = screenHeight / 17.89;

  //dynamic width padding and margin
  static double width10 = screenHeight / 80.5;
  static double width15 = screenHeight / 53.67;
  static double width20 = screenHeight / 40.25;
  static double width30 = screenHeight / 26.83;

  //radius
  static double radius15 = screenHeight / 53.67;
  static double radius20 = screenHeight / 40.25;
  static double radius30 = screenHeight / 26.83;

  //font size
  static double font16 = screenHeight / 50.31;
  static double font20 = screenHeight / 40.25;
  static double font24 = screenHeight / 33.54;
  static double font26 = screenHeight / 30.96;

  //icon size
  static double iconSize16 = screenHeight / 50.31;
  static double iconSize24 = screenHeight / 33.54;

  //list view size
  static double listViewImgSize = screenWidth / 3.27;
  static double listVieTextContSize = screenWidth / 3.92;

  //popular food
  static double popularFoodImgSize = screenHeight / 2.3;

  //bottom height
  static double bottomHeightBar = screenHeight / 6.71;
}
