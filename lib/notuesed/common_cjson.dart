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
      title: json['title'],
      body: json['body'],
      id: json['id'].toString(),
    );
  }
}

class ApiService {
  static final String apiUrl =
      'https://testing.esnep.com/eliterestro/api/acc/pub/slider';

  // Function to fetch data from the API and map it to the Name class
  static Future<List<Name>> fetchData() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // Parse the JSON data
      final List<dynamic> responseData = json.decode(response.body);
      print(responseData);
      // Map the API data to a list of Name instances
      List<Name> names =
          responseData.map((json) => Name.fromJson(json)).toList();

      return names;
    } else {
      // Handle the error
      print('Error fetching data: ${response.statusCode}');
      return [];
    }
  }
  //var headers = {'Content-Type': 'application/json/p0m76'};
}
