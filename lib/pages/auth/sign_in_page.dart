import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/controllers/location_controller.dart';
import 'package:food_delivery_app/pages/auth/sign_up_page.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:food_delivery_app/widgets/text_field_widget.dart';
import 'package:get/get.dart';

import '../../constants/dimensions.dart';
import '../../controllers/user_controller.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: Dimensions.screenHeight * 0.20,
                margin: EdgeInsets.only(top: Dimensions.height45),
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: Dimensions.radius20 * 5,
                    backgroundImage:
                        const AssetImage('assets/images/logo part 1.png'),
                  ),
                ),
              ),
              // Welcome Text
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(
                    left: Dimensions.width20,
                    bottom: Dimensions.height45,
                    top: Dimensions.height20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hello',
                      style: TextStyle(
                        letterSpacing: 2.5,
                        fontWeight: FontWeight.bold,
                        fontSize: 75,
                      ),
                    ),
                    SmallText(
                      text: 'Sign into your account',
                      size: 18,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
              // phone
              AppTextField(
                hint: 'Phone number',
                icon: Icons.phone_android,
                controller: phoneController,
                iconColor: AppColors.mainColor,
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              // password
              AppTextField(
                obscure: true,
                hint: 'Password',
                icon: Icons.password,
                controller: passwordController,
                iconColor: AppColors.mainColor,
              ),
              SizedBox(height: Dimensions.height45,),
              // Sign up button
              !authController.isLoading?GestureDetector(
                onTap: () {
                  authController.login(
                    phoneNumber: phoneController.text,
                    userPassword: passwordController.text,
                  );
                  Get.find<UserController>().getUserInfo().then((value) => Get.find<LocationController>().getUserAddress());
                  print('log');
                },
                child: Container(
                  width: Dimensions.screenWidth / 2,
                  height: Dimensions.screenHeight / 12,
                  decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius30)),
                  child: Center(
                      child: BigText(
                    text: 'Sign in',
                    color: Colors.white,
                    size: 30,
                  )),
                ),
              ):
              const Center(
                child: CircularProgressIndicator(
                  color: AppColors.mainColor,
                ),
              ),
              SizedBox(height: Dimensions.height45,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SmallText(
                    text: 'You don\'t have an account ? ',
                    size: 18,
                    color: Colors.grey,
                  ),
                  GestureDetector(
                    child: SmallText(
                      text: 'Register',
                      size: 20,
                      color: AppColors.mainColor,
                    ),
                    onTap: () {
                      Get.to(SignUpPage(), transition: Transition.fade);
                    },
                  ),
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
