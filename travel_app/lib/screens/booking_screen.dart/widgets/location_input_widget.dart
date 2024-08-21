import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/constants/keys.dart';
import 'package:travel_app/screens/booking_screen.dart/view_model/booking_screen_view_model.dart';

class LocationInputWidget extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController originController;
  final TextEditingController destinationController;
  final VoidCallback onPressed;

  const LocationInputWidget({
    required this.onPressed,
    required this.originController,
    required this.destinationController,
    required this.formKey,
    super.key,
  });

  @override
  LocationInputWidgetState createState() => LocationInputWidgetState();
}

class LocationInputWidgetState extends State<LocationInputWidget> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<BookingScreenViewModel>(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Card(
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Form(
                      key: widget.formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(Icons.search_rounded),
                              const SizedBox(width: 10),
                              Expanded(
                                child: GooglePlaceAutoCompleteTextField(
                                  boxDecoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  textEditingController:
                                      widget.originController,
                                  googleAPIKey: Keys.googleMapsKey,
                                  inputDecoration: const InputDecoration(
                                    hintText: 'From where?',
                                    border: InputBorder.none,
                                  ),
                                  debounceTime: 400,
                                  isLatLngRequired: true,
                                  getPlaceDetailWithLatLng: (prediction) async {
                                    final lat = prediction.lat;
                                    final lng = prediction.lng;

                                    if (lat != null && lng != null) {
                                      viewModel.setOriginLatLng = LatLng(
                                          double.parse(lat), double.parse(lng));
                                    }
                                  },
                                  itemClick: (prediction) {
                                    widget.originController.text =
                                        prediction.description ?? "";
                                    widget.originController.selection =
                                        TextSelection.fromPosition(
                                      TextPosition(
                                          offset:
                                              prediction.description?.length ??
                                                  0),
                                    );
                                  },
                                  countries: const ["us"],
                                  textStyle: const TextStyle(
                                    fontSize:
                                        14.0, // Adjust this value to make the text smaller or larger
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(Icons.location_on),
                              const SizedBox(width: 10),
                              Expanded(
                                child: GooglePlaceAutoCompleteTextField(
                                  boxDecoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  textEditingController:
                                      widget.destinationController,
                                  googleAPIKey: Keys.googleMapsKey,
                                  inputDecoration: const InputDecoration(
                                    hintText: 'Where to?',
                                    border: InputBorder.none,
                                  ),
                                  debounceTime: 400,
                                  isLatLngRequired: true,
                                  getPlaceDetailWithLatLng: (prediction) async {
                                    final lat = prediction.lat;
                                    final lng = prediction.lng;

                                    if (lat != null && lng != null) {
                                      viewModel.setDestinationLatLng = LatLng(
                                          double.parse(lat), double.parse(lng));
                                    }
                                  },
                                  itemClick: (prediction) {
                                    widget.destinationController.text =
                                        prediction.description ?? "";
                                    widget.destinationController.selection =
                                        TextSelection.fromPosition(
                                      TextPosition(
                                          offset:
                                              prediction.description?.length ??
                                                  0),
                                    );
                                  },
                                  countries: const ["us"],
                                  textStyle: const TextStyle(
                                    fontSize:
                                        14.0, // Adjust this value to make the text smaller or larger
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  InkWell(
                    onTap: widget.onPressed,
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      color: const Color.fromRGBO(4, 121, 94, 1),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child:
                            Icon(Icons.swap_vert_rounded, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
