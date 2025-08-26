import 'package:dicoding_submission_flutter_fundamental/constant/name_router.dart';
import 'package:dicoding_submission_flutter_fundamental/data/model/restaurant.dart';
import 'package:dicoding_submission_flutter_fundamental/data/model/restaurant_response.dart';
import 'package:dicoding_submission_flutter_fundamental/presentation/provider/network_state.dart';
import 'package:dicoding_submission_flutter_fundamental/presentation/provider/restaurant_provider.dart';
import 'package:dicoding_submission_flutter_fundamental/presentation/widget/card_menu_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final String id;
  const DetailPage({super.key, required this.id});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) =>
          context.read<RestaurantProvider>().fetchRestaurantDetail(widget.id),
    );
  }

  void _retry() {
    context.read<RestaurantProvider>().fetchRestaurantDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final NetworkState<RestaurantResponse> state = context
        .watch<RestaurantProvider>()
        .detailState;
    return switch (state) {
      Loading<RestaurantResponse>() => const Center(
        child: CircularProgressIndicator(),
      ),
      Failure<RestaurantResponse>(message: final message) => Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 12),
              ElevatedButton(onPressed: _retry, child: const Text('try again')),
            ],
          ),
        ),
      ),
      Success<RestaurantResponse>(data: final result) => () {
        Restaurant? data;
        final list = result.restaurants;
        if (list.isNotEmpty) {
          try {
            data = list.firstWhere((e) => e.id == widget.id);
          } catch (e) {
            data = list.first;
          }
        }
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => context.go(HOME_PAGE_ROUTE),
              icon: const Icon(Icons.arrow_back),
            ),
            title: Text(data?.name ?? 'Detail Restaurant'),
          ),
          body: data == null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Data restautart not avaible.',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: _retry,
                          child: const Text('Refresh'),
                        ),
                      ],
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        'https://restaurant-api.dicoding.dev/images/large/${data.pictureId}',
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const SizedBox(
                              height: 220,
                              child: Center(
                                child: Icon(Icons.broken_image, size: 40),
                              ),
                            ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.name,
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  data.city,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: Colors.grey),
                                ),
                              ],
                            ),
                            if (data.address != null &&
                                data.address!.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.home,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      data.address!,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  data.rating.toString(),
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              data.description,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.favorite_outline),
                                  const SizedBox(width: 5),
                                  Text('Favorite this restaurant'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      MenusSection(menus: data.menus),
                    ],
                  ),
                ),
        );
      }(),
      _ => const SizedBox.shrink(),
    };
  }
}
