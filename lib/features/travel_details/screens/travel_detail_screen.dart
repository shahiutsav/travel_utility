import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_utility/common/models/travel_data/entry.dart';
import 'package:travel_utility/common/utils/date_util.dart';
import 'package:travel_utility/providers/travels/entry_provider.dart';

class TravelDetailScreen extends StatelessWidget {
  static const routerName = '/travel-detail';
  const TravelDetailScreen({
    super.key,
    required this.entryUuid,
  });

  final String entryUuid;

  @override
  Widget build(BuildContext context) {
    final Entry loadedEntry =
        Provider.of<EntryProvider>(context).entries.firstWhere((entry) => entry.uuid == entryUuid);

    final dateString = loadedEntry.date!;
    final dayString = DateUtil.getDay(dateString);
    final String monthName = DateUtil.getMonthName(dateString);

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Text(dayString),
                  Text(monthName),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      loadedEntry.distance.toString(),
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 5,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      'km',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
