import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';

class FoodDataColumn extends StatelessWidget {
  final String text;
  double? size;
  final int index;
  FoodDataColumn(
      {super.key, required this.text, this.size, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text, size: size == null ? 0 : size!),
        SizedBox(
          height: Dimensions.height10,
        ),
        Center(
          child: SmallText(
            text: Get.find<PopularProductController>()
                .popularProductList[index]
                .description,
            size: 16,
            isExpandable: false,
          ),
        ),
        SizedBox(
          height: Dimensions.height15,
        ),
        Row(
          children: [
            Expanded(
              child: IconAndText(
                  icon: Icons.monetization_on_outlined,
                  text:
                      ' ${Get.find<PopularProductController>().popularProductList[index].price} EGP',
                  iconColor: AppColors.mainColor),
            ),
            Wrap(
              children: List.generate(
                  Get.find<PopularProductController>()
                      .popularProductList[index]
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
                    '${Get.find<PopularProductController>().popularProductList[index].stars} stars'),
            SizedBox(
              width: Dimensions.width20,
            ),
          ],
        ),
      ],
    );
  }
}
