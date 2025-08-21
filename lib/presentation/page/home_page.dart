import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dicoding_submission_flutter_fundamental/presentation/provider/restaurant_provider.dart';
import 'package:dicoding_submission_flutter_fundamental/presentation/provider/network_state.dart';
import 'package:dicoding_submission_flutter_fundamental/presentation/widget/list_tile_restaurant.dart';
import 'package:dicoding_submission_flutter_fundamental/data/model/restaurant_response.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<RestaurantProvider>().fetchRestaurants(),
    );
  }

  void _onSearch(String query) {
    if (query.isEmpty) {
      setState(() => _isSearching = false);
      context.read<RestaurantProvider>().fetchRestaurants();
    } else {
      setState(() => _isSearching = true);
      context.read<RestaurantProvider>().searchRestaurants(query);
    }
  }

  void _clearSearch() {
    _searchController.clear();
    _onSearch('');
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RestaurantProvider>();
    final NetworkState<RestaurantResponse> state;
    if (_isSearching) {
      state = provider.searchState;
    } else {
      state = provider.listState;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Restaurant, recommend for you')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchBar(
              controller: _searchController,
              hintText: 'Seacrg restaurant...',
              leading: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
              trailing: [
                if (_searchController.text.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => _clearSearch(),
                  ),
              ],
              onSubmitted: _onSearch,
              onChanged: (value) {
                if (value.isEmpty) {
                  _clearSearch();
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
                        onPressed: () => _onSearch(_searchController.text),
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
                          separatorBuilder: (context, index) =>
                              const Divider(height: 1),
                          itemBuilder: (context, index) => ListTileRestaurant(
                            dataResult: result.restaurants[index],
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
}
