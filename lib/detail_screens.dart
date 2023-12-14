import 'package:flutter/material.dart';

class DetailScreens extends StatefulWidget {
  const DetailScreens({super.key});

  @override
  State<DetailScreens> createState() => _DetailScreensState();
}

class _DetailScreensState extends State<DetailScreens> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          "Restaurant 1",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Icon(Icons.place),
            Padding(padding: EdgeInsets.only(left: 8.0)),
            Text("Place")
          ],
        ),
        Text("tile desc")
      ],
    );
  }
}
