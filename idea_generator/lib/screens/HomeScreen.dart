import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';
import '../ActivityProvider.dart';

import 'FavoriteScreen.dart';
import '../components/ActivityCard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ActivityProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Bored? Find Ideas!"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.red),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoritesScreen()),
              );
            },
          ),
        ],
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider
                .cards
                .isEmpty
          ? const Center(
              child: Text(
                "No activities loaded.\nCheck your internet.",
                textAlign: TextAlign.center,
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: CardSwiper(
                    cardsCount: provider.cards.length,
                    numberOfCardsDisplayed: provider.cards.length >= 3
                        ? 3
                        : provider.cards.length,
                    backCardOffset: const Offset(40, 40),
                    padding: const EdgeInsets.all(24.0),
                    onEnd: () async {
                      await provider.fetchActivitiesBatch();
                    },
                    onSwipe: (previousIndex, currentIndex, direction) {
                      if (direction == CardSwiperDirection.right) {
                        provider.likeActivity(previousIndex);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Saved to favorites!"),
                            duration: Duration(milliseconds: 800),
                          ),
                        );
                      }
                      return true;
                    },
                    cardBuilder:
                        (context, index, horizontalOffset, verticalOffset) {
                          if (index >= provider.cards.length) {
                            return const SizedBox();
                          }
                          final activity = provider.cards[index];
                          return ActivityCard(activity: activity);
                        },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 40.0),
                  child: Text(
                    "Swipe Right to Save →",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
