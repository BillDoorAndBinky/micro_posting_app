import 'package:flutter/material.dart';
import '../Models/UserPost.dart';

class UserPostTile extends StatelessWidget {
  final UserPost post;

  const UserPostTile({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.bookmark),
              Text(post.Title),
              Text(
                '${post.Text}',
                style: Theme.of(context).textTheme.bodyText1,
              )
            ],
          ),
        )
      ],
    );
  }
}
