import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/constants/dimensions.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/controllers/recommended_product_controller.dart';
import 'package:food_delivery_app/models/products_model.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/icon_and_text_widget.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../../widgets/food_data_column.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(
    viewportFraction: 0.85,
  );
  var _currPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimensions.pageViewContainerHeight;

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
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          if (popularProducts.isLoaded) {
            return SizedBox(
              height: Dimensions.pageViewHeight,
              child: PageView.builder(
                  controller: pageController,
                  itemCount: popularProducts.popularProductList.length,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return _buildPageItem(
                        index, popularProducts.popularProductList[index]);
                  }),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.mainColor),
            );
          }
        }),
        GetBuilder<PopularProductController>(
          builder: (popularProducts) => DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            position: _currPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9),
              activeSize: const Size(18, 9),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius10 / 2)),
            ),
          ),
        ),
        SizedBox(
          height: Dimensions.height30,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: 'Recommended'),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                  margin: const EdgeInsets.only(bottom: 3),
                  child: BigText(text: '.', color: Colors.black26)),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(
                  text: 'Food pairing',
                  size: 12,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        GetBuilder<RecommendedProductController>(
            builder: (recommendedProducts) {
          if (recommendedProducts.isLoaded) {
            return ListView.builder(
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
                        right: Dimensions.width20,
                        left: Dimensions.width10,
                        bottom: Dimensions.height10),
                    child: Row(
                      children: [
                        //Image Section
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius15),
                          ),
                          height: Dimensions.listViewImgSize,
                          width: Dimensions.listViewImgSize,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: AppConstants.BASE_URL +
                                AppConstants.UPLOAD_URL +
                                recommendedProducts
                                    .recommendedProductList[index].img!,
                          ),
                        ),
                        //Text Container
                        Expanded(
                          child: Container(
                            height: Dimensions.listViewTextContSize,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(Dimensions.radius20),
                                bottomRight:
                                    Radius.circular(Dimensions.radius20),
                              ),
                              boxShadow: const [
                                BoxShadow(
                                    offset: Offset(1, 1),
                                    blurRadius: 1,
                                    color: Colors.black26),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: Dimensions.width10 / 2,
                                right: Dimensions.width10 / 2,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  BigText(
                                    text: recommendedProducts
                                        .recommendedProductList[index].name,
                                  ),
                                  SmallText(
                                    text: recommendedProducts
                                        .recommendedProductList[index]
                                        .description,
                                    isExpandable: false,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: IconAndText(
                                            icon:
                                                Icons.monetization_on_outlined,
                                            text:
                                                ' ${Get.find<RecommendedProductController>().recommendedProductList[index].price} EGP',
                                            iconColor: AppColors.mainColor),
                                      ),
                                      Wrap(
                                        children: List.generate(
                                            Get.find<
                                                    RecommendedProductController>()
                                                .recommendedProductList[index]
                                                .stars,
                                            (index) => Icon(
                                                  Icons.star,
                                                  color: AppColors.mainColor,
                                                  size: Dimensions.height15,
                                                )),
                                      ),
                                      SizedBox(
                                        width: Dimensions.width10 / 2,
                                      ),
                                      SmallText(
                                          text:
                                              '${Get.find<RecommendedProductController>().recommendedProductList[index].stars} stars'),
                                      SizedBox(
                                        width: Dimensions.width20,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: AppColors.mainColor,
            ));
          }
        })
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    // Page Transforming animations
    //----------------------------------------------------
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
    //----------------------------------------------------

    return Transform(
      transform: matrix,
      child: GestureDetector(
        onTap: () {
          Get.toNamed(RouteHelper.getPopularFood(index));
        },
        child: Stack(
          children: [
            Container(
              height: Dimensions.pageViewContainerHeight,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: Dimensions.width10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: AppColors.mainColor,
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: AppConstants.BASE_URL +
                    AppConstants.UPLOAD_URL +
                    popularProduct.img!,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: Dimensions.pageViewTextContainerHeight,
                width: double.infinity,
                margin: EdgeInsets.only(
                    bottom: Dimensions.height15,
                    left: Dimensions.width30,
                    right: Dimensions.width30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0xFFe8e8e8),
                          blurRadius: 5,
                          offset: Offset(0, 5))
                    ]),
                child: Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height15,
                      left: Dimensions.width20,
                      right: Dimensions.width10),
                  child:
                      FoodDataColumn(text: popularProduct.name!, index: index),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
