import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService{
  final ApiClient apiClient;

  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList()async{
    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URL);
  }
}