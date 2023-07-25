import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:food_delivery_app/models/login_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/sign_up_model.dart';

class AuthRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient,required this.sharedPreferences});

  // sign up post request.
  Future<Response> registration(SignUpModel signUpModel)async{
    return await apiClient.postData(AppConstants.REGISTRATION_URL, signUpModel.toJson());
  }
  // sign in post request.
  Future<Response> signIn(LoginModel loginModel)async{
    return await apiClient.postData(AppConstants.LOGIN_URL, loginModel.toJson());
  }
  // to save the user token.
  Future<bool>saveUserToken(String token)async{
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }
  // to save the number and the pass of the user.
  Future<void> saveUserNumberAndPassword(String number,String password)async {
    try{
      await sharedPreferences.setString(AppConstants.PHONE, number);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    }catch(e){
      rethrow;
    }
  }
  // to get the user token.
  String getUserToken(){
    return sharedPreferences.getString(AppConstants.TOKEN)??'none';
  }
  //
  bool userLoggedIn(){
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

}