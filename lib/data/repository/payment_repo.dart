import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/controllers/payment_controller.dart';
import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:food_delivery_app/data/api/payment_client.dart';
import 'package:get/get.dart';

class PaymentRepo {
  final PaymentClient paymentClient;

  PaymentRepo({required this.paymentClient});

  Future<Response> getAuthToken() async {
    return await paymentClient.postData(AppConstants.GET_PAYMENT_AUTH_TOKEN,
        {"api_key": AppConstants.PAYMENT_API_KEY});
  }
  Future<Response> getOrderRegistrationId(Map<String,dynamic> data) async {
    return await paymentClient.postData(AppConstants.GET_ORDER_ID,
        data);
  }
  Future<Response> getPaymentRequest(Map<String,dynamic> data) async {
    return await paymentClient.postData(AppConstants.GET_PAYMENT_ID,
        data);
  }
  Future<Response> getRefCode(Map<String,dynamic> data) async {
    return await paymentClient.postData(AppConstants.GET_REF_CODE,
        data);
  }
}
