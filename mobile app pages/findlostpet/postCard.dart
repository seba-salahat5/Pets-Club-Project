import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:marahsebaproject/findlostpet/PostWidget.dart';
import 'package:marahsebaproject/findlostpet/header.dart';
import 'package:marahsebaproject/findlostpet/progress.dart';
import 'package:marahsebaproject/loginsiginup/pages/widgets/sign_in.dart';

class PostScreen extends StatelessWidget {
  final String? userId;
  final String? postId;

  PostScreen({this.userId, this.postId});
 
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:  postsRef.where("postId", isEqualTo: postId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
         PostWidget post = PostWidget.fromDocument(snapshot.data!.docs[0]);
        return Center(
          child: Scaffold(
            appBar: header(context, titleText: "Post  Page"),
            body: ListView(
              children: <Widget>[
                Container(
                  child: post,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}