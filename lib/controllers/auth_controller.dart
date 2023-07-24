import 'package:food_delivery_app/data/repository/auth_repo.dart';
import 'package:food_delivery_app/models/sign_up_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService{
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading =>_isLoading;

  Future<void> registration(SignUpModel signUpModel)async{
    _isLoading = true;
    Response response = await authRepo.registration(signUpModel);
    if(response.statusCode==200){
      authRepo.saveUserToken(response.body.token);
    }else{

    }
  }
}