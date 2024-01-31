import 'package:submission_flutter_fundamental/import.dart';

class ListTileHomeRestaurant extends StatelessWidget {
  const ListTileHomeRestaurant({
    super.key,
    required this.homeData,
  });

  final List<RestaurantElement> homeData;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final homeResult = homeData[index];
        return ListTile(
          title: Text(
            homeResult.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: Image.network(
            homeResult.pictureId,
            width: 80,
          ),
          trailing: const FavoriteButton(),
          subtitle: Row(
            children: [
              const Icon(Icons.place),
              const SizedBox(
                width: 5,
              ),
              Text(homeResult.city),
            ],
          ),
          onTap: () {
            Navigator.pushNamed(context, RoutesName.detail,
                arguments: {'id': index});
          },
        );
      },
      itemCount: homeData.length,
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}