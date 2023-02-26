import 'package:flutter/material.dart';
import 'package:travel_utility/common/models/travel_data/entry.dart';
import 'package:travel_utility/common/utils/constants.dart';
import 'package:travel_utility/common/utils/date_util.dart';
import 'package:travel_utility/common/widgets/stacked_card.dart';
import 'package:travel_utility/features/travel_details/screens/travel_detail_screen.dart';

class TravelCard extends StatelessWidget {
  const TravelCard({
    super.key,
    required this.entry,
  });

  final Entry entry;

  @override
  Widget build(BuildContext context) {
    // Generate a random color
    final cardColor = getRandomColor(entry);

    final dateString = entry.date!;
    final dayString = DateUtil.getDay(dateString);
    final String monthName = DateUtil.getMonthName(dateString);
    final mediaQuery = MediaQuery.of(context).size.width;

    return StackedCard(
      height: mediaQuery / 3.3,
      enableTap: true,
      color: cardColor,
      onTap: () => Navigator.pushNamed(
        context,
        TravelDetailScreen.routeName,
        arguments: {
          'entryUuid': entry.uuid,
          'cardColor': cardColor,
        },
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                dayString,
                style: TextStyle(
                  color: cardColor,
                  fontFamily: 'BebasNeue',
                  fontSize: mediaQuery / 12,
                ),
              ),
              Text(
                monthName.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: mediaQuery / 28,
                ),
              ),
            ],
          ),
          const SizedBox(width: 35),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${entry.distance!}',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Lato',
                      fontSize: mediaQuery / 14,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text('km'),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: mediaQuery / 1.55,
                child: Text(
                  entry.note!.isEmpty ? '' : 'Note: ${entry.note}',
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
    );
  }
}
