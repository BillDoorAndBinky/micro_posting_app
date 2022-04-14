import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:micro_posting_app/Pages/LoginPage.dart';
import 'package:micro_posting_app/Services/StorageService.dart';

import '../main.dart';
import 'ProfilePage.dart';
import 'UserPostsPage.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  int _selectedIndex = 0;

  static List<Widget> pages = <Widget>[
    UserPostsPage(),
    Container(color: Colors.green),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Micro tip app"),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                  onTap: () {
                    StorageService().clearStorage();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: StorageService().jwtOrEmpty != ""
                      ? Icon(Icons.logout)
                      : Icon(Icons.login)))
        ],
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).textSelectionTheme.selectionColor,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: 'My tips',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: 'New tip',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
