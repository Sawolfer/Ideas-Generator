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
