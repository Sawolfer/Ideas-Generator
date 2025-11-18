import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'model/ActivityModel.dart';

class ActivityProvider extends ChangeNotifier {
  List<Activity> _cards = [];
  List<Activity> _favorites = [];
  bool isLoading = true;

  List<Activity> get cards => _cards;
  List<Activity> get favorites => _favorites;

  final List<Activity> _fallbackActivities = [
    Activity(
      activity: "Learn a new card trick",
      type: "recreational",
      key: "fb1",
    ),
    Activity(activity: "Go stargazing", type: "relaxation", key: "fb2"),
    Activity(
      activity: "Learn to code in a new language",
      type: "education",
      key: "fb3",
    ),
    Activity(activity: "Bake a new recipe", type: "cooking", key: "fb4"),
    Activity(activity: "Organize your closet", type: "busywork", key: "fb5"),
    Activity(activity: "Call an old friend", type: "social", key: "fb6"),
    Activity(activity: "Start a garden", type: "diy", key: "fb7"),
    Activity(
      activity: "Meditate for 15 minutes",
      type: "relaxation",
      key: "fb8",
    ),
    Activity(activity: "Learn origami", type: "diy", key: "fb9"),
    Activity(
      activity: "Volunteer at a local shelter",
      type: "charity",
      key: "fb10",
    ),
  ];

  ActivityProvider() {
    _init();
  }

  Future<void> _init() async {
    await _loadFavorites();
    await fetchActivitiesBatch();
  }

  Future<void> fetchActivitiesBatch() async {
    int successfulFetches = 0;

    try {
      for (int i = 0; i < 5; i++) {
        try {
          final response = await http
              .get(Uri.parse('https://bored-api.appbrewery.com/random'))
              .timeout(const Duration(seconds: 3)); 

          if (response.statusCode == 200) {
            final newActivity = Activity.fromJson(json.decode(response.body));
            if (!_cards.any((card) => card.key == newActivity.key)) {
              _cards.add(newActivity);
              successfulFetches++;
            }
          }
        } catch (e) {
          debugPrint("Single fetch failed: $e");
        }
      }
    } catch (e) {
      debugPrint("Batch fetch error: $e");
    }

    if (_cards.length < 3) {
      debugPrint("Using fallback activities (API unstable)");
      _addFallbackActivities(5 - _cards.length);
    }

    isLoading = false;
    notifyListeners();
  }

  void _addFallbackActivities(int count) {
    final available = _fallbackActivities
        .where((fallback) => !_cards.any((card) => card.key == fallback.key))
        .toList();

    for (int i = 0; i < count && i < available.length; i++) {
      _cards.add(available[i]);
    }
  }

  void likeActivity(int index) {
    if (index < _cards.length) {
      final item = _cards[index];
      if (!_favorites.any((element) => element.key == item.key)) {
        _favorites.add(item);
        _saveFavorites();
        notifyListeners();
      }
    }
  }

  void removeFavorite(Activity item) {
    _favorites.removeWhere((element) => element.key == item.key);
    _saveFavorites();
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String encoded = json.encode(
        _favorites.map((e) => e.toJson()).toList(),
      );
      await prefs.setString('favorites', encoded);
    } catch (e) {
      debugPrint("Error saving favorites: $e");
    }
  }

  Future<void> _loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? encoded = prefs.getString('favorites');
      if (encoded != null) {
        final List<dynamic> decoded = json.decode(encoded);
        _favorites = decoded.map((e) => Activity.fromJson(e)).toList();
      }
    } catch (e) {
      debugPrint("Error loading favorites: $e");
    }
    notifyListeners();
  }
}
