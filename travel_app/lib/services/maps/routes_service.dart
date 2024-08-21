import 'dart:convert';
import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app/constants/keys.dart';

class RoutesService {
  Future<List<LatLng>> fetchRoutePoints(LatLng origin, LatLng destination) async {
    const String endpoint = 'https://routes.googleapis.com/directions/v2:computeRoutes';

    final Map<String, dynamic> requestBody = {
      "origin": {
        "location": {
          "latLng": {
            "latitude": origin.latitude,
            "longitude": origin.longitude
          }
        }
      },
      "destination": {
        "location": {
          "latLng": {
            "latitude": destination.latitude,
            "longitude": destination.longitude
          }
        }
      },
      "travelMode": "WALK",
      "routingPreference": "ROUTING_PREFERENCE_UNSPECIFIED",
      "polylineQuality": "HIGH_QUALITY",
      "polylineEncoding": "ENCODED_POLYLINE",
      "computeAlternativeRoutes": false,
      "routeModifiers": {
        "avoidTolls": false,
        "avoidHighways": false,
        "avoidFerries": false
      },
      "languageCode": "en-US",
      "units": "IMPERIAL"
    };

    final response = await http.post(
      Uri.parse('$endpoint?key=${Keys.googleMapsKey}'),
      headers: {
        'Content-Type': 'application/json',
        'X-Goog-FieldMask': 'routes.distanceMeters,routes.duration,routes.polyline.encodedPolyline', // Add FieldMask here
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Assuming the polyline is encoded and located at the expected place
      final String polyline = data['routes'][0]['polyline']['encodedPolyline'];
      return _decodePolyline(polyline);
    } else {
      print('Failed to fetch route. Status code: ${response.statusCode}');
      print('Response: ${response.body}');
      throw Exception('Failed to load route');
    }
  }

  List<LatLng> _decodePolyline(String polyline) {
    List<LatLng> points = [];
    int index = 0, len = polyline.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return points;
  }
}