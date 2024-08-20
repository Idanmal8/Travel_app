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
          return Scaffold(
            backgroundColor: Colors.white,
            body: <Widget>[
              const BookingScreen(),
              Container(
                color: Colors.blue,
                child: const Center(
                  child: Text('Flights'),
                ),
              ),
            ][viewModel.selectedIndex],
            bottomNavigationBar: NavigationBar(
              elevation: 1,
              height: 80,
              backgroundColor: Colors.white,
              onDestinationSelected: (int index) {
                viewModel.onItemTapped(index);
              },
              selectedIndex: viewModel.selectedIndex,
              destinations: <Widget>[
                NavigationDestination(
                  selectedIcon: SizedBox(
                    width: 25,
                    height: 25,
                    child: Image.asset(
                        '/Users/idanmal/Desktop/Projects/Travel_app/travel_app/assets/icons/home_fill.png'),
                  ),
                  icon: SizedBox(
                    width: 25,
                    height: 25,
                    child: Image.asset(
                      '/Users/idanmal/Desktop/Projects/Travel_app/travel_app/assets/icons/home.png',
                    ),
                  ),
                  label: 'Book',
                ),
                NavigationDestination(
                  selectedIcon: SizedBox(
                    width: 25,
                    height: 25,
                    child: Image.asset(
                        '/Users/idanmal/Desktop/Projects/Travel_app/travel_app/assets/icons/airplane_fill.png'),
                  ),
                  icon: SizedBox(
                    width: 25,
                    height: 25,
                    child: Image.asset(
                      '/Users/idanmal/Desktop/Projects/Travel_app/travel_app/assets/icons/airplane.png',
                    ),
                  ),
                  label: 'Flights',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
