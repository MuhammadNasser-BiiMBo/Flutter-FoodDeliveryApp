class LoginModel {
  String phoneNumber;
  String password;
  LoginModel({required this.phoneNumber,required this.password});

  Map<String, dynamic> toJson(){
    return{
      'phone':phoneNumber,
      'password':password,
    };
  }
}