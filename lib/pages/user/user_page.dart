import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/constants/dimensions.dart';
import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/location_controller.dart';
import 'package:food_delivery_app/controllers/user_controller.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/profile_widget.dart';
import 'package:get/get.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {

    if(Get.find<AuthController>().userLoggedIn()){
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        title: BigText(
          text: 'Profile',
          color: Colors.white,
          size: 24,
        ),
      ),
      body: GetBuilder<UserController>(
        builder: (userController){
          if(Get.find<AuthController>().userLoggedIn()){
            if(userController.isLoading){
              return const Center(child: CircularProgressIndicator(),);
            }else{
              return Container(
                margin: EdgeInsets.only(top: Dimensions.height20),
                width: double.maxFinite,
                child: Column(
                  children: [
                    // profile Icon
                    AppIcon(
                      icon: Icons.person,
                      backgroundSize: Dimensions.iconSize50 * 3,
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,
                      iconSize: Dimensions.iconSize20 * 4,
                    ),
                    SizedBox(
                      height: Dimensions.height30,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            // name
                            ProfileWidget(
                              icon: Icons.person,
                              backgroundColor: AppColors.mainColor,
                              text: userController.userModel!.name,
                              iconColor: Colors.white,
                            ),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                            // phone
                            ProfileWidget(
                              icon: Icons.phone,
                              backgroundColor: AppColors.yellowColor,
                              text: userController.userModel!.phone,
                              iconColor: Colors.white,
                            ),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                            // email
                            ProfileWidget(
                              icon: Icons.email,
                              backgroundColor: AppColors.yellowColor,
                              text: userController.userModel!.email,
                              iconColor: Colors.white,
                            ),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                            // address
                            GetBuilder<LocationController>(builder: (locationController){
                              if(Get.find<AuthController>().userLoggedIn()&&locationController.addressList.isEmpty){
                                return GestureDetector(
                                  onTap: (){
                                    Get.toNamed(RouteHelper.getAddAddressPage());
                                  },
                                  child: const ProfileWidget(
                                    icon: Icons.location_pin,
                                    backgroundColor: AppColors.yellowColor,
                                    text: 'Fill in your address',
                                    iconColor: Colors.white,
                                  ),
                                );
                              }else{
                                return GestureDetector(
                                  onTap: (){
                                    Get.toNamed(RouteHelper.getAddAddressPage());
                                  },
                                  child: const ProfileWidget(
                                    icon: Icons.location_pin,
                                    backgroundColor: AppColors.yellowColor,
                                    text: 'your address',
                                    iconColor: Colors.white,
                                  ),
                                );
                              }
                            },),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                            // message
                            const ProfileWidget(
                              icon: Icons.message,
                              backgroundColor: Colors.redAccent,
                              text: 'Messages',
                              iconColor: Colors.white,
                            ),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                            // Logout
                            GestureDetector(
                              onTap: () {
                                Get.find<AuthController>().clearUserSharedData();
                                Get.find<CartController>().clearCartHistory();
                                Get.find<CartController>().clear();
                                Get.find<LocationController>().clearAddressList();
                                Get.offNamed(RouteHelper.getLoginPage());
                              },
                              child: const ProfileWidget(
                                icon: Icons.logout,
                                backgroundColor: Colors.redAccent,
                                text: 'Logout',
                                iconColor: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                          ],
                        ),
                      ),
                    )

                  ],
                ),
              );
            }
          }else{
            return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BigText(text: 'You are not Logged in !!'),
                    Container(
                      height: Dimensions.height20*10,
                      margin: EdgeInsets.only(top: Dimensions.height20),
                      decoration: const BoxDecoration(
                        image: DecorationImage(image: AssetImage('assets/images/signintocontinue.png')),
                      ),
                    ),
                    SizedBox(height: Dimensions.height20,),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getLoginPage());
                      },
                      child: Container(
                        width: Dimensions.screenWidth / 2,
                        height: Dimensions.screenHeight / 12,
                        decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(Dimensions.radius30)),
                        child: Center(
                            child: BigText(
                              text: 'Login',
                              color: Colors.white,
                              size: 30,
                            )),
                      ),
                    ),

                  ],
                ),
              );
          }

        },
      ),
    );
  }
}
