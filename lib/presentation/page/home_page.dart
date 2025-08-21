import 'package:dicoding_submission_flutter_fundamental/constant/name_router.dart';
import 'package:dicoding_submission_flutter_fundamental/data/api/api_service.dart';
import 'package:dicoding_submission_flutter_fundamental/data/model/restaurant_response.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<RestaurantResponse> _futureRestaurantResponse;

  @override
  void initState() {
    super.initState();
    _futureRestaurantResponse = ApiService().getRestaurantList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _futureRestaurantResponse,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              Future.delayed(Duration(seconds: 5));
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }
              final resultListRestaurant = snapshot.data!.restaurants;
              return ListView.separated(
                itemBuilder: (context, index) {
                  final dataResult = resultListRestaurant[index];
                  return ListTile(
                    leading: SizedBox(
                      width: 60,
                      height: 60,
                      child: Image.network(
                        'https://restaurant-api.dicoding.dev/images/small/${dataResult.pictureId}',
                      ),
                    ),
                    title: Text('${dataResult.name} | Kota ${dataResult.city}'),
                    subtitle: Text(
                      dataResult.description,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                    ),
                    trailing: Text(dataResult.rating.toString()),
                    onTap: () {
                      context.goNamed(DETAIL_PAGE_ROUTE, extra: dataResult);
                    },
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: resultListRestaurant.length,
              );
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
