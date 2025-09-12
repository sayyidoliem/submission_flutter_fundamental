import 'package:dicoding_submission_flutter_fundamental/data/model/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ListTileRestaurant extends StatelessWidget {
  const ListTileRestaurant({
    super.key,
    required this.dataResult,
    required this.route,
  });

  final Restaurant dataResult;
  final String route;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: 60,
        height: 60,
        child: Image.network(
          'https://restaurant-api.dicoding.dev/images/small/${dataResult.pictureId}',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.broken_image_outlined),
        ),
      ),
      title: Text(
        '${dataResult.name} | Kota ${dataResult.city}',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      subtitle: Text(
        dataResult.description,
        maxLines: 1,
        overflow: TextOverflow.clip,
      ),
      trailing: Text(dataResult.rating.toString()),
      onTap: () {
        context.goNamed(route, pathParameters: {'id': dataResult.id});
      },
    );
  }
}
