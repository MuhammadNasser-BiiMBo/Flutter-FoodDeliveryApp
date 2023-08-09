import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class UserRepo{
  final ApiClient apiClient;

  UserRepo({required this.apiClient});

  Future<Response>getUserInfo()async{
    return await apiClient.getData(AppConstants.USER_INFO_URL);
  }
}