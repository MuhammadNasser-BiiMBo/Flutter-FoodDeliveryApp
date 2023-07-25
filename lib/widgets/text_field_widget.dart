import 'package:flutter/material.dart';
import '../constants/dimensions.dart';

class AppTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Color iconColor;
  final TextEditingController controller;

  bool obscure;
  AppTextField({super.key, required this.hint, required this.icon, required this.controller, required this.iconColor, this.obscure=false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
      margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius20),
          boxShadow: [
            BoxShadow(
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(1, 5),
                color: Colors.grey.withOpacity(0.2)
            )
          ]
      ),
      child: TextField(
        obscureText: obscure,
        controller: controller,
        decoration:  InputDecoration(
            // hint
            hintText: hint,
            // prefix icon
            prefixIcon:  Icon(icon,color: iconColor,),
            // focused border
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                borderSide: const BorderSide(
                  width: 1,
                  color: Colors.white,
                )
            ),
            // enabled border
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(
                  width: 1,
                  color: Colors.white,
                )
            ),
            // border
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            )
        ),
      ),
    );
  }
}
