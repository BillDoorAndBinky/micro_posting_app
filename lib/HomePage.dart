import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:micro_posting_app/LoginPage.dart';
import 'package:micro_posting_app/Services/CurrentUserService.dart';
import 'package:micro_posting_app/Services/RouterService.dart';

import 'main.dart';

class HomePage extends StatefulWidget {
  HomePage(this.jwt, this.payload);

  factory HomePage.fromBase64(String jwt) => HomePage(
      jwt,
      json.decode(
          ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1])))));

  final String jwt;
  final Map<String, dynamic> payload;

  @override
  State<StatefulWidget> createState() {
    return _HomePageState(jwt, payload);
  }
}

class _HomePageState extends State<HomePage> {
  String jwt;
  Map<String, dynamic> payload;

  @override
  void initState() {
    super.initState();
  }

  final CurrentUserService _currentUserService = CurrentUserService();
  final RouterService _routerService = RouterService();

  Text getMainPage() {
    return Text("Hi, ${_currentUserService.CurrentUser?.UserName}!");
  }

  _HomePageState(this.jwt, this.payload);

  Future<bool> isAuth() async{
    return jwt != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Secret Data Screen"),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                  onTap: () {
                    storage.deleteAll();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyApp()));
                  },
                  child: jwt != "" ? Icon(Icons.logout) : Icon(Icons.login)))
        ],
      ),
      body: Center(
        child: FutureBuilder(
            future: isAuth(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                _routerService.GetUserDataToCurrentUserService(jwt);
                return Column(
                  children: <Widget>[
                    getMainPage(),
                  ],
                );
              } else
                return CircularProgressIndicator();
            }),
      ),
    );
  }
}
