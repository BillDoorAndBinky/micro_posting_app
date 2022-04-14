import 'package:flutter/material.dart';

import '../Services/CurrentUserService.dart';
import '../Services/RouterService.dart';

class UserPostsPage extends StatefulWidget {
  @override
  _UserPostsPageState createState() => _UserPostsPageState();
}

class _UserPostsPageState extends State<UserPostsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: FutureBuilder(
            future: RouterService().GetCurrentUserPosts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                /*return Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Notifications',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ],
                    ),
                  ],
                );*/
                var widgets = (snapshot.data as Iterable?)!
                    .map((post) => Row(children: <Widget>[
                          Text("${post["title"]}:",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                          Text("${post["text"]}",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15))
                        ]))
                    .toList();
                return Column(children: widgets);
                return Text("dsad");
              } else
                return CircularProgressIndicator();
            }),
      ),
    );
  }
}
