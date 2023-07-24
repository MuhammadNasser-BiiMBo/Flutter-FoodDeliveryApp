import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/constants/dimensions.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/profile_widget.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        title: BigText(text: 'Profile',color: Colors.white,size: 24,),
      ),
      body: Container(
        margin: EdgeInsets.only(top:Dimensions.height20),
        width: double.maxFinite,
        child: Column(
          children: [
            // profile Icon
            AppIcon(
              icon: Icons.person,
              backgroundSize: Dimensions.iconSize50*3,
              backgroundColor: AppColors.mainColor,
              iconColor: Colors.white,
              iconSize: Dimensions.iconSize20*4,
            ),
            SizedBox(height: Dimensions.height30,),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // name
                    const ProfileWidget(icon: Icons.person, backgroundColor: AppColors.mainColor, text: 'Ahmed',iconColor: Colors.white),
                    SizedBox(height: Dimensions.height20,),
                    // phone
                    const ProfileWidget(icon: Icons.phone, backgroundColor: AppColors.yellowColor, text: '01284371026',iconColor: Colors.white),
                    SizedBox(height: Dimensions.height20,),
                    // email
                    const ProfileWidget(icon: Icons.email, backgroundColor: AppColors.yellowColor, text: 'memonasser135@gmail.com',iconColor: Colors.white),
                    SizedBox(height: Dimensions.height20,),
                    // address
                    const ProfileWidget(icon: Icons.location_pin, backgroundColor: AppColors.yellowColor, text: 'Fill in your address',iconColor: Colors.white),
                    SizedBox(height: Dimensions.height20,),
                    // message
                    const ProfileWidget(icon: Icons.message, backgroundColor: Colors.redAccent, text: 'Ahmed',iconColor: Colors.white),
                    SizedBox(height: Dimensions.height20,),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
