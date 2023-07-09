import 'package:flutter/material.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';

class FoodDataColumn extends StatelessWidget {
  final String text;
  double? size;
  FoodDataColumn({super.key, required this.text,this.size});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text,size: size==null?0:size!),
        SizedBox(
          height: Dimensions.height10,
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(
                  5,
                      (index) => Icon(
                    Icons.star,
                    color: AppColors.mainColor,
                    size: Dimensions.height15,
                  )),
            ),
            const SizedBox(
              width: 5,
            ),
            SmallText(text: '4.5'),
            const SizedBox(
              width: 20,
            ),
            SmallText(text: '1059 comments'),
          ],
        ),
        SizedBox(
          height: Dimensions.height15,
        ),
        const Row(
          children: [
            Expanded(
              child: IconAndText(
                  icon: Icons.circle,
                  text: 'Normal',
                  iconColor: AppColors.iconColor1),
            ),
            Expanded(
              child: IconAndText(
                  icon: Icons.location_pin,
                  text: '1.7km',
                  iconColor: AppColors.mainColor),
            ),
            Expanded(
              child: IconAndText(
                  icon: Icons.access_time_outlined,
                  text: '32min',
                  iconColor: AppColors.iconColor2),
            ),
          ],
        ),
      ],
    );
  }
}
