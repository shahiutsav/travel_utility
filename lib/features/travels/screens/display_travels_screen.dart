import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_utility/common/models/travel_data/entry.dart';
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
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 4,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Column(
                        children: [
                          Text(
                            dayString,
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 18,
                            ),
                          ),
                          Text(
                            monthName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width / 28,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 15),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${entry.distance!} km',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 24,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.4,
                            child: Text(
                              'Note: ${entry.note}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.black45,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 15)
              ],
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
