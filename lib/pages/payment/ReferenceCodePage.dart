import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/constants/dimensions.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/custom_button.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';

class ReferenceCodePage extends StatelessWidget {
  const ReferenceCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reference Code'),
        backgroundColor: AppColors.mainColor,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(RouteHelper.getInitial());
            },
            icon: const Icon(Icons.exit_to_app, size: 28),
          ),
          SizedBox(
            width: Dimensions.width10,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BigText(text: 'You should go to any market to pay', size: 20),
            SizedBox(
              height: Dimensions.height20,
            ),
            SmallText(
              text: 'The Reference Code is :',
              color: Colors.black,
              size: 18,
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            CustomButton(
              buttonText: AppConstants.refCode ?? '🚫',
              fontSize: Dimensions.fontSize20 * 2,
              buttonColor: AppColors.mainColor,
              radius: Dimensions.radius15,
              height: Dimensions.height30 * 2,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
