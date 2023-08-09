import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/constants/dimensions.dart';
import 'package:food_delivery_app/controllers/location_controller.dart';
import 'package:food_delivery_app/pages/address/search_location_dialogue_page.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../models/address_model.dart';
import '../../widgets/small_text.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromAddress;
  final bool fromSignup;
  final GoogleMapController? googleMapController;
  const PickAddressMap(
      {super.key,
      required this.fromAddress,
      required this.fromSignup,
      this.googleMapController});

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Get.find<LocationController>().addressList.isEmpty) {
      _initialPosition = const LatLng(30.0444, 31.2357);
      _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
    } else {
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        _initialPosition = LatLng(
          double.parse(Get.find<LocationController>().getAddress['latitude']),
          double.parse(Get.find<LocationController>().getAddress['longitude']),
        );
        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      builder: (locationController) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: SizedBox(
                width: double.maxFinite,
                child: Stack(
                  children: [
                    GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: _initialPosition,
                        zoom: 17,
                      ),
                      zoomControlsEnabled: false,
                      onCameraMove: (CameraPosition cameraPosition) {
                        _cameraPosition = cameraPosition;
                      },
                      onCameraIdle: () {
                        Get.find<LocationController>()
                            .updatePosition(_cameraPosition, false);
                      },
                      onMapCreated: (GoogleMapController mapController){
                        _mapController = mapController;
                      },
                    ),
                    Center(
                      child: !locationController.loading
                          ? Container(
                              height: 50,
                              width: 50,
                              margin:
                                  EdgeInsets.only(bottom: Dimensions.height30),
                              child:
                                  Image.asset('assets/images/pick_marker.png'))
                          : const CircularProgressIndicator(),
                    ),
                    Positioned(
                      top: Dimensions.height45,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      child: InkWell(
                        onTap: (){
                          Get.dialog(LocationSearchDialogue(mapController: _mapController));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.width10),
                          height: Dimensions.height45,
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius10),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 25,
                                color: AppColors.yellowColor,
                              ),
                              Expanded(
                                child: Text(
                                  locationController.pickPlacemark.name ?? '',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: Dimensions.fontSize16),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: Dimensions.width10,),
                              const Icon(Icons.search,color: AppColors.yellowColor,),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 50,
                      left: Dimensions.width45,
                      right: Dimensions.width45,
                      child: locationController.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : CustomButton(
                              buttonText: locationController.inZone ? widget.fromAddress ? 'Pick Address' : 'Pick Location' : 'Service is not available in your area',
                              onPressed: (locationController.buttonDisabled || locationController.loading) ? null : () {
                                      if (locationController.pickPosition.latitude != 0 && locationController.pickPlacemark.name != null) {
                                        if (widget.fromAddress) {
                                          if (widget.googleMapController != null) {
                                            print('object');
                                            widget.googleMapController!.moveCamera(
                                              CameraUpdate.newCameraPosition(
                                                CameraPosition(
                                                  target: LatLng(
                                                    locationController
                                                        .pickPosition.latitude,
                                                    locationController
                                                        .pickPosition.longitude,
                                                  ),
                                                ),
                                              ),
                                            );
                                            AddressModel addressModel = AddressModel(
                                              addressType: locationController.addressTypeList[locationController.addressTypeIndex],
                                              address: locationController.pickPlacemark.name,
                                              latitude: locationController.pickPosition.latitude.toString(),
                                              longitude: locationController.pickPosition.longitude.toString(),
                                              contactPersonName: locationController.getUserAddress()!.contactPersonName,
                                              contactPersonNumber: locationController.getUserAddress()!.contactPersonName,
                                            );
                                            print(locationController.pickPlacemark.name);
                                            locationController.addAddress(addressModel).then((value) {
                                              locationController.getUserAddress();
                                            }).then((value) {
                                              Get.toNamed(
                                                  RouteHelper.getAddAddressPage());
                                            });
                                            locationController.setAddAddressData();
                                          }
                                          // Get.toNamed(
                                          //     RouteHelper.getAddAddressPage());
                                        }
                                      }
                                    },
                            ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
