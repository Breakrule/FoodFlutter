import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_rezky/controller/popular_product_controller.dart';
import 'package:food_delivery_rezky/controller/recommended_product_controller.dart';
import 'package:food_delivery_rezky/models/products_model.dart';
import 'package:food_delivery_rezky/routes/route_helper.dart';
import 'package:food_delivery_rezky/utils/app_constant.dart';
import 'package:food_delivery_rezky/utils/colors.dart';
import 'package:food_delivery_rezky/utils/dimension.dart';
import 'package:food_delivery_rezky/widget/app_column.dart';
import 'package:food_delivery_rezky/widget/big_text.dart';
import 'package:food_delivery_rezky/widget/icon_and_text_widget.dart';
import 'package:food_delivery_rezky/widget/small_text.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //slider section
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isLoaded
              ? Container(
                  height: Dimensions.pageView,
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: popularProducts.popularProductList.length,
                      itemBuilder: (context, position) {
                        return _buildPageItem(position,
                            popularProducts.popularProductList[position]);
                      }),
                )
              : const CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),
        //dots
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            position: _currPageValue.toInt(),
            decorator: const DotsDecorator(
              color: Colors.grey, // Inactive color
              activeColor: AppColors.mainColor,
            ),
          );
        }),
        //popular text
        SizedBox(height: Dimensions.height30),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              SizedBox(width: Dimensions.width10),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              SizedBox(width: Dimensions.width10),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(
                  text: "Food pairing",
                ),
              )
            ],
          ),
        ), // recommended food
        //List of food and images
        GetBuilder<RecommendedProductController>(
            builder: (recommendedProducts) {
          return recommendedProducts.isLoaded
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: recommendedProducts.recommendedProductList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getRecommendedFood(index));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                            bottom: Dimensions.height10),
                        child: Row(
                          children: [
                            //image section
                            Container(
                              width: Dimensions.listViewImgSize,
                              height: Dimensions.listViewImgSize,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                                color: Colors.white38,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      "${AppConstants.BASE_URL}${AppConstants.UPLOAD_URI}${recommendedProducts.recommendedProductList[index].img}"),
                                ),
                              ),
                            ),
                            //text container
                            Expanded(
                              child: Container(
                                height: Dimensions.listVieTextContSize,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight:
                                        Radius.circular(Dimensions.radius20),
                                    bottomRight:
                                        Radius.circular(Dimensions.radius20),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: Dimensions.width10,
                                    right: Dimensions.width10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      BigText(
                                          text: recommendedProducts
                                              .recommendedProductList[index]
                                              .name!),
                                      SizedBox(height: Dimensions.height10),
                                      SmallText(
                                          text:
                                              "With banjarbaru characteristics"),
                                      SizedBox(height: Dimensions.height10),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconAndTextWidget(
                                              icon: Icons.circle_sharp,
                                              text: "Normal",
                                              iconColor: AppColors.iconColor1),
                                          IconAndTextWidget(
                                              icon: Icons.location_on,
                                              text: "1,7km",
                                              iconColor: AppColors.mainColor),
                                          IconAndTextWidget(
                                              icon: Icons.access_time_rounded,
                                              text: "31min",
                                              iconColor: AppColors.iconColor2),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })
              : const CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 0);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: index.isEven
                    ? const Color(0xFF69c5df)
                    : const Color(0xFF9294cc),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "${AppConstants.BASE_URL}${AppConstants.UPLOAD_URI}${popularProduct.img!}"),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width30,
                  right: Dimensions.width30,
                  bottom: Dimensions.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5, 0),
                    ),
                  ]),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height15, left: 15, right: 15),
                child: AppColumn(
                  text: popularProduct.name!,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
