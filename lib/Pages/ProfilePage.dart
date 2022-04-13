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
                return Center(
                    child: Column(
                  children: <Widget>[Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "User Profile:",
                            style: TextStyle(
                              fontSize: 20,
                              height: 2.0,
                            ),
                          ))),
                    Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "User name: ${user?.UserName}",
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.4,
                              ),
                            ))),
                    Padding(
                        padding: EdgeInsets.fromLTRB(10,10, 10, 10),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "${user?.FirstName} ${user?.LastName}",
                              style: TextStyle(
                                fontSize: 12,
                                height: 1.0,
                              ),
                            )))
                  ],
                ));
              } else
                return CircularProgressIndicator();
            }),
      ),
    );
  }
}
