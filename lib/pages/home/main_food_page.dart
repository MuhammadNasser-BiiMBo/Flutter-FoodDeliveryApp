import 'package:flutter/material.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../constants/dimensions.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/location_controller.dart';
import '../../controllers/user_controller.dart';
import 'food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {

  @override
  Widget build(BuildContext context) {
    if(Get.find<AuthController>().userLoggedIn()){
      Get.find<UserController>().getUserInfo().then((value) => Get.find<LocationController>().getUserAddress());
    }
    return  Scaffold(
      appBar: AppBar(
        title:Container(
          padding:  EdgeInsets.symmetric(horizontal: Dimensions.width10),
          margin:  EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height15),
          child: SizedBox(
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(text: 'Bangladesh',color: AppColors.mainColor,),
                    Row(
                      children: [
                        SmallText(text: 'Narsindgi',color: Colors.black,),
                        const Icon(
                          Icons.arrow_drop_down_rounded,
                        )
                      ],
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.height15),
                    color: AppColors.mainColor,
                  ),
                  width: Dimensions.width45,
                  height: Dimensions.height45,
                  child:  Icon(Icons.search,color: Colors.white,size: Dimensions.iconSize24,),
                )
              ],
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
      ),
      body: Column(
        children: [
          SizedBox(height: Dimensions.height20,),
          const Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: FoodPageBody()
            ),
          ),
        ],
      ),
    );
  }
}
