import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/model/route.dart';
import 'package:travel_app/services/maps/routes_service.dart';

class BookingScreenViewModel extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController originController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final List<RouteModel> _routes = [];

  AppleMapController?
      _mapController; // Add this to keep a reference to the map controller

  LatLng _originLatLng = const LatLng(0.0, 0.0); // San Francisco
  LatLng _destinationLatLng =
      const LatLng(0.0,0.0); // Nearby location
  bool _routeLoading = false;
  List<LatLng> _routePoints = [];

  bool get routeLoading => _routeLoading;
  List<LatLng> get routePoints => _routePoints;
  List<RouteModel> get routes => _routes;
  LatLng get originLatLng => _originLatLng;
  LatLng get destinationLatLng => _destinationLatLng;

  set setOriginLatLng(LatLng origin) {
    _originLatLng = origin;
    notifyListeners();
  }

  set mapController(AppleMapController controller) {
    _mapController = controller;
  }

  set setDestinationLatLng(LatLng destination) {
    _destinationLatLng = destination;
    notifyListeners();
  }

  String formatDuration(String durationStr) {
    // Extract the numeric value from the string
    int seconds = int.parse(durationStr.replaceAll('s', ''));

    // Convert seconds to minutes, hours, days, etc.
    if (seconds < 60) {
      return "$seconds seconds";
    } else if (seconds < 3600) {
      int minutes = seconds ~/ 60;
      int remainingSeconds = seconds % 60;
      return remainingSeconds > 0
          ? "$minutes minutes and $remainingSeconds seconds"
          : "$minutes minutes";
    } else if (seconds < 86400) {
      int hours = seconds ~/ 3600;
      int remainingMinutes = (seconds % 3600) ~/ 60;
      return remainingMinutes > 0
          ? "$hours hours and $remainingMinutes minutes"
          : "$hours hours";
    } else {
      int days = seconds ~/ 86400;
      int remainingHours = (seconds % 86400) ~/ 3600;
      return remainingHours > 0
          ? "$days days and $remainingHours hours"
          : "$days days";
    }
  }

  Future<void> fetchRoutePoints(LatLng origin, LatLng destination) async {
    _routeLoading = true;
    notifyListeners();

    // Fetch the route  points
    RouteModel fetchedRoutePoints =
        await RoutesService().fetchRoute(origin, destination);
    fetchedRoutePoints = fetchedRoutePoints.copyWith(
      start: originController.text,
      end: destinationController.text,
    );

    _routes.add(fetchedRoutePoints);

    _routePoints = RoutesService().decodePolyline(fetchedRoutePoints.polyline);

    _routeLoading = false;
    notifyListeners();
    // After fetching the route points, move and zoom the camera to fit the route
    moveCameraToFitRoute();
  }

  void moveCameraToFitRoute() {
    if (_routePoints.isEmpty || _mapController == null) return;

    LatLngBounds bounds = _getLatLngBounds(_routePoints);

    _mapController?.moveCamera(
      CameraUpdate.newLatLngBounds(bounds, 100.0), // 50.0 is padding
    );
  }

  LatLngBounds _getLatLngBounds(List<LatLng> points) {
    assert(points.isNotEmpty);

    double minLat = points.first.latitude;
    double maxLat = points.first.latitude;
    double minLng = points.first.longitude;
    double maxLng = points.first.longitude;

    for (LatLng point in points) {
      if (point.latitude < minLat) minLat = point.latitude;
      if (point.latitude > maxLat) maxLat = point.latitude;
      if (point.longitude < minLng) minLng = point.longitude;
      if (point.longitude > maxLng) maxLng = point.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }
}
