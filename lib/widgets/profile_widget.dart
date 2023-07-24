import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/dimensions.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';

import 'big_text.dart';

class ProfileWidget extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final String text;
  const ProfileWidget({super.key, required this.icon, required this.backgroundColor, required this.text, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.width20,
        vertical: Dimensions.height10
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            color: Colors.grey.withOpacity(0.2),
              blurRadius:2
          )
        ]
      ),
      child: Row(
        children: [
          AppIcon(icon: icon,backgroundColor: backgroundColor,iconColor: iconColor,),
          SizedBox(width: Dimensions.width20,),
          BigText(text: text)

        ],
      ),
    );
  }
}
