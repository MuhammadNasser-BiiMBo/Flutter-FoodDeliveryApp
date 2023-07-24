import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:get/get.dart';

import '../widgets/big_text.dart';

void showCustomSnackBar(String message,
    {bool isError = true, String title = 'Error'}) {
  Get.snackbar(
    title,
    message,
    titleText: BigText(
      text: title,
      color: Colors.white,
    ),
    messageText: Text(
      message,
      style: const TextStyle(color: Colors.white),
    ),
    snackPosition: SnackPosition.TOP,
    backgroundColor: isError?Colors.redAccent:AppColors.mainColor,
  );
}
