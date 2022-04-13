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
                return Center(
                    child: Text((snapshot.data
                        as List<Map<String, dynamic>>?)![0]["Title"]));
              } else
                return CircularProgressIndicator();
            }),
      ),
    );
  }
}
