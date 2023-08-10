import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:food_delivery_app/constants/dimensions.dart';
import 'package:food_delivery_app/controllers/location_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/src/places.dart';

class LocationSearchDialogue extends StatelessWidget {
  final GoogleMapController mapController;
  const LocationSearchDialogue({super.key, required this.mapController});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    return Container(
      padding: EdgeInsets.all(Dimensions.width10),
      alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius10),
        ),
        child: SizedBox(
          width: Dimensions.screenWidth,
          child: TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                controller: _controller,
                textInputAction: TextInputAction.search,
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                    hintText: 'Search for Your Location',
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius10),
                        borderSide:
                            const BorderSide(style: BorderStyle.none, width: 0)),
                    hintStyle: TextStyle(
                        fontSize: Dimensions.fontSize16,
                        color: Theme.of(context).disabledColor)),
              ),
              suggestionsCallback: (String pattern) async {
                return await Get.find<LocationController>()
                    .searchLocation(context, pattern);
              },
              itemBuilder: (BuildContext context, Prediction? suggestion) {
                return Padding(
                  padding: EdgeInsets.all(Dimensions.width10),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on),
                      SizedBox(
                        width: Dimensions.width10,
                      ),
                      Expanded(
                        child: Text(
                          suggestion!.description!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: Dimensions.fontSize16,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
              onSuggestionSelected: (Prediction suggestion) {
                Get.find<LocationController>().setLocation(suggestion.placeId!, suggestion.description!, mapController);
                Get.back();
              },
          ),
        ),
      ),
    );
  }
}
