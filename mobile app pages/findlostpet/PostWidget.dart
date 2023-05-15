import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marahsebaproject/MainPage.dart';
import 'package:marahsebaproject/findlostpet/comments.dart';
import 'package:marahsebaproject/findlostpet/progress.dart';
import 'package:marahsebaproject/findlostpet/storage_services.dart';
import 'package:marahsebaproject/loginsiginup/pages/widgets/sign_in.dart';
import 'package:marahsebaproject/models/user.dart';
import 'package:marahsebaproject/tabWidget/tabWidget/ProfileWidget.dart';


class PostWidget extends StatefulWidget {
  final String? postId;
  final String? ownerId;
  final String? username;
  final String? location;
  final String? description;
  final String? mediaUrl;
   final dynamic comments;
    Map? likes;

  PostWidget({
    this.postId,
    this.ownerId,
    this.username,
    this.location,
    this.description,
    this.mediaUrl,
    this.likes,
    this.comments
  });

  factory PostWidget.fromDocument(DocumentSnapshot doc) {
    return PostWidget(
      postId: doc['postId'],
      ownerId: doc['ownerid'],
      username: doc['username'],
      location: doc['location'],
      description: doc['description'],
      mediaUrl: doc['mediaUrl'],
      likes: doc['likes'],
      comments: doc['comments']
    );
  }

  int getLikeCount(likes) {
    // if no likes, return 0
    if (likes == null) {
      return 0;
    }
    int count = 0;
    // if the key is explicitly set to true, add a like
    likes.values.forEach((val) {
      if (val == true) {
        count += 1;
      }
    });
    return count;
  }

  @override
  // ignore: no_logic_in_create_state
  _PostState createState() => _PostState(
        postId: this.postId,
        ownerId: this.ownerId,
        username: this.username,
        location: this.location,
        description: this.description,
        mediaUrl: this.mediaUrl,
        likes: this.likes,
        likeCount: getLikeCount(this.likes),
      );
}

class _PostState extends State<PostWidget> {
  final String? currentUserId = currentUserFirebase.userId;
  final String? postId;
  final String? ownerId;
  final String? username;
  final String? location;
  final String? description;
  final String? mediaUrl;
  bool showHeart = false;
  bool isLiked = false;
  int? likeCount;
  Map? likes;

  _PostState({
    this.postId,
    this.ownerId,
    this.username,
    this.location,
    this.description,
    this.mediaUrl,
    this.likes,
    this.likeCount,
  });

  buildPostHeader() {
    return FutureBuilder(
      future: usersRef.doc(ownerId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        UserModel user = UserModel.fromDocument(snapshot.data!);
        bool isPostOwner = currentUserId == ownerId;
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage("assets/img/user.png"),
            backgroundColor: Colors.grey,
          ),
          title: GestureDetector(
            onTap: () => showProfile(
                context,
                ownerId: ownerId,
              ),
            child: Text(
              user.name!,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          subtitle: Text(location!),
          trailing: isPostOwner
              ? IconButton(
                  onPressed: () => handleDeletePost(context),
                  icon: Icon(Icons.more_vert),
                )
              : Text(''),
        );
      },
    );
  }

  handleDeletePost(BuildContext parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return AlertDialog(
            backgroundColor:Color.fromARGB(255, 255, 210, 225),
                  icon: Icon(FontAwesomeIcons.cat,color: Color(0xFF4F3268),),
            title: Text("Remove this post?"),
            actions: <Widget>[
              SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context);
                    deletePost();
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.black),
                  )),
              SimpleDialogOption(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel')),
            ],
          );
        });
  }

  // Note: To delete post, ownerId and currentUserId must be equal, so they can be used interchangeably
  deletePost() async {
    // delete post itself
      postsRef
        .doc(postId!.trim())
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });

          timelineRef
        .doc(postId!.trim())
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });

    updatePostCount();
    // delete uploaded image for thep ost
    storageRef.child("img_$postId.jpg").delete();
    // then delete all activity feed notifications
    QuerySnapshot activityFeedSnapshot = await activityFeedRef
        .doc(ownerId)
        .collection("feedItems")
        .where('postId', isEqualTo: postId)
        .get();
    activityFeedSnapshot.docs.forEach((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    // then delete all comments
    QuerySnapshot commentsSnapshot = await commentsRef
        .doc(postId)
        .collection('comments')
        .get();
    commentsSnapshot.docs.forEach((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
  }

    updatePostCount() async {
    final docRef = usersRef.doc(signedDocIdFirebase);
    try {
      await docRef.update({"postsCount": currentUserFirebase.postsCount! - 1});
    } catch (e) {
      print(e);
    }
  }

  handleLikePost() async {
       print("liked");
    isLiked = likes![currentUserId] == true;

    if (isLiked) {
      final QuerySnapshot snapshot =
          await postsRef.where("postId", isEqualTo: widget.postId).get();
      snapshot.docs.forEach((DocumentSnapshot doc) {
        doc.reference.update({'likes.$currentUserId': false});
      });

      final QuerySnapshot snapshot2 =
          await timelineRef.where("postId", isEqualTo: widget.postId).get();
      snapshot2.docs.forEach((DocumentSnapshot doc) {
        doc.reference.update({'likes.$currentUserId': false});
      });
      //removeLikeFromActivityFeed();
      setState(() {
        likeCount = likeCount! - 1;
        isLiked = false;
        likes![currentUserId] = false;
      });
    } else if (!isLiked) {
      final QuerySnapshot snapshot =
          await postsRef.where("postId", isEqualTo: widget.postId).get();
      snapshot.docs.forEach((DocumentSnapshot doc) {
        doc.reference.update({'likes.$currentUserId': true});
      });

      final QuerySnapshot snapshot2 =
          await timelineRef.where("postId", isEqualTo: widget.postId).get();
      snapshot2.docs.forEach((DocumentSnapshot doc) {
        doc.reference.update({'likes.$currentUserId': true});
      });

      addLikeToActivityFeed();
      setState(() {
        likeCount = likeCount! + 1;
        isLiked = true;
        likes![currentUserId] = true;
        //showHeart = true;
      });

      /*Timer(Duration(milliseconds: 700), () {
        setState(() {
          showHeart = false;
        });
      });*/
    }
  }

  addLikeToActivityFeed() {
    // add a notification to the postOwner's activity feed only if comment made by OTHER user (to avoid getting notification for our own like)
    //bool isNotPostOwner = currentUserId != ownerId;
    //if (isNotPostOwner) {
    activityFeedRef.doc(ownerId).collection("feedItem").add({
      "data": "",
      "mediaUrl": mediaUrl,
      "postId": postId,
      "type": "like",
      "userId": currentUserFirebase.userId,
      "username": currentUserFirebase.name,
    });
  }

  
  buildPostImage() {
    final Storage storage = Storage();
    return GestureDetector(
      onDoubleTap: () => handleLikePost,
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.width - 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 20,
                  offset: Offset(0, 10),
                )
              ],
            ),
            child: FutureBuilder(
              future: storage.downloadUrl(widget.mediaUrl!),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return Container(
                    child: Image.network(snapshot.data!, fit: BoxFit.cover),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting ||
                    !snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

 buildPostFooter() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 40.0, left: 20.0)),
            GestureDetector(
              onTap: handleLikePost,
              child: Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                size: 28.0,
                color: Colors.white,
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 20.0)),
            GestureDetector(
              onTap: () => showComments(
                context,
                postId: postId,
                ownerId: ownerId,
                mediaUrl: mediaUrl,
              ),
              child: Icon(
                Icons.chat,
                size: 28.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20.0),
              child: Text(
                "$likeCount likes",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20.0),
              child: Text(
                "$username ",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(child: Text(description!))
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    isLiked = (likes![currentUserId] == true);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        buildPostHeader(),
        buildPostImage(),
        buildPostFooter()
      ],
    );
  }
}

  showComments(BuildContext context,
      {String? postId, String? ownerId, String? mediaUrl}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Comments(
          postId: postId, postOwnerId: ownerId, postMediaUrl: mediaUrl);
    }));
  }

  showProfile(BuildContext context,
      {String? ownerId}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ProfileWidget(
          profileId: ownerId);
    }));
  }