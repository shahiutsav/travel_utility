import 'package:flutter/material.dart';
import 'package:travel_utility/features/travels/screens/add_travel_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    // Route to add_travel_screen
    case AddTravelScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddTravelScreen(),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('The screen you are trying to go to does not exist yet.'),
          ),
        ),
      );
  }
}
