import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/screens/booking_screen.dart/view_model/booking_screen_view_model.dart';
import 'package:travel_app/screens/booking_screen.dart/widgets/location_input_widget.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookingScreenViewModel>(
      create: (context) => BookingScreenViewModel(),
      child: Consumer<BookingScreenViewModel>(
        builder: (context, viewModel, child) {
          // Create a Polyline with the fetched route points
          final Set<Polyline> polylines = {
            Polyline(
              polylineId: PolylineId('route_1'),
              points: viewModel.routePoints,
              width: 5,
              color: Colors.blue,
              visible: true,
            ),
          };

          return Scaffold(
            body: Stack(
              children: <Widget>[
                Column(
                  children: [
                    Expanded(
                      flex: 6,
                      child: AppleMap(
                        initialCameraPosition: const CameraPosition(
                          target: LatLng(37.7749, -122.4194),
                          zoom: 14,
                        ),
                        polylines: polylines, // Add polylines to the map
                        annotations: {
                          Annotation(
                            annotationId: AnnotationId('start_point'),
                            position: viewModel.originLatLng,
                            infoWindow: const InfoWindow(
                              title: 'Start',
                              snippet: 'Start of the route',
                            ),
                          ),
                          Annotation(
                            annotationId: AnnotationId('end_point'),
                            position: viewModel.destinationLatLng,
                            infoWindow: const InfoWindow(
                              title: 'End',
                              snippet: 'End of the route',
                            ),
                          ),
                        }, // Optional: Add markers for the start and end points
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Expanded(
                        flex: 5,
                        child: Container(
                          color: Colors.transparent,
                        )),
                    Expanded(
                      flex: 5,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(4, 121, 94, 1),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                LocationInputWidget(
                  originController: viewModel.originController,
                  destinationController: viewModel.destinationController,
                  onPressed: () {
                    viewModel.fetchRoutePoints(
                        viewModel.originLatLng, viewModel.destinationLatLng);
                  },
                  formKey: viewModel.formKey,
                ),
                if (viewModel.routeLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
