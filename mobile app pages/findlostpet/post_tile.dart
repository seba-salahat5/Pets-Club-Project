import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marahsebaproject/findlostpet/PostWidget.dart';
import 'package:marahsebaproject/findlostpet/custom_image.dart';
import 'package:marahsebaproject/findlostpet/postCard.dart';
import 'package:marahsebaproject/findlostpet/storage_services.dart';
import 'package:marahsebaproject/utils/constants.dart';

class PostTile extends StatelessWidget {
  final PostWidget post;
  final Storage storage = Storage();
  PostTile(this.post);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostScreen(
                    postId: post.postId,
                    userId: post.ownerId,
                  ),
                ),
              );
        },
        child: FutureBuilder(
          future: storage.downloadUrl(post.mediaUrl!),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return Container(
                width: 100,
                height: 100,
                child: Image.network(snapshot.data!, fit: BoxFit.cover),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting ||
                !snapshot.hasData) {
              return CircularProgressIndicator();
            }
            return Container();
          },
        ));
  }
}
