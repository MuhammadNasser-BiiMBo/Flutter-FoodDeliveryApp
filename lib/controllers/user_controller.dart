import 'package:food_delivery_app/data/repository/user_repo.dart';
import 'package:food_delivery_app/models/user_model.dart';
import 'package:get/get.dart';

import '../models/response_model.dart';

class UserController extends GetxController implements GetxService{
  final UserRepo userRepo;

  UserController({required this.userRepo});
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  UserModel? _userModel;
  UserModel? get userModel =>_userModel;


  Future<ResponseModel> getUserInfo()async{


    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    if(response.statusCode==200){
      _userModel = UserModel.fromJson(response.body);
      responseModel = ResponseModel(true, 'success');
      _isLoading = false;
      update();
    }else{
      print('no data');
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }
}