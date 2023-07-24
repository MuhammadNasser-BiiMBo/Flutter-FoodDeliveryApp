import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/constants/dimensions.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String imgPath;
  const NoDataPage({super.key, required this.text, required this.imgPath});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          imgPath,
          height: MediaQuery.sizeOf(context).height*0.3,
        ),
        SizedBox(height: Dimensions.height20,),
        Center(
          child: Text(
              text,
              style: TextStyle(
                fontSize: Dimensions.fontSize15,
                color: AppColors.paraColor
              ),
          ),
        )
      ],
    );
  }
}
