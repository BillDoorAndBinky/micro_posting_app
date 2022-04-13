import 'package:flutter/material.dart';

import '../Services/CurrentUserService.dart';
import '../Services/RouterService.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
