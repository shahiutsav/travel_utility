import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_utility/common/models/travel_data/entry.dart';
import 'package:travel_utility/common/services/handle_storage.dart';
import 'package:travel_utility/features/travels/screens/add_travel_screen.dart';
import 'package:provider/provider.dart';
import 'package:travel_utility/features/travels/widgets/travel_card.dart';
import 'package:travel_utility/providers/travels/entry_provider.dart';

class DisplayTravelsScreen extends StatelessWidget {
  DisplayTravelsScreen({super.key});
  final HandleStorage handleStorage = HandleStorage();

  @override
  Widget build(BuildContext context) {
    final entries = Provider.of<EntryProvider>(context).entries;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView.builder(
          itemCount: entries.length,
          itemBuilder: (context, index) {
            final Entry entry = entries[index];
            final dateString = entry.date!;
            DateTime date = DateTime.parse(dateString);
            final int day = date.day;
            var dayString = day.toString();
            var numberOfZeroRequired = 2 - dayString.length;

            while (numberOfZeroRequired != 0) {
              dayString = '0$dayString';
              numberOfZeroRequired--;
            }

            final String monthName = DateFormat.MMM().format(date);
            return TravelCard(
              dayString: dayString,
              monthName: monthName,
              entry: entry,
            );
          },
        ),
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
