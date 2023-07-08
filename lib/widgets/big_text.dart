
import 'package:flutter/material.dart';

import '../constants/dimensions.dart';

class BigText extends StatelessWidget {
  final String text;
  Color? color;
  double size;
  TextOverflow overflow;
  BigText({
    super.key,this.size = 0,
    required this.text,
    this.color = const Color(0xFF332d2b),
    this.overflow=TextOverflow.ellipsis,
  });

  @override
  Widget build(BuildContext context) {
    return  Text(
      text,
      overflow: overflow,
      maxLines: 1,
      style: TextStyle(
        color: color,
        fontSize: size == 0 ? Dimensions.fontSize20:Dimensions.fontSize20*size/20,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto'
      ),
    );
  }
}
