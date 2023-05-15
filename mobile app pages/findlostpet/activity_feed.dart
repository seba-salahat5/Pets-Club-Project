import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:marahsebaproject/MainPage.dart';
import 'package:marahsebaproject/findlostpet/PostWidget.dart';
import 'package:marahsebaproject/findlostpet/chat.dart';
import 'package:marahsebaproject/findlostpet/postCard.dart';
import 'package:marahsebaproject/findlostpet/progress.dart';
import 'package:marahsebaproject/findlostpet/storage_services.dart';
import 'package:marahsebaproject/loginsiginup/pages/widgets/sign_in.dart';
import 'package:marahsebaproject/models/user.dart';
import 'package:marahsebaproject/utils/CustomWidget.dart';
import 'package:marahsebaproject/utils/SizeConfig.dart';

import '../utils/constants.dart';

class ActivityFeed extends StatefulWidget {
  final Function? function;
  ActivityFeed({this.function});
  @override
  _ActivityFeedState createState() =>
      _ActivityFeedState(function: this.function);
}

class _ActivityFeedState extends State<ActivityFeed> {
  bool thereisNotification = false;
  List<ActivityFeedItem> notificationList = [];
   List<ActivityFeedItem> notificationListMsg = [];
  final Function? function;
  _ActivityFeedState({this.function});

  Future<bool> _requestPop() {
    if (widget.function != null) {
      widget.function!();
    } else {
      Navigator.of(context).pop();
    }

    return new Future.value(true);
  }

  getActivityFeed() async {
    //print(currentUserFirebase.userId);
    QuerySnapshot snapshot = await activityFeedRef
        .doc(currentUserFirebase.userId!)
        .collection('feedItem')
        .limit(50)
        .get();

    List<ActivityFeedItem> feedItems =
        snapshot.docs.map((doc) => ActivityFeedItem.fromDocument(doc)).toList();

     QuerySnapshot snapshot1 = await activityFeedRef
        .doc(currentUserFirebase.userId!.trim())
        .collection('feedItemMessage')
        .limit(50)
        .get();    

       // print(snapshot1.docs.length);
        snapshot1.docs.forEach((DocumentSnapshot doc){
         // print(doc);
          ActivityFeedItem item = ActivityFeedItem.fromDocument(doc);
          feedItems.add(item);
        });  
    //return feedItems;
    setState(() {
      this.notificationList = feedItems;
    });
    //return Text("Notification");
  }

  @override
  Widget build(BuildContext context) {
    double height = getScreenPercentSize(context, 3);
    SizeConfig().init(context);
    double totalHeight = SizeConfig.safeBlockHorizontal! * 100;
    double itemHeight = getPercentSize(totalHeight, 25);

    //getActivityFeed();
    return Scaffold(
        //backgroundColor: Color(0xFFFEF9A7),
        backgroundColor: Color.fromARGB(255, 247, 192, 207),
        body: SafeArea(
            child: Column(children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getAppBar(
                  context,
                  "Notifications",
                  isBack: true,
                  function: () {
                    _requestPop();
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          
          Container(
            child: FutureBuilder(
              future: getActivityFeed(),
              builder: (context, snapshot) {
                if (notificationList == null) {
                return circularProgress();
              }
              else if(notificationList.length == 0){
                return  emptyWidget();
              }
              else {
                  return Expanded(
                            flex: 1,
                            child: ListView.builder(
                                    primary: true,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.symmetric(
                                        vertical: getPercentSize(itemHeight, 1)),
                                    itemCount: notificationList.length,
                                    itemBuilder: (context, index) => ActivityFeedItem(
                                          username: notificationList[index].username,
                                          userId: notificationList[index].userId,
                                          type: notificationList[index].type,
                                          mediaUrl: notificationList[index].mediaUrl,
                                          postId: notificationList[index].postId,
                                          //userProfileImg:notificationList[index].userProfileImg,
                                          data: notificationList[index].data,
                                        ) /*{
                          notificationList[index];
                        },*/
                                    )
                                );
              }
              
                
                
              },
            ),
          )
        ])));
  }

  emptyWidget() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            assetsPath + "bell-1 1.png",
            height: getScreenPercentSize(context, 20),
          ),
          SizedBox(
            height: getScreenPercentSize(context, 3),
          ),
          getCustomTextWithFontFamilyWidget(
              "No Notification Yet!",
              textColor,
              getScreenPercentSize(context, 2.5),
              FontWeight.w500,
              TextAlign.center,
              1),
          SizedBox(
            height: getScreenPercentSize(context, 1),
          ),
          getCustomTextWidget(
              "We'll notify you when something arrives.",
              textColor,
              getScreenPercentSize(context, 2),
              FontWeight.w400,
              TextAlign.center,
              1),
        ],
      ),
    );
  }
}

Widget? mediaPreview;
String? activityItemText;

class ActivityFeedItem extends StatelessWidget {
  final String? username;
  final String? userId;
  final String? type;
  final String? mediaUrl;
  final String? postId;
  //final String? userProfileImg;
  final String? data;

  final Storage storage = Storage();

  ActivityFeedItem({
    this.username,
    this.userId,
    this.type,
    this.mediaUrl,
    this.postId,
    //this.userProfileImg,
    this.data,
  });

  factory ActivityFeedItem.fromDocument(DocumentSnapshot doc) {
   // print(doc.data());
    return ActivityFeedItem(
      data: doc['data'],
      mediaUrl: doc['mediaUrl'],
      postId: doc['postId'],
      type: doc['type'],
      userId: doc['userId'],
      username: doc['username'],

      //userProfileImg: doc['userProfileImg'],
    );
  }

  configureMediaPreview(BuildContext context) {
    /*if (type == "like" || type == "comment") {
      //PostWidget? post;
      mediaPreview = GestureDetector(
          onTap: () async {
            final QuerySnapshot snapshot =
                await postsRef.where("postId", isEqualTo: postId).get();

            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostScreen(
                    postId: postId,
                    userId: currentUserFirebase.userId,
                  ),
                ));
          },
          child: Container(
              height: 50.0,
              width: 50.0,
              child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: FutureBuilder(
                    
                    future: storage.downloadUrl(mediaUrl!),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting ||
                          !snapshot.hasData) {
                        return CircularProgressIndicator();
                      }    
                      else if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        return Container(
                          width: 100,
                          height: 100,
                          child:
                              Image.network(snapshot.data!, fit: BoxFit.cover),
                        );
                      }
                      else
                      return Container();
                    },
                  ))));
    }*/ 
    
    if (type == "like") {
      mediaPreview = GestureDetector(
          onTap: () async {
            final QuerySnapshot snapshot =
                await postsRef.where("postId", isEqualTo: postId).get();

            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostScreen(
                    postId: postId,
                    userId: currentUserFirebase.userId,
                  ),
                ));
          },
          child: Container(
              height: 50.0,
              width: 50.0,
              child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.asset(assetsPath + "heart.png"))));
    }
    else if (type == "comment") {
      mediaPreview = GestureDetector(
         onTap: () async {
            final QuerySnapshot snapshot =
                await postsRef.where("postId", isEqualTo: postId).get();

            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostScreen(
                    postId: postId,
                    userId: currentUserFirebase.userId,
                  ),
                ));
          },
          child: Container(
              height: 40.0,
              width: 40.0,
              child: AspectRatio(
                  aspectRatio: 15 / 9,
                  child: Image.asset("assets/img/comment.png"))));
    }

    else if (type == "msg") {
      mediaPreview = GestureDetector(
          onTap: () async{
            UserModel user = UserModel();
            final QuerySnapshot snapshot = await usersRef.get();
            snapshot.docs.forEach((DocumentSnapshot doc) {
              if (doc.get('id').trim() == userId!.trim()) {
                 user = UserModel.fromDocument(doc);}});

                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    sendeUser: currentUserFirebase,
                    receiverUser: user,
                  ),
                  //PostWidget()
                ));
          },
          child: Container(
              height: 50.0,
              width: 50.0,
              child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.asset(assetsPath + "chati.png"))));
    } else {
      mediaPreview = Text("");
    }

    if (type == 'like') {
      activityItemText = "liked your post";
    } else if (type == 'comment') {
      activityItemText = "commented: $data";
    } else if (type == 'msg') {
      activityItemText = "$data";
    } else {
      activityItemText = "Error: unknown type $type";
    }
  }

  

  @override
  Widget build(BuildContext context) {
    configureMediaPreview(context);
    SizeConfig().init(context);
    double totalHeight = SizeConfig.safeBlockHorizontal! * 100;
    double itemHeight = getPercentSize(totalHeight, 25);
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Container(
        margin: EdgeInsets.only(right: getWidthPercentSize(context, 3)),
        height: getPercentSize(itemHeight, 65),
        width: getPercentSize(itemHeight, 45),
        decoration: getDecorationWithColor(
            getPercentSize(itemHeight, 15), Color.fromARGB(255, 245, 170, 190)),
        child: Center(
          /*child: Image.asset(
          assetsPath +
              "notifications.png",
          height: getPercentSize(
              itemHeight, 20),
          color: Colors.white,
        ),*/
          child: ListTile(
            title: GestureDetector(
              onTap: () => print('show Profile'),
              child: RichText(
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: username,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: '$activityItemText')
                    ]),
              ),
            ),
            leading: Image.asset(
              assetsPath + "notifications.png",
              height: getPercentSize(itemHeight, 30),
              color: Colors.white,
            ),
            trailing: mediaPreview,
          ),
        ),
      ),
    );
  }
}
