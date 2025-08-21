import 'package:dicoding_submission_flutter_fundamental/data/model/restaurant.dart';
import 'package:flutter/material.dart';

class ListTileRestaurant extends StatelessWidget {
  const ListTileRestaurant({super.key, required this.dataRestaurant});

  final List<Restaurant> dataRestaurant;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final dataResult = dataRestaurant[index];
        return ListTile(
          title: Text(dataResult.name),
        );
      },
      separatorBuilder: (context, index) => Divider(),
      itemCount: dataRestaurant.length,
    );
  }
}
