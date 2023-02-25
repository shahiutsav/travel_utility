import 'package:flutter/material.dart';
import 'package:travel_utility/features/travel_details/screens/travel_detail_screen.dart';
import 'package:travel_utility/features/travels/screens/add_travel_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    // Route to add_travel_screen
    case AddTravelScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddTravelScreen(),
      );

    case TravelDetailScreen.routeName:
      final Map<String, dynamic> args = routeSettings.arguments as Map<String, dynamic>;
      final String entryUuid = args['entryUuid'];
      final Color cardColor = args['cardColor'];
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => TravelDetailScreen(
          entryUuid: entryUuid,
          cardColor: cardColor,
        ),
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
