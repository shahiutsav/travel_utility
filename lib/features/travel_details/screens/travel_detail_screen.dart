import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_utility/common/models/travel_data/entry.dart';
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
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Text(loadedEntry.date!),
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
