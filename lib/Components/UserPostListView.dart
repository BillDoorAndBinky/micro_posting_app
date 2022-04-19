import 'package:flutter/material.dart';
import 'package:micro_posting_app/Components/UserPostTile.dart';

import '../Models/UserPost.dart';

class UserPostListView extends StatelessWidget {
  final List<UserPost> usersPosts;

  const UserPostListView({
    Key? key,
    required this.usersPosts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My posts:',
            style: Theme.of(context).textTheme.headline3,
          ),
          const SizedBox(height: 16),
          ListView.separated(
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: usersPosts.length,
            itemBuilder: (context, index) {
              final post = usersPosts[index];
              return UserPostTile(post: post);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 16);
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
