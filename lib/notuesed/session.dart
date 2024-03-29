import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static const String userKey = 'user';

  // Save data to SharedPreferences
  static Future<void> saveData(String key, String data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, data);
  }

  // Retrieve data from SharedPreferences
  static Future<String?> getData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  // Save user data
  static Future<void> saveUserData(User user) async {
    final jsonData = jsonEncode(user.toJson());
    await saveData(userKey, jsonData);
  }

  // Retrieve user data
  static Future<User?> getUserData() async {
    final jsonData = await getData(userKey);
    if (jsonData != null) {
      return User.fromJson(jsonDecode(jsonData));
    }
    return null;
  }
}

class User {
  final String gender;
  final Name name;

  User({
    required this.gender,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      gender: json['gender'],
      name: Name.fromJson(json['name']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gender': gender,
      'name': name.toJson(),
    };
  }
}

class Name {
  final String title;
  final String first;
  final String last;

  Name({
    required this.title,
    required this.first,
    required this.last,
  });

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      title: json['title'],
      first: json['first'],
      last: json['last'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'first': first,
      'last': last,
    };
  }
}
