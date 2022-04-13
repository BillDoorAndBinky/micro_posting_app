import 'package:flutter/material.dart';
import 'package:micro_posting_app/Services/StorageService.dart';

import 'Pages/HomePage.dart';
import 'Pages/LoginPage.dart';

const SERVER_IP = 'http://10.0.2.2:4000';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Micro Posts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
          future: StorageService().jwtIsValid,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == null) {
                return LoginPage();
              } else {
                return HomePage();
              }
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
