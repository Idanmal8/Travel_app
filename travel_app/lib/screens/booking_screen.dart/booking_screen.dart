import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/screens/booking_screen.dart/widgets/location_input_widget.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<LatLng> routePoints = [
      LatLng(37.7749, -122.4194), // Start point (San Francisco)
      LatLng(37.7849, -122.4094), // Mid point
      LatLng(37.7949, -122.3994), // End point
    ];

    // Create a Polyline with the route points
    final Set<Polyline> polylines = {
      Polyline(
        polylineId: PolylineId('route_1'),
        points: routePoints,
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
                flex: 5,
                child: AppleMap(
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(37.7749, -122.4194),
                    zoom: 15,
                  ),
                  polylines: polylines, // Add polylines to the map
                  annotations: {
                    Annotation(
                      annotationId: AnnotationId('start_point'),
                      position: LatLng(37.7749, -122.4194),
                      infoWindow: InfoWindow(
                        title: 'Start',
                        snippet: 'Start of the route',
                      ),
                    ),
                    Annotation(
                      annotationId: AnnotationId('end_point'),
                      position: LatLng(37.7949, -122.3994),
                      infoWindow: InfoWindow(
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
          const LocationInputWidget()
        ],
      ),
    );
  }
}
