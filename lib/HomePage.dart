import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:projectinternship/api.dart';

final formkey = GlobalKey<FormState>();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController username = TextEditingController();
  TextEditingController emailid = TextEditingController();
  TextEditingController number = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue.shade900,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.waving_hand,
                color: Colors.yellow,
              ),
              Text(
                "HELLO!!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              Icon(
                Icons.waving_hand,
                color: Colors.yellow,
              ),
            ],
          )),
      body: Container(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              TextFormField(
                controller: username,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'FullName',
                  labelText: 'Name *',
                ),
                validator: (fullname) {
                  if (!RegExp(r'^[a-z A-Z]+$').hasMatch(fullname!)) {
                    return 'Do not use the random char.';
                  } else if (fullname.length < 3) {
                    return 'tooo short';
                  }
                  {
                    return null;
                  }
                },
              ),
              TextFormField(
                  controller: emailid,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    hintText: 'Abc@gmail.com',
                    labelText: 'Email Address *',
                  ),
                  validator: (ea) {
                    if (ea != null &&
                        !RegExp(r'^[\w\.-]+@([\w-]+\.[\w])').hasMatch(ea!)) {
                      return 'must have @ and . char.';
                    }
                    {
                      return null;
                    }
                  }),
              TextFormField(
                  controller: number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.phone_android),
                    hintText: '987654321',
                    labelText: 'Number *',
                  ),
                  validator: (n) {
                    if (n != null && n.length != 10) {
                      return 'must be 10digit';
                    }
                    {
                      return null;
                    }
                  }),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () async {
                  final SharedPreferences shared =
                      await SharedPreferences.getInstance();
                  shared.setString("emailid", emailid.text);
                  if (formkey.currentState!.validate()) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => api(),
                        ));
                  }
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> submitdata() async {
    final n = number.text;
    final ea = emailid.text;
    final fullname = username.text;
    final body = {
      "title": fullname,
      "email": ea,
      "userId": n,
    };
    final url = 'https://jsonplaceholder.typicode.com/posts';
    final uri = Uri.parse(url);

    final response = await http.post(uri, body: jsonEncode(body));
  }
}
