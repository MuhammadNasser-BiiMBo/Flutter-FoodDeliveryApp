import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/show_custom_snackbar.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/models/sign_up_model.dart';
import 'package:food_delivery_app/pages/auth/sign_in_page.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:food_delivery_app/widgets/text_field_widget.dart';
import 'package:get/get.dart';

import '../../constants/dimensions.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  //controllers
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var userNameController = TextEditingController();
  var phoneController = TextEditingController();
  // Platforms' images list
  List signUpImages = [
    't.png',
    'f.png',
    'g.png',
  ];
  // registration method
  void _registration(AuthController authController) {
    String name = userNameController.text;
    String phone = phoneController.text;
    String email = emailController.text;
    String password = passwordController.text;

    if (name.isEmpty) {
      showCustomSnackBar('Type in your name', title: 'Name');
    } else if (phone.isEmpty) {
      showCustomSnackBar('Type in your Phone', title: 'Phone number');
    } else if (email.isEmpty) {
      showCustomSnackBar('Type in your Email', title: 'Email address');
    } else if (!email.isEmail) {
      showCustomSnackBar('Type in a valid email address',
          title: ' Email address');
    } else if (password.isEmpty) {
      showCustomSnackBar('Type in your Password', title: 'Password');
    } else if (password.length < 6) {
      showCustomSnackBar('Password can\'t be less than six characters',
          title: 'Password');
    } else {
      SignUpModel signUpModel = SignUpModel(name, phone, email, password);
      authController.registration(signUpModel).then((value) {
        if (value.isSuccess) {
          print('Success Registration');
        } else {
          showCustomSnackBar(value.message);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // App Logo
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
              SizedBox(
                height: Dimensions.height30,
              ),
              // username
              AppTextField(
                  hint: 'User Name',
                  icon: Icons.person,
                  controller: userNameController,
                  iconColor: AppColors.mainColor),
              SizedBox(
                height: Dimensions.height20,
              ),
              // Email
              AppTextField(
                  hint: 'Email',
                  icon: Icons.email,
                  controller: emailController,
                  iconColor: AppColors.mainColor),
              SizedBox(
                height: Dimensions.height20,
              ),
              // password
              AppTextField(
                  hint: 'Password',
                  icon: Icons.password,
                  controller: passwordController,
                  iconColor: AppColors.mainColor),
              SizedBox(
                height: Dimensions.height20,
              ),
              // phone
              AppTextField(
                  hint: 'Phone',
                  icon: Icons.phone,
                  controller: phoneController,
                  iconColor: AppColors.mainColor),
              SizedBox(
                height: Dimensions.height30,
              ),
              // Sign up button
              !authController.isLoading?GestureDetector(
                onTap: () {
                  _registration(authController);
                },
                child: Container(
                  width: Dimensions.screenWidth / 2,
                  height: Dimensions.screenHeight / 12,
                  decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius30)),
                  child: Center(
                      child: BigText(
                    text: 'Sign up',
                    color: Colors.white,
                    size: 30,
                  )),
                ),
              ):
              const Center(child: CircularProgressIndicator(color: AppColors.mainColor,),),
              SizedBox(
                height: Dimensions.height10,
              ),
              // Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SmallText(
                    text: 'Already have an account ? ',
                    color: Colors.grey[500]!,
                    size: 18,
                  ),
                  GestureDetector(
                    child: SmallText(
                      text: 'Login',
                      color: AppColors.mainColor,
                      size: 20,
                    ),
                    onTap: () {
                      Get.to(SignInPage(), transition: Transition.fade);
                    },
                  )
                ],
              ),
              SizedBox(
                height: Dimensions.height30,
              ),
              // sign up with options
              SmallText(
                text: 'Sign up using one of the following methods',
                color: Colors.grey[500]!,
                size: 16,
              ),
              Wrap(
                direction: Axis.horizontal,
                // spacing: Dimensions.width20,
                children: List.generate(
                    3,
                    (index) => Padding(
                          padding: EdgeInsets.all(Dimensions.height10),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: Dimensions.radius30,
                            backgroundImage: AssetImage(
                                'assets/images/${signUpImages[index]}'),
                          ),
                        )),
              ),
            ],
          ),
        );
      }),
    );
  }
}
