import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:micro_posting_app/Services/StorageService.dart';
import 'dart:convert' show json, base64, ascii;

import 'HomePage.dart';
import 'LoginPage.dart';

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
