class AddressModel{
  // attributes
  late int? _id;
  late String _addressType ;
  late String? _contactPersonName ;
  late String? _contactPersonNumber ;
  late String _address ;
  late String _latitude ;
  late String _longitude ;

  // constructor
  AddressModel({
    id,
    required addressType,
    contactPersonNumber,
    contactPersonName,
    required address,
    required latitude,
    required longitude,
}){
    _id =id;
    _addressType =addressType;
    _contactPersonName =contactPersonName;
    _contactPersonNumber =contactPersonNumber;
    _address =address;
    _latitude =latitude;
    _longitude =longitude;
  }

  // getters
  int? get id => _id;
  String get addressType => _addressType;
  String? get contactPersonName => _contactPersonName;
  String? get contactPersonNumber => _contactPersonNumber;
  String get address => _address;
  String get latitude => _latitude;
  String get longitude => _longitude;

  // fromJson
  AddressModel.fromJson(Map<String,dynamic> json){
    _id = json['id'];
    _addressType = json['address_type']??'';
    _contactPersonName = json['contact_person_name']??'';
    _contactPersonNumber = json['contact_person_number']??'';
    _address = json['address']??'';
    _latitude = json['latitude']??'';
    _longitude = json['longitude']??'';
  }
  Map<String,dynamic> toJson(){
    return{
      'id':_id,
      'address_type':_addressType,
      'contact_person_name':_contactPersonName,
      'contact_person_number':_contactPersonNumber,
      'address':_address,
      'latitude':_latitude,
      'longitude':_longitude,
    };
  }
}