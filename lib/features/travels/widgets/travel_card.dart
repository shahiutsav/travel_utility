import 'package:flutter/material.dart';
import 'package:travel_utility/common/models/travel_data/entry.dart';

class TravelCard extends StatelessWidget {
  const TravelCard({
    super.key,
    required this.dayString,
    required this.monthName,
    required this.entry,
  });

  final String dayString;
  final String monthName;
  final Entry entry;

  @override
  Widget build(BuildContext context) {
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
