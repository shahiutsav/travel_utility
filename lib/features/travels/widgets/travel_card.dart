import 'dart:math';

import 'package:flutter/material.dart';
import 'package:travel_utility/common/models/travel_data/entry.dart';

class TravelCard extends StatelessWidget {
  TravelCard({
    super.key,
    required this.dayString,
    required this.monthName,
    required this.entry,
  });

  final List<Color> colors = [
    const Color(0xFF01a3a4),
    const Color(0xFFff9f43),
    const Color(0xFF54a0ff),
    const Color(0xFFee5253),
    const Color(0xFF5f27cd),
    const Color(0xFF0abde3),
    const Color(0xFF10ac84),
    const Color(0xFF576574),
  ];

  final String dayString;
  final String monthName;
  final Entry entry;

  @override
  Widget build(BuildContext context) {
    final Random random = Random();

    // Generate a random color
    final Color cardColor = colors[random.nextInt(colors.length)];

    return SizedBox(
      height: 150.0,
      width: double.infinity,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double containerSize = constraints.maxWidth / 3;
          return Stack(
            children: [
              Positioned(
                bottom: 10,
                right: 10,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: containerSize * 0.8, // Set the minimum height
                    minWidth: containerSize, // Set the minimum width
                    maxHeight: containerSize * 1, // Set the maximum height
                    maxWidth: containerSize * 2.75, // Set the maximum width
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.width / 4.5,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: cardColor,
                      border: Border.all(
                        color: Colors.black,
                        width: 4,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                right: 21,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: containerSize * 0.8, // Set the minimum height
                    minWidth: containerSize, // Set the minimum width
                    maxHeight: containerSize * 1, // Set the maximum height
                    maxWidth: containerSize * 2.75, // Set the maximum width
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.width / 4.5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                        width: 4,
                      ),
                      borderRadius: BorderRadius.circular(20),
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
                              width: containerSize * 2,
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
            ],
          );
        },
      ),
    );
  }
}
