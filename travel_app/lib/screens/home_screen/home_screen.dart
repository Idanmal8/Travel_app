import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/screens/booking_screen.dart/booking_screen.dart';
import 'package:travel_app/screens/home_screen/view_model/home_screen_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeScreenViewModel>(
      create: (context) => HomeScreenViewModel(),
      child: Consumer<HomeScreenViewModel>(
        builder: (context, viewModel, _) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: BookingScreen(),
          );
        },
      ),
    );
  }
}
