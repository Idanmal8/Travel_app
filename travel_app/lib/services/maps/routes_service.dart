// import 'dart:convert';
// import 'package:apple_maps_flutter/apple_maps_flutter.dart';
// import 'package:http/http.dart' as http;

// Future<List<LatLng>> fetchRoutePoints(LatLng origin, LatLng destination) async {
//   final String url = 'https://maps.googleapis.com/maps/api/directions/json?'
//       'origin=${origin.latitude},${origin.longitude}&'
//       'destination=${destination.latitude},${destination.longitude}&'
//       'key=YOUR_API_KEY';

//   final response = await http.get(Uri.parse(url));

//   if (response.statusCode == 200) {
//     final Map<String, dynamic> data = jsonDecode(response.body);
//     final List<dynamic> routes = data['routes'];
//     if (routes.isNotEmpty) {
//       final List<dynamic> points = routes[0]['overview_polyline']['points'];
//       return decodePolyline(points);
//     }
//   } else {
//     throw Exception('Failed to load route');
//   }

//   return [];
// }
