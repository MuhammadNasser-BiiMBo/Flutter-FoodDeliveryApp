import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/Food/popular_food_details.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home:  const PopularFoodDetails(),
    );
  }
}
