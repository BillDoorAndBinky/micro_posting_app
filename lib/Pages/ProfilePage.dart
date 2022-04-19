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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User data:',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    const SizedBox(height: 16),
                    Column(
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.person),
                                  Text("User name:"),
                                  Text(
                                    "${user?.FirstName} ${user?.LastName}",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              } else
                return CircularProgressIndicator();
            }),
      ),
    );
  }
}
