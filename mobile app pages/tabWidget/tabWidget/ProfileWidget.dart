// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marahsebaproject/MainPage.dart';
import 'package:marahsebaproject/findlostpet/PostWidget.dart';
import 'package:marahsebaproject/findlostpet/chat.dart';
import 'package:marahsebaproject/findlostpet/post_tile.dart';
import 'package:marahsebaproject/findlostpet/progress.dart';
import 'package:marahsebaproject/loginsiginup/pages/widgets/sign_in.dart';
import 'package:marahsebaproject/models/user.dart';
import 'package:marahsebaproject/onboard.dart';
import 'package:marahsebaproject/utils/CustomWidget.dart';
import 'package:marahsebaproject/utils/constants.dart';

import '../../findlostpet/editProfile.dart';

final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class ProfileWidget extends StatefulWidget {
  final String? profileId;
  final Function? function;
  ProfileWidget(/*Null Function() param0, */ {this.function, this.profileId});

  @override
  _ProfileState createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<ProfileWidget> {
  String postOrientation = "";
  bool isLoading = false;
  bool isprofileOwner = false;
  List<PostWidget> posts = [];

  @override
  void initState() {
    super.initState();

    if(currentUserFirebase.userId == widget.profileId){
      isprofileOwner = true;
    }
  }

  getProfilePosts() async {
    final QuerySnapshot snapshot =
        await postsRef.where("ownerid", isEqualTo: widget.profileId).get();
    print(snapshot.docs.length);
    /*snapshot.docs.forEach((DocumentSnapshot doc) {
      print(doc.data());
    });*/

    posts = snapshot.docs.map((doc) => PostWidget.fromDocument(doc)).toList();
  }

  Future<bool> _requestPop() {
    if (widget.function != null) {
      widget.function!();
    } else {
      Navigator.of(context).pop();
    }

    return new Future.value(true);
  }

  void doNothing(BuildContext context) {}
  String name = "";
  String Password = "";
  int postCount = 0;

  getCurrentUserInfo() async {
    String data = "";
    final QuerySnapshot snapshot = await usersRef.get();

    snapshot.docs.forEach((DocumentSnapshot doc) {
      if (doc.get('id').trim() == widget.profileId!.trim()) {
        data = doc.data().toString();
        final splitted = data.split(',');
        name = splitted[2].split(':')[1].toString();
        Password = splitted[0].split(':')[1].toString();
        postCount = int.parse(splitted[1].split(':')[1]);
      }
      //print();
    });
  }

  buildProfileHeader() {
    getCurrentUserInfo();

    return FutureBuilder(
      future: usersRef.doc(widget.profileId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        return Padding(
            padding: EdgeInsets.all(5.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 60.0,
                      backgroundColor: Color(0xFFD61C4E),
                      backgroundImage: AssetImage(assetsPath + 'user.png'),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 12.0),
                  child: Text(
                    name,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                        isprofileOwner? 
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              buildProfileButton(),
                            ],
                          ):
                          Container()
              ],
            ));
      },
    );
  }

  buildProfilePosts() {
    getProfilePosts();

    if (isLoading) {
      return circularProgress();
    }
    List<GridTile> gridTiles = [];
    //List<PostWidget> listTiles = [];
    posts.forEach((post) {
      gridTiles.add(GridTile(child: PostTile(post)));
      /*listTiles.add(PostWidget(
        post: post,
      ));*/
    });

    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 1.0,
      mainAxisSpacing: 1.5,
      crossAxisSpacing: 1.5,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: gridTiles,
    );
  }

  setPostOrientation(String postOrientation) {
    setState(() {
      this.postOrientation = postOrientation;
    });
  }

  buildTogglePostOrientation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
          onPressed: () => setPostOrientation("grid"),
          icon: Icon(Icons.grid_on),
          color: postOrientation == 'grid'
              ? Theme.of(context).primaryColor
              : Colors.grey,
        ),
        IconButton(
            onPressed: () => setPostOrientation("list"),
            icon: Icon(Icons.list),
            color: postOrientation == 'list'
                ? Theme.of(context).primaryColor
                : Colors.grey),
      ],
    );
  }

   buildProfileButton() {
    // viewing your own profile - should show edit profile button
    bool isProfileOwner = currentUserFirebase.userId == widget.profileId;
    if (isProfileOwner) {
      return buildButton(
        text: "Edit Profile",
        function: editProfile,
      );
    }
  }

    editProfile() {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditProfile(currentUserId: currentUserFirebase.userId)));
  }

    Container buildButton({String? text, Function()? function}) {
    return Container(
      padding: EdgeInsets.only(top: 2.0),
      
      child: ElevatedButton(
        
        onPressed: function,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF9D78BE)
        ),
        child: Container(
          width: 200.0,
          height: 27.0,
          // ignore: sort_child_properties_last
          child: Text(
            text!,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xFF9D78BE),
            border: Border.all(
              color: Color(0xFF9D78BE),
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
      
      
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF2F2F2),
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  getAppBar(
                    context,
                    "Profile",
                    isBack: true,
                    function: () {
                      _requestPop();
                    },
                    widget: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainPage(),
                            ));
                      },
                      
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          isprofileOwner ? Container() : IconButton(
                          iconSize: 35.0,
                          icon: Icon(
                            Icons.chat_bubble_rounded,
                            color: Color(0xFF9D78BE),
                          ),
                          tooltip: 'Increase volume by 10%',
                          //onPressed: () => _pressedComment(),
                          onPressed: () async{ 
                            
                            UserModel user = UserModel();
                            final QuerySnapshot snapshot = await usersRef.get();
                            snapshot.docs.forEach((DocumentSnapshot doc) {
                                if (doc.get('id').trim() == widget.profileId!.trim()) {
                                user = UserModel.fromDocument(doc);
                                }});

                      // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatScreen(
                                    sendeUser: currentUserFirebase,
                                    receiverUser: user,
                                  ),
                                  //PostWidget()
                                ));
                              }
                        
                        ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              //shape: const StadiumBorder(),
                              primary: Color(0xFF9D78BE),
                              elevation: 8,
                              shadowColor: Colors.black87,
                            ),
                            child: Text("Logout",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => onboard(),
                                  ));
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ]))),
        body: ListView(
          children: <Widget>[
            buildProfileHeader(),
            Divider(),
            buildTogglePostOrientation(),
            Divider(
              height: 0.0,
            ),
            buildProfilePosts(),
          ],
        ));
  }
}
