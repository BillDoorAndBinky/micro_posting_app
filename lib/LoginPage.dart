import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert' show ascii, base64, json, jsonDecode, jsonEncode;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:micro_posting_app/Services/RouterService.dart';

import 'HomePage.dart';
import 'Services/StorageService.dart';
import 'main.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  Future<String?> attemptLogIn(String username, String password) async {
    var res = await http.post(Uri.parse("$SERVER_IP/Users/token/"),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({"login": username, "password": password}));
    if (res.statusCode == 200) {
      Map<String, dynamic> jwt_resp = jsonDecode(res.body);
      return jwt_resp['token'];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Log In"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              FlatButton(
                  onPressed: () async {
                    var username = _usernameController.text;
                    var password = _passwordController.text;
                    var jwt =
                        await RouterService().attemptLogIn(username, password);
                    if (jwt != null) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    } else {
                      displayDialog(context, "An Error Occurred",
                          "No account was found matching that username and password");
                    }
                  },
                  child: Text("Log In")),
              FlatButton(
                  onPressed: () async {
                    //TODO: SignUp API
                    displayDialog(context, "Development in progress",
                        "This feature in development");
                  },
                  child: Text("Sign Up"))
            ],
          ),
        ));
  }
}
