import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/dimensions.dart';

class SmallText extends StatelessWidget {
  final String text;
  Color color;
  double height;
  double size;
  bool isExpandable;
  SmallText({
    super.key,
    this.size = 0,
    required this.text,
    this.height = 1.2,
    this.color = const Color(0xFFccc7c5),
    this.isExpandable = true
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size == 0
            ? Dimensions.fontSize14
            : Dimensions.fontSize14 * size / 14,
        height: height,
        fontFamily: 'Roboto',
        overflow: isExpandable?null:TextOverflow.ellipsis,
      ),
    );
  }
}
