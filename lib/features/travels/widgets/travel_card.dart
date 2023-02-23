import 'package:flutter/material.dart';
import 'package:travel_utility/common/models/travel_data/entry.dart';
import 'package:travel_utility/common/utils/date_util.dart';
import 'package:travel_utility/features/travel_details/screens/travel_detail_screen.dart';

class TravelCard extends StatelessWidget {
  const TravelCard({
    super.key,
    required this.entry,
  });

  static const List<Color> kColors = [
    Color(0xFF01a3a4),
    Color(0xFFff9f43),
    Color(0xFF54a0ff),
    Color(0xFFee5253),
    Color(0xFF5f27cd),
    Color(0xFF0abde3),
    Color(0xFF10ac84),
    Color(0xFF576574),
  ];

  static const double kContainerWidth = 3;
  static const double kMinHeight = 0.8;
  static const double kMaxHeight = 1;
  static const double kBorderWidth = 4;
  static const double kBorderRadius = 20;
  static const double kNoteWidth = 2;
  static const double kNoteFontSize = 14;

  final Entry entry;

  @override
  Widget build(BuildContext context) {
    final int randomIndex = entry.hashCode % kColors.length;

    // Generate a random color
    final Color cardColor = kColors[randomIndex];

    final dateString = entry.date!;
    final dayString = DateUtil.getDay(dateString);
    final String monthName = DateUtil.getMonthName(dateString);

    return SizedBox(
      height: 150.0,
      width: double.infinity,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double containerSize = constraints.maxWidth / kContainerWidth;
          return Stack(
            children: [
              Positioned(
                bottom: 10,
                right: 10,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: containerSize * kMinHeight, // Set the minimum height
                    minWidth: containerSize, // Set the minimum width
                    maxHeight: containerSize * kMaxHeight, // Set the maximum height
                    maxWidth: containerSize * (kContainerWidth - 0.25), // Set the maximum width
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.width / 4.5,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: cardColor,
                      border: Border.all(
                        color: Colors.black,
                        width: kBorderWidth,
                      ),
                      borderRadius: BorderRadius.circular(kBorderRadius),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                right: 21,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: containerSize * kMinHeight, // Set the minimum height
                    minWidth: containerSize, // Set the minimum width
                    maxHeight: containerSize * kMaxHeight, // Set the maximum height
                    maxWidth: containerSize * (kContainerWidth - 0.25), // Set the maximum width
                  ),
                  child: InkWell(
                    onTap: () => Navigator.pushNamed(
                      context,
                      TravelDetailScreen.routerName,
                      arguments: entry.uuid,
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.width / 4.5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black,
                          width: kBorderWidth,
                        ),
                        borderRadius: BorderRadius.circular(kBorderRadius),
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
                          const SizedBox(width: 15),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${entry.distance!}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontFamily: 'Lato',
                                      fontSize: MediaQuery.of(context).size.width / 18,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  const Text('km'),
                                ],
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: containerSize * kNoteWidth,
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
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
