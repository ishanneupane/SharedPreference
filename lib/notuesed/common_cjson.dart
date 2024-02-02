import 'dart:convert';
import 'package:http/http.dart' as http;

class Name {
  final String title;
  final String body;
  final String id;

  Name({
    required this.title,
    required this.body,
    required this.id,
  });

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      title: json['name']['title'],
      body: json['name']['body'],
      id: json['id']['value'].toString(),
    );
  }
}

class ApiService {
  static final String apiUrl = 'ur apii';

  static Future<List<Name>> fetchData() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> results = responseData['results'];

      // Map the API data to a list of Name instances
      List<Name> names = results.map((json) => Name.fromJson(json)).toList();

      return names;
    } else {
      // Handle the error
      print('Error fetching data: ${response.statusCode}');
      return [];
    }
  }
}
