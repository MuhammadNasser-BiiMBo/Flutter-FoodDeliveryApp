import 'package:food_delivery_app/data/repository/auth_repo.dart';
import 'package:food_delivery_app/models/login_model.dart';
import 'package:food_delivery_app/models/response_model.dart';
import 'package:food_delivery_app/models/sign_up_model.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:get/get.dart';

import '../base/show_custom_snackbar.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  // to make a circular progress indicator while requesting.
  bool _isLoading = false;
  bool get isLoading => _isLoading;


  // Register Validations
  void register({
    required String userName,
    required String phoneNumber,
    required String emailAddress,
    required String userPassword,
  }) {
    if (userName.isEmpty) {
      showCustomSnackBar('Type in your name', title: 'Name');
    } else if (phoneNumber.isEmpty) {
      showCustomSnackBar('Type in your Phone', title: 'Phone number');
    } else if (emailAddress.isEmpty) {
      showCustomSnackBar('Type in your Email', title: 'Email address');
    } else if (!emailAddress.isEmail) {
      showCustomSnackBar('Type in a valid email address',
          title: ' Email address');
    } else if (userPassword.isEmpty) {
      showCustomSnackBar('Type in your Password', title: 'Password');
    } else if (userPassword.length < 6) {
      showCustomSnackBar('Password can\'t be less than six characters',
          title: 'Password');
    } else {
      SignUpModel signUpModel =
          SignUpModel(userName, phoneNumber, emailAddress, userPassword);
      registration(signUpModel).then((response) {
        if (response.isSuccess) {
          Get.toNamed(RouteHelper.getInitial());
        } else {
          showCustomSnackBar(response.message);
        }
      });
    }
  }

  // calling registration from repo to request registration from api
  Future<ResponseModel> registration(SignUpModel signUpModel) async {
    _isLoading = true;
    update();
    Response response = await authRepo.registration(signUpModel);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body['token']);
      responseModel = ResponseModel(true, response.body['token']);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  // login validations
  void login({
    required String phoneNumber,
    required String userPassword,
  }) {
    if (phoneNumber.isEmpty) {
      showCustomSnackBar('Type in your Phone', title: 'Phone Number');
    } else if (!phoneNumber.isPhoneNumber) {
      showCustomSnackBar('Type in a valid Phone Number',
          title: 'Phone Number');
    } else if (userPassword.isEmpty) {
      showCustomSnackBar('Type in your Password', title: 'Password');
    } else if (userPassword.length < 6) {
      showCustomSnackBar('Password can\'t be less than six characters',
          title: 'Password');
    } else {
      LoginModel loginModel =
          LoginModel(phoneNumber: phoneNumber, password: userPassword);
      signIn(loginModel).then((response) {
        if (response.isSuccess) {
          Get.toNamed(RouteHelper.getInitial());
        } else {
          showCustomSnackBar(response.message);
        }
      });
    }
  }

  // calling signIn from repo to request Login from api.
  Future<ResponseModel> signIn (LoginModel loginModel)async{
    _isLoading = true;
    update();
    Response response = await authRepo.signIn(loginModel);
    late ResponseModel responseModel;
    if(response.statusCode==200){
      print('my token is ${response.body['token']}');
      authRepo.saveUserToken(response.body['token']);
      responseModel = ResponseModel(true, response.body['token']);
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  // calling the method from repo to save the pass and the phone number.
  void saveUserNumberAndPassword(String number,String password){
    authRepo.saveUserNumberAndPassword(number, password);
  }
  // calling the method from auth repo to check whether the user is logged in or not.
  bool userLoggedIn(){
    return authRepo.userLoggedIn();
  }
  // calling the method from auth repo to delete the user shared preferences data.
  bool clearUserSharedData(){
    return authRepo.clearUserSharedData();
  }
}
