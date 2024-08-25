import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
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
  final bool isRouteLoading;

  const LocationInputWidget({
    required this.onPressed,
    required this.originController,
    required this.destinationController,
    required this.formKey,
    required this.isRouteLoading,
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
                              Expanded(
                                child: GooglePlaceAutoCompleteTextField(
                                  boxDecoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  textEditingController:
                                      widget.originController,
                                  itemBuilder: (context, index, prediction) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical:
                                              8.0), // Adds space between items
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(
                                            8.0), // Custom border radius
                                      ),
                                      child: ListTile(
                                        title: Text(
                                          prediction.description ?? "",
                                          style:
                                              const TextStyle(fontSize: 14.0),
                                        ),
                                        leading: const Icon(Icons.location_on,
                                            color: Colors.grey),
                                      ),
                                    );
                                  },
                                  googleAPIKey: Keys.googleMapsKey,
                                  inputDecoration: const InputDecoration(
                                    hintText: 'From where?',
                                    icon:
                                        Icon(Icons.location_searching_rounded),
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
                                    icon: Icon(Icons.location_on),
                                    border: InputBorder.none,
                                  ),
                                  itemBuilder: (context, index, prediction) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical:
                                              8.0), // Adds space between items
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(
                                            8.0), // Custom border radius
                                      ),
                                      child: ListTile(
                                        title: Text(
                                          prediction.description ?? "",
                                          style:
                                              const TextStyle(fontSize: 14.0),
                                        ),
                                        leading: const Icon(Icons.location_on,
                                            color: Colors.grey),
                                      ),
                                    );
                                  },
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: widget.isRouteLoading ? const CupertinoActivityIndicator(
                          radius: 12,
                          color: Colors.white,
                        ) :
                        const Icon(Icons.send_and_archive_rounded,
                            color: Colors.white),
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
