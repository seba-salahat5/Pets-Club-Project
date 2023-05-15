import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marahsebaproject/MainPage.dart';
import 'package:marahsebaproject/findlostpet/progress.dart';
import 'package:marahsebaproject/loginsiginup/pages/widgets/sign_in.dart';
import 'package:marahsebaproject/utils/CustomWidget.dart';
import 'package:marahsebaproject/utils/constants.dart';

class Comments extends StatefulWidget {
  final String? postId;
  final String? postOwnerId;
  final String? postMediaUrl;
  final Function? function;

  Comments({
    this.postId,
    this.postOwnerId,
    this.postMediaUrl,
    this.function,
  });

  @override
  CommentsState createState() => CommentsState(
        postId: this.postId,
        postOwnerId: this.postOwnerId,
        postMediaUrl: this.postMediaUrl,
        function: this.function,
      );
}

class CommentsState extends State<Comments> {
  TextEditingController commentController = TextEditingController();

  final String? postId;
  final String? postOwnerId;
  final String? postMediaUrl;
  final Function? function;

  CommentsState({
    this.postId,
    this.postOwnerId,
    this.postMediaUrl,
    this.function,
  });

  Future<bool> _requestPop() {
    if (widget.function != null) {
      widget.function!();
    } else {
      Navigator.of(context).pop();
    }

    return new Future.value(true);
  }

  buildComments() {
    return StreamBuilder(
        stream: commentsRef.doc(postId).collection('comments').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return circularProgress();
          }
          List<Comment> comments = [];
          snapshot.data!.docs.forEach((doc) {
            comments.add(Comment.fromDocument(doc));
          });
          return ListView(
            children: comments,
          );
        });
  }

  addComment() {
    //print(currentUser);
    //print("///////");
    //print(currentUser.id);

    commentsRef.doc(postId).collection("comments").add({
      "username": currentUserFirebase.name,
      "comment": commentController.text,
      //"avatarUrl": AssetImage(assetsPath + 'avatar.png'),
      "userId": currentUserFirebase.userId,
    });
    //bool isNotPostOwner = postOwnerId != currentUser.id;
    //if (isNotPostOwner) {
    activityFeedRef.doc(postOwnerId).collection('feedItem').add({
      "type": "comment",
      "data": commentController.text,
      "postId": postId,
      "userId": currentUserFirebase.userId,
      "username": currentUserFirebase.name,
      //"userProfileImg":currentUser.photoUrl,
      "mediaUrl": postMediaUrl,
    });
    //}

    commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    double height = getScreenPercentSize(context, 3);
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: SafeArea(
        child: Column(
          children: [
            _top(),
            Expanded(child: buildComments()),
            Divider(),
            ListTile(
              title: TextFormField(
                controller: commentController,
                decoration: InputDecoration(labelText: "Write a comment..."),
              ),
              trailing: ElevatedButton(
                onPressed: addComment,
                child: Text("Post"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: const StadiumBorder(),
                  primary: Color(0xFF4F3268),
                  elevation: 8,
                  shadowColor: Colors.black87,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _top() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getAppBar(
            context,
            "Comments",
            isBack: true,
            function: () {
              _requestPop();
            },
          ),
        ],
      ),
    );
  }
}

class Comment extends StatelessWidget {
  final String? username;
  final String? userId;
  //final String? avatarUrl;
  final String? comment;

  Comment(
      {this.username,
      this.userId,
      //this.avatarUrl,
      this.comment});

  factory Comment.fromDocument(DocumentSnapshot doc) {
    return Comment(
      username: doc['username'],
      userId: doc['userId'],
      //avatarUrl: doc['avatarUrl'],
      comment: doc['comment'],
    );
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /*Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ChatScreen(imageURL: avatar, username: name),
          ),
        );*/
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: 100,
        decoration: BoxDecoration(color: Color.fromARGB(255, 186, 166, 202), boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 68, 78, 76),
            offset: const Offset(
              5.0,
              5.0,
            ),
            blurRadius: 10.0,
            spreadRadius: 2.5,
          ),
        ]),
        child: Row(
          children: [
            Avatar(
              margin: EdgeInsets.only(left: 20, right: 20),
              size: 60,
              image: 'assets/img/user.png',
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '$username',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '$comment',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Avatar extends StatelessWidget {
  final double size;
  final image;
  final EdgeInsets margin;
  Avatar({this.image, this.size = 50, this.margin = const EdgeInsets.all(0)});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Container(
        width: size,
        height: size,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
            image: AssetImage(image),
          ),
        ),
      ),
    );
  }
}
