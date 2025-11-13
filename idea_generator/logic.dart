import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Activity {
  final String activity;
  final String type;
  final String key;

  Activity({required this.activity, required this.type, required this.key});

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      activity: json['activity'] ?? 'Unknown Activity',
      type: json['type'] ?? 'General',
      key: json['key'] ?? DateTime.now().toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'activity': activity,
    'type': type,
    'key': key,
  };
}

class ActivityProvider extends ChangeNotifier {
  List<Activity> _cards = [];
  bool isLoading = true;

  List<Activity> get cards => _cards;

  ActivityProvider() {
    _init();
  }

  Future<void> _init() async {
    await fetchActivitiesBatch();
  }

  Future<void> fetchActivitiesBatch() async {
    try {
      for (int i = 0; i < 5; i++) {
        final response = await http.get(
          Uri.parse('https://bored-api.appbrewery.com/random'),
        );
        if (response.statusCode == 200) {
          _cards.add(Activity.fromJson(json.decode(response.body)));
        }
      }
    } catch (e) {
      print("Error fetching: $e");
      _cards.add(
        Activity(
          activity: "Check your internet connection",
          type: "System",
          key: "err",
        ),
      );
    }
    isLoading = false;
    notifyListeners();
  }
}
