import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';
import 'logic.dart'; 

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ActivityProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const HomeScreen(),
    );
  }
}

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
              // will open fav screen
            },
          )
        ],
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: CardSwiper(
                    cardsCount: provider.cards.length,
                    numberOfCardsDisplayed: 3,
                    backCardOffset: const Offset(40, 40),
                    padding: const EdgeInsets.all(24.0),
                    onEnd: () async {
                      await provider.fetchActivitiesBatch();
                    },
                    onSwipe: (previousIndex, currentIndex, direction) {
                      if (direction == CardSwiperDirection.right) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Saved to favorites!"), duration: Duration(milliseconds: 500)),
                        );
                      }
                      return true;
                    },
                    cardBuilder: (context, index, horizontalOffset, verticalOffset) {
                      final activity = provider.cards[index];
                      return ActivityCard(activity: activity);
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 40.0),
                  child: Text(
                    "Swipe Right to Save →",
                    style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
    );
  }
}

class ActivityCard extends StatelessWidget {
  final Activity activity;
  const ActivityCard({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Иконка типа активности
              Icon(
                _getIconForType(activity.type),
                size: 80,
                color: Colors.white.withOpacity(0.9),
              ),
              const SizedBox(height: 20),
              Text(
                activity.activity,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Chip(
                label: Text(activity.type.toUpperCase()),
                backgroundColor: Colors.white.withOpacity(0.2),
                labelStyle: const TextStyle(color: Colors.white),
                side: BorderSide.none,
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'education': return Icons.school;
      case 'recreational': return Icons.sports_esports;
      case 'social': return Icons.people;
      case 'diy': return Icons.build;
      case 'charity': return Icons.volunteer_activism;
      case 'cooking': return Icons.restaurant;
      case 'relaxation': return Icons.spa;
      case 'music': return Icons.music_note;
      case 'busywork': return Icons.work;
      default: return Icons.lightbulb;
    }
  }
}