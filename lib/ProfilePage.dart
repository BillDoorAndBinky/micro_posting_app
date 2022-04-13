import 'package:flutter/material.dart';

import 'Services/CurrentUserService.dart';
import 'Services/RouterService.dart';

class ProfilePage extends StatefulWidget {
  final String authorName;
  final String title;
  final ImageProvider? imageProvider;

  const ProfilePage({
    Key? key,
    required this.authorName,
    required this.title,
    this.imageProvider,
  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: FutureBuilder(
            future: RouterService().GetUserDataToCurrentUserService(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var user = CurrentUserService().CurrentUser;
                return Column(
                  children: <Widget>[
                    Text("Hi! ${user?.UserName}  "),
                  ],
                );
              } else
                return CircularProgressIndicator();
            }),
      ),
    );
  }
}
