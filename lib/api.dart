import 'dart:convert';
import 'package:projectinternship/HomePage.dart';
import 'package:projectinternship/notuesed/common_cjson.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class api extends StatefulWidget {
  const api({super.key});

  @override
  State<api> createState() => _apiState();
}

@override
State<api> createState() => _apiState();

class _apiState extends State<api> {
  List<dynamic> users = [];
  Future<void> fetchusers() async {
    const url = 'https://randomuser.me/api/?results=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      users = json['results'];
      saveData(body);
    });
  }

  Future<void> saveData(String body) async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
    shared.setString("body", body);
  }

  @override
  void initState() {
    ApiService.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(
          child: Text(
            "APIs     ",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30),
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey.shade200,
        child: ListView(
          children: [
            Text(
              textAlign: TextAlign.center,
              "Contact ME??",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 30),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.cyan),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(' Email'),
                      content: Text(
                          'Ishanneupane8945@gmail.com'), // Replace with your actual email
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          child: Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text(
                'Email',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.cyan),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Phone Number'),
                      content: Text(
                          '9861591772\n9803541895'), // Replace with your actual email
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          child: Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text(
                'Phone Number',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.cyan)),
              onPressed: () async {
                final SharedPreferences shared =
                    await SharedPreferences.getInstance();
                shared.remove("emailid");
                shared.remove("body");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ));
              },
              child: Text(
                'Log-Out',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Container(
              child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              final name = user['name'].toString();
              final email = user['email'];
              return ListTile(
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text(
                  name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height * .025),
                ),
                subtitle: Text(email),
                subtitleTextStyle: TextStyle(color: Colors.green),
              );
            },
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
          ))
        ],
      ),
    );
  }
}
