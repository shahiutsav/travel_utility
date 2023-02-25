import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:travel_utility/common/services/handle_storage.dart';
import 'package:travel_utility/features/travels/screens/display_travels_screen.dart';
import 'package:travel_utility/providers/travels/entry_provider.dart';
import 'package:travel_utility/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HandleStorage().createInitialData().then(
    (_) {
      runApp(
        ChangeNotifierProvider(
          create: (_) => EntryProvider(),
          child: const MainApp(),
        ),
      );
    },
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return MaterialApp(
      onGenerateRoute: (settings) => generateRoute(settings),
      home: DisplayTravelsScreen(),
    );
  }
}
