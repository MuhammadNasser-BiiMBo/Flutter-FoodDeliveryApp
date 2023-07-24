class SignUpModel{
   String? name;
   String? phone;
   String? email;
   String? password;

  SignUpModel(this.name, this.phone, this.email, this.password);

  SignUpModel.fromJson(Map<String,dynamic> json){
    name = json['f_name'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
  }
  Map <String,dynamic> toJson(){
    return{
      'f_name':name,
      'phone':phone,
      'email':email,
      'password':password,
    };
}
}