import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/data/repository/payment_repo.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController implements GetxService{
  final PaymentRepo paymentRepo;
  bool _isSuccess = false ;
  bool get isSuccess =>_isSuccess;
  PaymentController({required this.paymentRepo});


  // to get the authentication token
  Future <void> getAuthToken()async{
    Response response = await paymentRepo.getAuthToken();
    if(response.statusCode==201){
      AppConstants.paymentFirstToken = response.body['token'];
    }else{
      print('status code is not 201 for auth token');
    }
  }
  // to get the order id
  Future<void> getOrderRegistrationId({
    required String name,
    required String price,
    required String email,
    required String phone,
    required Placemark placemark,
    // required List<CartModel> items
  })async{
    AppConstants.paymentOrderId = '';
    Map<String,dynamic> data = {
      "auth_token" : AppConstants.paymentFirstToken,
      "delivery_needed" : "false",
      "amount_cents" : price,
      "currency": "EGP",
      "items" : [],
    };
    Response response = await paymentRepo.getOrderRegistrationId(data);
    if(response.statusCode ==201){
      AppConstants.paymentOrderId = response.body["id"].toString();
      getPaymentRequest(name: name, price: price, email: email, phone: phone,placemark: placemark);
    }else{
      print('status code is not 201 order id');
    }
  }

  // to get the final token for the payment
  Future<void> getPaymentRequest({
    required String name,
    required String price,
    required String email,
    required String phone,
    required Placemark placemark,
    // required List<CartModel> items
  })async{
    AppConstants.finalToken = '';
    Map<String,dynamic> data = {
      "auth_token": AppConstants.paymentFirstToken,
      "amount_cents": price,
      "expiration": 3600,
      "order_id": AppConstants.paymentOrderId,
      "billing_data": {
        "apartment": "NA",
        "email": email,
        "floor": "NA",
        "first_name": name,
        "street": "NA",
        "building": "NA",
        "phone_number": phone,
        "shipping_method": "NA",
        "postal_code": "NA",
        "city": "NA",
        "country": "NA",
        "last_name": "NA",
        "state": "NA"
      },
      "currency": "EGP",
      "integration_id": AppConstants.cardIntegrationId,
      "lock_order_when_paid": "false"
    }
    ;
    Response response = await paymentRepo.getPaymentRequest(data);
    if(response.statusCode ==201){
      AppConstants.finalToken = response.body["token"];
    }else{
      print('status code is not 201 payment request');
    }
  }
  // for getting ref code for kiosk payment
  Future<void> getRefCode()async{
    AppConstants.refCode = '';
    Response response = await paymentRepo.getRefCode({
      "source": {
        "identifier": "AGGREGATOR",
        "subtype": "AGGREGATOR"
      },
      "payment_token": AppConstants.finalToken
    }
    );
    if(response.statusCode ==200){
      AppConstants.refCode = response.body['id'].toString();
      _isSuccess = true;
    }else{
      print('status code is not 200 refCode');
    }
  }

}