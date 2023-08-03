import 'dart:convert';
import 'package:food_delivery_app/data/repository/location_repo.dart';
import 'package:food_delivery_app/models/response_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/address_model.dart';

class LocationController extends GetxController implements GetxService {
  LocationRepo locationRepo;

  LocationController({required this.locationRepo});

  bool _Loading = false;
  bool get loading => _Loading;
  //position vars
  late Position _position;
  Position get position => _position;
  // pick position vars
  late Position _pickPosition;
  Position get pickPosition => _pickPosition;
  //placemark vars
  Placemark _placemark = Placemark();
  Placemark get placemark => _placemark;
  //pick placemark vars
  Placemark _pickPlacemark = Placemark();
  Placemark get pickPlacemark => _pickPlacemark;
  // address list
  List<AddressModel> _addressList = [];
  List<AddressModel> get addressList => _addressList;
  // list of all addresses
  late List<AddressModel> _allAddressList;
  List<AddressModel> get allAddressList => _allAddressList;
  // address type list
  final List<String> _addressTypeList = ['home', 'office', 'others'];
  List<String> get addressTypeList => _addressTypeList;
  // the index of the address type
  int _addressTypeIndex = 0;
  int get addressTypeIndex => _addressTypeIndex;
  // map controller
  late GoogleMapController _mapController;
  GoogleMapController get mapController => _mapController;
  // map that contains the address
  late Map<String, dynamic> _getAddress;
  Map get getAddress => _getAddress;

  // for service zone
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  // whether user in service zone or not
  bool _inZone = true;
  bool get inZone => _inZone;
  // showing and hiding button as map loads
  bool _buttonDisabled = false;
  bool get buttonDisabled => _buttonDisabled;

  // to set the google map controller
  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  bool _updateAddressData = true;
  final bool _changeAddress = true;

  // <---------------------------- to update the location  on the map ------------>
  Future<void> updatePosition(CameraPosition position, bool fromAddress) async {
    if (_updateAddressData) {
      _Loading = true;
      update();
      try {
        if (fromAddress) {
          _position = Position(
            longitude: position.target.longitude,
            latitude: position.target.latitude,
            timestamp: DateTime.now(),
            accuracy: 1,
            altitude: 1,
            heading: 1,
            speed: 1,
            speedAccuracy: 1,
          );
        } else {
          _pickPosition = Position(
            longitude: position.target.longitude,
            latitude: position.target.latitude,
            timestamp: DateTime.now(),
            accuracy: 1,
            altitude: 1,
            heading: 1,
            speed: 1,
            speedAccuracy: 1,
          );
        }
        ResponseModel _responseModel = await getZone(position.target.latitude.toString(), position.target.longitude.toString(), false);
        // if the button disabled is true then we are not in service area
         _buttonDisabled = !_responseModel.isSuccess;
        if (_changeAddress) {
          String address = await getAddressFromGeocode(
              LatLng(position.target.latitude, position.target.longitude));
          fromAddress
              ? _placemark = Placemark(name: address)
              : _pickPlacemark = Placemark(name: address);
        }
      } catch (e) {
        print(e.toString());
      }

      _Loading = false;
      update();
    } else {
      _updateAddressData = true;
    }
  }

  // <--------------------- to get the address from the map ---------------------->
  Future<String> getAddressFromGeocode(LatLng latLng) async {
    String _address = 'unknown location found';

    Response response = await locationRepo.getAddressFromGeocode(latLng);
    if (response.body['status'] == 'OK') {
      _address = response.body['results'][0]['formatted_address'].toString();
      // print('Address is $_address');
    } else {
      print('There\'s an error getting google map api ');
    }
    return _address;
  }

  //<----------------- to get the address of the user from local storage---------->
  AddressModel getUserAddress() {
    late AddressModel _addressModel;
    _getAddress = jsonDecode(locationRepo.getUserAddress());
    try {
      _addressModel = AddressModel.fromJson(_getAddress);
    } catch (e) {
      print(e);
    }
    return _addressModel;
  }

  // <------------------to set the address type--------------------------->
  void setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }

  //<---------------------- to add address to the user--------------------->
  Future<ResponseModel> addAddress(AddressModel addressModel) async {
    _Loading = true;
    update();
    Response response = await locationRepo.addAddress(addressModel);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      await getAddressList();
      responseModel = ResponseModel(true, response.body['message']);
      await saveUserAddress(addressModel);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
      print("Couldn't save the address");
    }
    update();
    return responseModel;
  }

  //<---------------------- to get the addressList from the DB------------->
  Future<void> getAddressList() async {
    Response response = await locationRepo.getAddressList();
    if (response.statusCode == 200) {
      _addressList = [];
      _allAddressList = [];
      response.body.forEach((address) {
        _addressList.add(AddressModel.fromJson(address));
        _allAddressList.add(AddressModel.fromJson(address));
      });
    } else {
      _addressList = [];
      _allAddressList = [];
    }
    update();
  }

  // to save the address of the user
  Future<bool> saveUserAddress(AddressModel addressModel) async {
    String userAddress = jsonEncode(addressModel.toJson());
    return await locationRepo.saveUserAddress(userAddress);
  }

  // to clear address list and all address list when logout
  void clearAddressList() {
    _addressList = [];
    _allAddressList = [];
    update();
  }

  //getting user address from shared preferences
  String getUserAddressFromLocalStorage() {
    return locationRepo.getUserAddress();
  }

  // to set the address from the pick address screen to the add address page
  void setAddAddressData() {
    _position = _pickPosition;
    _placemark = _pickPlacemark;
    _updateAddressData = false;
    update();
  }

  Future<ResponseModel> getZone(String lat, String lng, bool markerLoad) async {
    late ResponseModel _responseModel;
    if (markerLoad) {
      _Loading = true;
    } else {
      _isLoading = true;
    }
    update();
    /// I commented this section as Egypt is not in the zone of delivery in the backend, so we can pick an address.
    // Response response = await locationRepo.getZone(lat, lng);
    // if(response.statusCode ==200){
    //   _inZone = true;
    //   _responseModel = ResponseModel(true, response.body['zone_id'].toString());
    // }else{
    //   // as Egypt not in the zone but if the picked location is in zone and the below line of code is not commented , the functionalities will work correctly.
    //   _inZone = false;
    //   _responseModel = ResponseModel(false, response.statusText!);
    // }
    // print(response.statusCode);
    await Future.delayed(const Duration(seconds: 2),(){
      _responseModel = ResponseModel(true, 'success');
      if (markerLoad) {
        _Loading = false;
      } else {
        _isLoading = false;
      }
      _inZone = true;
    });

    update();
    return _responseModel;
  }
}
