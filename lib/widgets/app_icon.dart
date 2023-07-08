import 'package:flutter/material.dart';

import '../constants/dimensions.dart';

class AppIcon extends StatelessWidget {
  final IconData icon ;
  final Color backgroundColor;
  final Color iconColor;
  final double backgroundSize;
  final double iconSize;
  const AppIcon({super.key,
    required this.icon,
    this.backgroundSize=0,
    this.backgroundColor = const Color(0xFFfcf4e4),
    this.iconColor = const Color(0xFF756d54),
    this.iconSize = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: backgroundSize==0?Dimensions.iconSize50:backgroundSize,
      height: backgroundSize==0?Dimensions.iconSize50:backgroundSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(backgroundSize==0?Dimensions.iconSize50:backgroundSize/2),
        color: backgroundColor,
      ),
      child: Center(
        child: Icon(
          icon,
          color: iconColor,
          size: iconSize==0?Dimensions.iconSize20:iconSize,
        ),
      ),
    );
  }
}
