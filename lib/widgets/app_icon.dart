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
      clipBehavior: Clip.antiAliasWithSaveLayer,
      width: backgroundSize==0?Dimensions.iconSize50:Dimensions.iconSize50*backgroundSize/50,
      height: backgroundSize==0?Dimensions.iconSize50:Dimensions.iconSize50*backgroundSize/50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(backgroundSize==0?Dimensions.iconSize50/2:Dimensions.iconSize50*backgroundSize/100),
        color: backgroundColor,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(backgroundSize==0?Dimensions.iconSize50/2:Dimensions.iconSize50*backgroundSize/100),
        onTap: (){},
        child: Center(
          child: Icon(
            icon,
            color: iconColor,
            size: iconSize==0?Dimensions.iconSize20:Dimensions.iconSize20*iconSize/20,
          ),
        ),
      ),
    );
  }
}
