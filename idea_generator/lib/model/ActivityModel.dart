
class Activity {
  final String activity;
  final String type;
  final String key;

  Activity({required this.activity, required this.type, required this.key});

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      activity: json['activity'] ?? 'Unknown Activity',
      type: json['type'] ?? 'general',
      key:
          json['key']?.toString() ??
          DateTime.now().millisecondsSinceEpoch.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'activity': activity,
    'type': type,
    'key': key,
  };
}