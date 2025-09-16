import 'package:dicoding_submission_flutter_fundamental/constant/name_router.dart';
import 'package:dicoding_submission_flutter_fundamental/data/model/restaurant_response.dart';
import 'package:dicoding_submission_flutter_fundamental/constant/network_state.dart';
import 'package:dicoding_submission_flutter_fundamental/presentation/provider/restaurant_provider.dart';
import 'package:dicoding_submission_flutter_fundamental/presentation/widget/list_tile_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  void _onSearch(BuildContext context, String query) {
    final provider = context.read<RestaurantProvider>();
    if (query.isEmpty) {
      provider.setSearching(false);
      provider.fetchRestaurants();
    } else {
      provider.setSearching(true);
      provider.searchRestaurants(query);
    }
  }

  void _clearSearch(BuildContext context) {
    _searchController.clear();
    _onSearch(context, '');
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.read<RestaurantProvider>().fetchRestaurants(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RestaurantProvider>();
    final state = provider.isSearching
        ? provider.searchState
        : provider.listState;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant, recommend for you'),
        actions: [
          IconButton(
            onPressed: () => context.go(bookmarkPageRoute),
            icon: Icon(Icons.bookmark),
          ),
          IconButton(
            onPressed: () => context.go(settingPageRoute),
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchBar(
              controller: _searchController,
              hintText: 'Search restaurant...',
              leading: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => _onSearch(context, _searchController.text),
              ),
              trailing: [
                if (_searchController.text.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => _clearSearch(context),
                  ),
              ],
              onSubmitted: (value) => _onSearch(context, value),
              onChanged: (value) {
                if (value.isEmpty) {
                  _clearSearch(context);
                }
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: switch (state) {
                Loading<RestaurantResponse>() => const Center(
                  child: CircularProgressIndicator(),
                ),
                Failure<RestaurantResponse>(message: final message) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(message),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () =>
                            _onSearch(context, _searchController.text),
                        child: const Text('Try again'),
                      ),
                    ],
                  ),
                ),
                Success<RestaurantResponse>(data: final result) =>
                  result.restaurants.isEmpty
                      ? const Center(
                          child: Text('Tidak ada restoran ditemukan.'),
                        )
                      : ListView.separated(
                          itemCount: result.restaurants.length,
                          separatorBuilder: (_, _) => const Divider(height: 1),
                          itemBuilder: (context, index) => ListTileRestaurant(
                            dataResult: result.restaurants[index],
                            route: detailPageRoute,
                          ),
                        ),
                _ => const SizedBox.shrink(),
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
