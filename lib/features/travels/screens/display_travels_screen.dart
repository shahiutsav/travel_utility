import 'package:flutter/material.dart';
import 'package:travel_utility/common/services/handle_storage.dart';
import 'package:travel_utility/features/travels/screens/add_travel_screen.dart';
import 'package:provider/provider.dart';
import 'package:travel_utility/providers/travels/entry_provider.dart';

class DisplayTravelsScreen extends StatelessWidget {
  DisplayTravelsScreen({super.key});
  final HandleStorage handleStorage = HandleStorage();

  @override
  Widget build(BuildContext context) {
    final entries = Provider.of<EntryProvider>(context).entries;

    return Scaffold(
      body: ListView.builder(
        itemCount: entries.length,
        itemBuilder: (context, index) {
          return Text(
            entries[index].distance.toString(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(
          context,
          AddTravelScreen.routeName,
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
