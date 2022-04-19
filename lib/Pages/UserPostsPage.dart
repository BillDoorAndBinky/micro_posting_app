import 'package:flutter/material.dart';
import 'package:micro_posting_app/Models/UserPost.dart';

import '../Components/UserPostListView.dart';
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
                    var usersPosts = (snapshot.data as Iterable?)!
                        .map((post) => UserPost(post["title"], post["text"]))
                        .toList();

                    return ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        const SizedBox(height: 16),
                        UserPostListView(
                          usersPosts: usersPosts ?? [],
                        )
                      ],
                    );
                  } else
                    return CircularProgressIndicator();
                })));
  }
}
