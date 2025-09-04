import 'package:dicoding_submission_flutter_fundamental/constant/name_router.dart';
import 'package:dicoding_submission_flutter_fundamental/presentation/provider/bookmark_provider.dart';
import 'package:dicoding_submission_flutter_fundamental/presentation/widget/list_tile_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BookmarkProvider>();
    final bookmarks = provider.bookmarks;
    final isLoading = provider.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmark'),
        leading: IconButton(
          onPressed: () => context.go(HOME_PAGE_ROUTE),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : bookmarks.isEmpty
            ? const Center(child: Text('Belum ada restoran favorit.'))
            : ListView.separated(
                itemCount: bookmarks.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final restaurant = bookmarks[index];
                  return ListTileRestaurant(dataResult: restaurant);
                },
              ),
      ),
    );
  }
}
