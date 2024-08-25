import 'dart:async';
import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/screens/booking_screen.dart/view_model/booking_screen_view_model.dart';
import 'package:travel_app/screens/booking_screen.dart/widgets/history_card.dart';
import 'package:travel_app/screens/booking_screen.dart/widgets/location_input_widget.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  BookingScreenState createState() => BookingScreenState();
}

class BookingScreenState extends State<BookingScreen> {
  final List<LatLng> _animatedRoutePoints = [];
  Timer? _timer;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  int _insertedItemsCount = 0;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startPolylineAnimation(List<LatLng> routePoints) {
    int index = 0;
    _animatedRoutePoints.clear();

    _timer = Timer.periodic(const Duration(microseconds: 5600), (Timer timer) {
      if (index < routePoints.length) {
        setState(() {
          _animatedRoutePoints.add(routePoints[index]);
        });
        index++;
      } else {
        timer.cancel();
      }
    });
  }

  void _animateHistoryCardAddition(BookingScreenViewModel viewModel) {
    if (_listKey.currentState != null) {
      final newRoutes = viewModel.routes.length - _insertedItemsCount;
      for (int i = 0; i < newRoutes; i++) {
        _listKey.currentState?.insertItem(
          0,
          duration: const Duration(milliseconds: 500),
        );
        _insertedItemsCount++;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookingScreenViewModel>(
      create: (context) => BookingScreenViewModel(),
      child: Consumer<BookingScreenViewModel>(
        builder: (context, viewModel, child) {
          // Start the animation when route points are fetched
          if (viewModel.routePoints.isNotEmpty &&
              _animatedRoutePoints.isEmpty) {
            _startPolylineAnimation(viewModel.routePoints);
          }

          // Create a Polyline with the animated route points
          final Set<Polyline> polylines = {
            Polyline(
              polylineId: PolylineId('route_1'),
              points: _animatedRoutePoints,
              width: 5,
              color: const Color.fromARGB(255, 0, 140, 255),
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
                        onMapCreated: (AppleMapController controller) {
                          viewModel.mapController = controller;
                        },
                        polylines: polylines, // Add animated polylines to the map
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
                        },
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(4, 121, 94, 1),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: AnimatedList(
                            padding: const EdgeInsets.only(top: 80.0),
                            key: _listKey,
                            initialItemCount: _insertedItemsCount,
                            itemBuilder: (context, index, animation) {
                              // Get the correct list based on the current number of items in the AnimatedList
                              final reversedRoutes =
                                  viewModel.routes.reversed.toList();

                              if (index < reversedRoutes.length) {
                                final route = reversedRoutes[index];
                                return SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0, -1),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: HistoryCard(
                                    startLine: route.start ?? '',
                                    destination: route.end ?? '',
                                    time: viewModel
                                        .formatDuration(route.duration),
                                    distance: '${route.distanceMeters}m',
                                  ),
                                );
                              } else {
                                return const SizedBox(); // Return an empty widget if the index is out of bounds
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                LocationInputWidget(
                  originController: viewModel.originController,
                  destinationController: viewModel.destinationController,
                  onPressed: () async {
                    await viewModel.fetchRoutePoints(
                        viewModel.originLatLng, viewModel.destinationLatLng);

                    // Restart the animation after fetching new points
                    _startPolylineAnimation(viewModel.routePoints);

                    // Ensure that AnimatedList and viewModel.routes are synchronized
                    _animateHistoryCardAddition(viewModel);
                  },
                  formKey: viewModel.formKey,
                  isRouteLoading: viewModel.routeLoading,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}