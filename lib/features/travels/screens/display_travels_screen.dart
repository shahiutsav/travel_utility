import 'package:flutter/material.dart';
import 'package:travel_utility/common/models/travel_data/entry.dart';
import 'package:travel_utility/common/services/handle_storage.dart';
import 'package:travel_utility/common/widgets/stacked_card.dart';
import 'package:travel_utility/features/travels/screens/add_travel_screen.dart';
import 'package:provider/provider.dart';
import 'package:travel_utility/features/travels/widgets/travel_card.dart';
import 'package:travel_utility/providers/travels/entry_provider.dart';

class DisplayTravelsScreen extends StatelessWidget {
  DisplayTravelsScreen({super.key});
  final HandleStorage handleStorage = HandleStorage();

  @override
  Widget build(BuildContext context) {
    final entries = Provider.of<EntryProvider>(context).getEntriesSortedByDate();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView.separated(
          itemCount: entries.length,
          itemBuilder: (context, index) {
            final Entry entry = entries[index];
            return TravelCard(
              entry: entry,
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 20),
        ),
      ),
      floatingActionButton: StackedCard(
        height: 70.0,
        width: 70.0,
        borderRadius: 30,
        enableTap: true,
        onTap: () => Navigator.pushNamed(
          context,
          AddTravelScreen.routeName,
        ),
        child: const Icon(
          Icons.alt_route_rounded,
          size: 35,
        ),
      ),
    );
  }
}
