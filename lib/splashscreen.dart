import 'package:flutter/material.dart';
import 'package:projectinternship/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api.dart';

var femail;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    getPrevData().whenComplete(() async {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => femail == null ? HomePage() : api()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // You can customize the splash screen UI here
      body: Center(
        child: Text(
          'Loading..',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }

  Future getPrevData() async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
    var prevemail = shared.getString("emailid");
    setState(() {
      femail = prevemail;
    });
    print(femail);
  }
}
