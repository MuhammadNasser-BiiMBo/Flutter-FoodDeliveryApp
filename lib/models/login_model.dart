class LoginModel {
  String emailAddress;
  String password;
  LoginModel({required this.emailAddress,required this.password});

  Map<String, dynamic> toJson(){
    return{
      'email':emailAddress,
      'password':password,
    };
  }
}