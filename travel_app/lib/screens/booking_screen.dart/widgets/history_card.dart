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
                  Icons.location_searching_rounded,
                ),
                const SizedBox(
                    width: 8.0), // Add spacing between the icon and text
                Expanded(
                  child: Text(
                    startLine,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 14.0), // Optional: Adjust the text style
                  ),
                ),
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
                const SizedBox(
                    width: 8.0), // Add spacing between the icon and text
                Expanded(
                  child: Text(
                    destination,
                    overflow: TextOverflow.ellipsis,
                    style:const  TextStyle(
                        fontSize: 14.0), // Optional: Adjust the text style
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.timer),
                const SizedBox(width: 5),
                Text(time),
                const SizedBox(width: 20),
                const Icon(Icons.roundabout_left),
                const SizedBox(width: 5),
                Text(distance),
              ],
            )
          ],
        ),
      ),
    );
  }
}
