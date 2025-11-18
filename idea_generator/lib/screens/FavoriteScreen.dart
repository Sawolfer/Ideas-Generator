import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';
import '../ActivityProvider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ActivityProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("My Favorites")),
      body: provider.favorites.isEmpty
          ? const Center(
              child: Text(
                "No favorites yet.\nGo swipe some ideas!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: provider.favorites.length,
              itemBuilder: (context, index) {
                final item = provider.favorites[index];
                return Dismissible(
                  key: Key(item.key),
                  direction: DismissDirection.endToStart,
                  onDismissed: (_) => provider.removeFavorite(item),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepPurple[100],
                      child: const Icon(Icons.star, color: Colors.deepPurple),
                    ),
                    title: Text(item.activity),
                    subtitle: Text(item.type),
                  ),
                );
              },
            ),
    );
  }
}
