import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/constants/dimensions.dart';
import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/controllers/location_controller.dart';
import 'package:food_delivery_app/controllers/user_controller.dart';
import 'package:food_delivery_app/models/address_model.dart';
import 'package:food_delivery_app/pages/address/pick_address_page.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/text_field_widget.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  // <-----------------------Controllers--------------------------->
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonNameController =
      TextEditingController();
  final TextEditingController _contactPersonNumberController =
      TextEditingController();
  // <---------------------------------------------------------------->

  //<------------->to know whether the user is logged in or not------------------>
  late bool _isLogged;

  // <-------------------------the default Camera position------------------------>
  CameraPosition _cameraPosition = const CameraPosition(
    target: LatLng(30.0444, 31.2357),
    zoom: 17,
  );

  //<------------------- the initial position when we open the map------------>
  LatLng _initialPosition = const LatLng(30.0444, 31.2357);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //<----------------- to know whether the user logged in or not---------------->
    _isLogged = Get.find<AuthController>().userLoggedIn();

    //<-------------- if the user is logged in we should get the user info---------->
    if (_isLogged && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    //<----------------------------------------------------------------------------->

    //<---------- to set the address to current address if it's not empty----------->
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      if (Get.find<LocationController>().getUserAddressFromLocalStorage() ==
          '') {
        Get.find<LocationController>()
            .saveUserAddress(Get.find<LocationController>().addressList.last);
      }
      // AddressModel addressModel = Get.find<LocationController>().getUserAddress()!;
      // to set the Camera position the current location
      _cameraPosition = CameraPosition(
        target: LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitude"]),
        ),
      );
      // to set the initial position after as the current location
      _initialPosition = LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"]),
      );
    }
    //  <--------------------------------------------------------------------------->
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Address Page'),
        backgroundColor: AppColors.mainColor,
        automaticallyImplyLeading: false,
      ),
      body: GetBuilder<UserController>(
        builder: (userController) {
          if (userController.userModel != null &&
              _contactPersonNameController.text.isEmpty) {
            _contactPersonNameController.text = userController.userModel!.name;
            _contactPersonNumberController.text =
                userController.userModel!.phone;
            if (Get.find<LocationController>().addressList.isNotEmpty) {
              _addressController.text =
                  Get.find<LocationController>().getUserAddress().address;
            }
          }
          return GetBuilder<LocationController>(
            builder: (locationController) {
              _addressController.text =
                  "${locationController.placemark.name ?? ''}"
                  "${locationController.placemark.locality ?? ''}"
                  "${locationController.placemark.postalCode ?? ''}"
                  "${locationController.placemark.country ?? ''}";
              // print(object);
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: Dimensions.height20 * 10,
                      width: double.maxFinite,
                      margin: EdgeInsets.symmetric(
                        horizontal: Dimensions.width10 / 2,
                        vertical: Dimensions.height10 / 2,
                      ),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius10 / 2),
                          border: Border.all(
                            width: 2,
                            color: AppColors.mainColor,
                          )),
                      child: Stack(
                        children: [
                          GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: locationController.getUserAddressFromLocalStorage()==''?_initialPosition:LatLng(
                                  double.parse(locationController.getUserAddress().latitude) ,
                                  double.parse(locationController.getUserAddress().longitude)
                              ),
                              zoom: 17,
                            ),
                            zoomControlsEnabled: false,
                            compassEnabled: false,
                            indoorViewEnabled: true,
                            mapToolbarEnabled: false,
                            myLocationEnabled: true,
                            onCameraIdle: () {
                              locationController.updatePosition(
                                  _cameraPosition, true);
                            },
                            onCameraMove: ((position) =>
                                _cameraPosition = position),
                            onMapCreated: (GoogleMapController controller) {
                              locationController.setMapController(controller);
                            },
                            onTap: (latLng) {
                              Get.toNamed(
                                RouteHelper.getPickAddressPage(),
                                arguments: PickAddressMap(
                                  fromAddress: true,
                                  fromSignup: false,
                                  googleMapController:
                                      locationController.mapController,
                                ),
                              );
                            },
                          ),
                           Center(child:Image.asset('assets/images/pick_marker.png',width: Dimensions.width30,height: Dimensions.height30,) ,)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    SizedBox(
                      height: Dimensions.height10 * 5,
                      child: ListView.builder(
                        itemCount: locationController.addressTypeList.length,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width20),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              locationController.setAddressTypeIndex(index);
                            },
                            child: Container(
                              margin:
                                  EdgeInsets.only(right: Dimensions.width10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.radius10 / 2),
                                color: Theme.of(context).cardColor,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[200]!,
                                      spreadRadius: 1,
                                      blurRadius: 5)
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.width20,
                                    vertical: Dimensions.height10),
                                child: Icon(
                                  index == 0
                                      ? Icons.home
                                      : index == 1
                                          ? Icons.work
                                          : Icons.location_on,
                                  color: locationController.addressTypeIndex ==
                                          index
                                      ? AppColors.mainColor
                                      : Theme.of(context).disabledColor,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Dimensions.width20),
                      child: BigText(text: 'Delivery Address'),
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    AppTextField(
                        hint: 'Your address',
                        icon: Icons.location_pin,
                        controller: _addressController,
                        iconColor: AppColors.yellowColor),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Dimensions.width20),
                      child: BigText(text: 'Contact Name'),
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    AppTextField(
                        hint: 'Your name',
                        icon: Icons.person,
                        controller: _contactPersonNameController,
                        iconColor: AppColors.yellowColor),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Dimensions.width20),
                      child: BigText(text: 'Contact Number'),
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    AppTextField(
                        hint: 'Your phone',
                        icon: Icons.phone_android,
                        controller: _contactPersonNumberController,
                        iconColor: AppColors.yellowColor),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: GetBuilder<LocationController>(
        builder: (locationController) {
          return Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.symmetric(
                vertical: Dimensions.height10, horizontal: Dimensions.width20),
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20 * 2),
                  topRight: Radius.circular(Dimensions.radius20 * 2),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    AddressModel addressModel = AddressModel(
                      addressType: locationController.addressTypeList[locationController.addressTypeIndex],
                      address: _addressController.text,
                      latitude: locationController.position.latitude.toString(),
                      longitude: locationController.position.longitude.toString(),
                      contactPersonName: _contactPersonNameController.text,
                      contactPersonNumber: _contactPersonNumberController.text,
                    );
                    locationController
                        .addAddress(addressModel)
                        .then((response) {
                      if (response.isSuccess) {
                        Get.toNamed(RouteHelper.getInitial());
                        Get.snackbar('Address', 'Added Successfully');
                      } else {
                        Get.snackbar('Address', "Couldn't save address");
                      }
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.width20,
                        vertical: Dimensions.height20),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                    ),
                    child: BigText(
                      text: 'Save Address',
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
