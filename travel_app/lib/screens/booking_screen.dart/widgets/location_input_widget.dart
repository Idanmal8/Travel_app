import 'package:flutter/material.dart';

class LocationInputWidget extends StatelessWidget {
  const LocationInputWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64.0),
        child: Card(
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.search_rounded),
                            SizedBox(width: 40),
                            Text('from where?'),
                          ],
                        ),
                        SizedBox(height: 10),
                        Divider(),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.location_on),
                            SizedBox(width: 40),
                            Text('Where to?'),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    color: // use rgb to set color
                        const Color.fromRGBO(4, 121, 94, 1),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.swap_vert_rounded,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}