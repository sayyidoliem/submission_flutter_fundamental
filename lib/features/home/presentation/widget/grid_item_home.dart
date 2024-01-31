import 'package:submission_flutter_fundamental/import.dart';

class GridViewHomeRestaurant extends StatelessWidget {
  const GridViewHomeRestaurant({
    super.key,
    required this.homeData,
    required this.crossAxisCount,
  });

  final List<RestaurantElement> homeData;
  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount),
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
    );
  }
}
