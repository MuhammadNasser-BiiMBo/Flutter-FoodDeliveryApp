import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:food_delivery_app/models/address_model.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  LocationRepo({required this.apiClient,required this.sharedPreferences});

  Future<Response> getAddressFromGeocode(LatLng latLng)async {
    return await apiClient.getData('${AppConstants.GEOCODE_URL}''?lat=${latLng.latitude}&lng=${latLng.longitude}');
  }

  Future<bool> setFirstLoginUserAddress(){
    return sharedPreferences.setString(AppConstants.USER_ADDRESS, '');
  }
  String getUserAddress(){
    return sharedPreferences.getString(AppConstants.USER_ADDRESS)??'';
  }

  Future<Response> addAddress(AddressModel addressModel)async{
    return await apiClient.postData(AppConstants.ADD_USER_ADDRESS_URL,addressModel.toJson());
  }

  Future<Response> getAddressList()async{
    return await apiClient.getData(AppConstants.ADDRESS_LIST_URL);
  }

  Future<bool> saveUserAddress(String userAddress) async {
    apiClient.updateHeader(sharedPreferences.getString(AppConstants.TOKEN)!);
    return await sharedPreferences.setString(AppConstants.USER_ADDRESS, userAddress);
  }
  
  Future<Response> getZone(String lat , String lng)async{
    return await apiClient.getData('${AppConstants.ZONE_URL}?lat=$lat&lng=$lng');
    
  }

  Future<Response> searchLocation(String text)async{
    return await apiClient.getData('${AppConstants.SEARCH_LOCATION_URL}?search_text=$text');
  }
  
  Future<Response> setLocation(String placeId) async {
    return await apiClient.getData("${AppConstants.PLACE_DETAILS_URL}?placeid=$placeId");
  }
  
}