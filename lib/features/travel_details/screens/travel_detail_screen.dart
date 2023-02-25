import 'package:another_flushbar/flushbar.dart';
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

  Future<void> deleteTravel({
    required BuildContext context,
    required Entry entry,
  }) async {
    Provider.of<EntryProvider>(context, listen: false).deleteEntry(entry).then((_) {
      Navigator.pop(context);
      showFlushbar(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final loadedEntry = Provider.of<EntryProvider>(
      context,
    ).entries.firstWhere(
      (entry) => entry.uuid == entryUuid,
      orElse: () {
        return Entry(
          date: DateTime.now().toString(),
          distance: 0,
          note: '',
        );
      },
    );

    final dateString = loadedEntry.date!;
    final dayString = DateUtil.getDay(dateString);
    final String monthName = DateUtil.getMonthName(dateString);
    final String note = loadedEntry.note!;
    final mediaQuery = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: mediaQuery.width,
          height: mediaQuery.height - 1,
          child: Stack(
            children: [
              _displayDate(mediaQuery.width, dayString, monthName),
              Positioned(
                top: 20,
                right: 20,
                child: Column(
                  children: [
                    CustomButton(
                        icon: Icons.delete,
                        color: Colors.red.shade300,
                        onTap: () {
                          deleteTravel(
                            context: context,
                            entry: loadedEntry,
                          );
                        }),
                    const SizedBox(height: 18),
                    CustomButton(
                      icon: Icons.edit,
                      color: Colors.blue.shade300,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _displayDistance(loadedEntry, mediaQuery.width),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: mediaQuery.width / 1.6,
                      child: Text(
                        "\" $note \"",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: mediaQuery.width / 30,
                          color: Colors.black54,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Positioned _displayDate(double mediaQueryWidth, String dayString, String monthName) {
    return Positioned(
      top: 20,
      left: 20,
      child: StackedCard(
        color: cardColor,
        width: mediaQueryWidth / 5,
        height: mediaQueryWidth / 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              dayString,
              style: TextStyle(
                color: cardColor,
                fontFamily: 'BebasNeue',
                fontSize: mediaQueryWidth / 12,
              ),
            ),
            Text(
              monthName.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: mediaQueryWidth / 28,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Center _displayDistance(Entry loadedEntry, double mediaQueryWidth) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            loadedEntry.distance.toString(),
            style: TextStyle(
              fontSize: mediaQueryWidth / 5,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            'km',
            style: TextStyle(
              fontSize: mediaQueryWidth / 15,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.color,
    required this.onTap,
    required this.icon,
  });

  final Color color;
  final VoidCallback onTap;
  final IconData icon;

  final double buttonSize = 70.0;

  @override
  Widget build(BuildContext context) {
    return StackedCard(
      height: buttonSize,
      width: buttonSize,
      borderRadius: 100,
      enableTap: true,
      color: color,
      onTap: onTap,
      child: Icon(
        icon,
        size: 35,
        color: color,
      ),
    );
  }
}

void showFlushbar(BuildContext context) {
  Flushbar(
    message: 'The data has been deleted',
    icon: Icon(
      Icons.delete_forever,
      size: 28.0,
      color: Colors.red.shade300,
    ),
    margin: const EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(8),
    leftBarIndicatorColor: Colors.red.shade300,
    duration: const Duration(seconds: 3),
  ).show(context);
}
