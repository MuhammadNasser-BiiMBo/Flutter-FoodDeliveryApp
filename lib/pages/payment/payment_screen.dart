import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/constants/dimensions.dart';
import 'package:food_delivery_app/controllers/payment_controller.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/custom_button.dart';
import 'package:get/get.dart';
import '../../constants/constants.dart';
import '../../controllers/cart_controller.dart';
import '../../routes/route_helper.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Payment Methods'),
        backgroundColor: AppColors.mainColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
           vertical:Dimensions.height20,
          horizontal: Dimensions.width20
        ),
        child: Column(
          children: [
            Expanded(
              child: InkWell(
                onTap: (){
                  Get.find<PaymentController>().getRefCode().then((value) {
                    Get.toNamed(RouteHelper.getRefCodePayment());
                  });
                  Get.find<CartController>().addToCartHistory();
                  Get.find<CartController>().getCartHistoryList();
                },
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      color: Colors.grey[200],
                    border: Border.all(
                      color: AppColors.mainColor,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppConstants.refCodeImage),
                      SizedBox(height: Dimensions.height20,),
                      BigText(text: 'Reference Code',size: 35,)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            Expanded(
              child: InkWell(
                onTap: (){
                  Get.toNamed(RouteHelper.getCardPayment());
                  Get.find<CartController>().addToCartHistory();
                  Get.find<CartController>().getCartHistoryList();
                },
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      color: Colors.grey[200],
                    border: Border.all(
                      color: AppColors.mainColor,
                      width: 2,
                    ),
                  ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppConstants.visaImage),
                        SizedBox(height: Dimensions.height20,),
                        BigText(text: 'Card Payment',size: 35,)
                      ],
                    ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
