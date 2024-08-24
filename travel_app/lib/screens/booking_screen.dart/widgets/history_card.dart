import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';

class HistoryCard extends StatelessWidget {
  final String startLine;
  final String destination;
  final String time;
  final String distance;

  const HistoryCard({
    required this.startLine,
    required this.destination,
    required this.time,
    required this.distance,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                ),
                Text(startLine)
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: Dash(
                direction: Axis.vertical,
                length: 15,
                dashLength: 2,
                dashColor: Colors.black,
              ),
            ),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                ),
                Text(destination),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(Icons.timer),
                SizedBox(width: 5),
                Text('10 min.'),
                SizedBox(width: 20),
                Icon(Icons.roundabout_left),
                SizedBox(width: 5),
                Text('10 km.'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
