import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_utility/common/models/travel_data/entry.dart';
import 'package:travel_utility/common/utils/date_util.dart';
import 'package:travel_utility/common/widgets/stacked_card.dart';
import 'package:travel_utility/providers/travels/entry_provider.dart';

class TravelDetailScreen extends StatelessWidget {
  static const routeName = '/travel-detail';
  const TravelDetailScreen({
    super.key,
    required this.entryUuid,
    required this.cardColor,
  });

  final String entryUuid;
  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    final Entry loadedEntry =
        Provider.of<EntryProvider>(context).entries.firstWhere((entry) => entry.uuid == entryUuid);

    final dateString = loadedEntry.date!;
    final dayString = DateUtil.getDay(dateString);
    final String monthName = DateUtil.getMonthName(dateString);

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 1,
          child: Stack(
            children: [
              Positioned(
                top: 20,
                left: 20,
                child: StackedCard(
                  color: cardColor,
                  width: MediaQuery.of(context).size.width / 5,
                  height: MediaQuery.of(context).size.width / 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        dayString,
                        style: TextStyle(
                          color: cardColor,
                          fontFamily: 'BebasNeue',
                          fontSize: MediaQuery.of(context).size.width / 12,
                        ),
                      ),
                      Text(
                        monthName.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width / 28,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
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
            ],
          ),
        ),
      ),
    );
  }
}
