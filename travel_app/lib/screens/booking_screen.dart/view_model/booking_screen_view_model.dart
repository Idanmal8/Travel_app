import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/services/maps/routes_service.dart';

class BookingScreenViewModel extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController originController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  
  LatLng _originLatLng = const LatLng(37.7749, -122.4194); // San Francisco
  LatLng _destinationLatLng = const LatLng(37.7849, -122.4094); // Nearby location
  bool _routeLoading = false;
  List<LatLng> _routePoints = [];

  bool get routeLoading => _routeLoading;
  List<LatLng> get routePoints => _routePoints;
  LatLng get originLatLng => _originLatLng;
  LatLng get destinationLatLng => _destinationLatLng;

  set setOriginLatLng(LatLng origin) {
    _originLatLng = origin;
    notifyListeners();
  }

  set setDestinationLatLng(LatLng destination) {
    _destinationLatLng = destination;
    notifyListeners();
  }

  Future<void> fetchRoutePoints(LatLng origin, LatLng destination) async {
    _routeLoading = true;
    notifyListeners();

    // Fetch the route  points
    _routePoints = await RoutesService()
        .fetchRoutePoints(originLatLng, destinationLatLng);

    _routeLoading = false;
    notifyListeners();
  }
}
