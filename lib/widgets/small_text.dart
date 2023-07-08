
import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/dimensions.dart';

class SmallText extends StatelessWidget {
  final String text;
  Color? color;
  double height;
  double size;
  TextOverflow overFlow ;
  SmallText({
    super.key,this.size = 0,
    required this.text,
    this.height = 1.2,
    this.color = const Color(0xFFccc7c5),
    this.overFlow=TextOverflow.ellipsis,
  });

  @override
  Widget build(BuildContext context) {
    return  Text(
      text,
      style: TextStyle(
          color: color,
          overflow: overFlow,
          fontSize: size==0?Dimensions.fontSize14:Dimensions.fontSize14*size/14,
          height: height,
          fontFamily: 'Roboto'
      ),
    );
  }
}
