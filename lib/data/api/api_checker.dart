import 'package:food_delivery_app/base/show_custom_snackbar.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:get/get.dart';

class ApiChecker{
  static void checkApi(Response response){
    if(response.statusCode==401){
      Get.offNamed(RouteHelper.getLoginPage());
    }else{
      showCustomSnackBar(response.statusText!);
    }
  }
}