import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:firebase_auth/firebase_auth.dart'; 
import 'package:flutter/material.dart'; 
import 'package:marahsebaproject/findlostpet/PostWidget.dart'; 
import 'package:marahsebaproject/findlostpet/header.dart'; 
import 'package:marahsebaproject/findlostpet/progress.dart'; 
import 'package:marahsebaproject/findlostpet/upload.dart'; 
import 'package:marahsebaproject/loginsiginup/pages/widgets/sign_in.dart'; 
import 'package:marahsebaproject/models/user.dart'; 
import 'package:marahsebaproject/utils/CustomWidget.dart'; 
import 'package:marahsebaproject/utils/SizeConfig.dart'; 
 
 
 
class Timeline extends StatefulWidget { 
  final UserModel? currentUser; 
  final Function? function; 
 
  Timeline({this.currentUser, this.function}); 
 
  @override 
  _TimelineState createState() => _TimelineState(); 
} 
 
class _TimelineState extends State<Timeline> { 
  List<PostWidget> posts=[]; 
 
  @override 
  void initState() { 
    super.initState(); 
    getTimeline(); 
  } 
 
  getTimeline() async { 
    QuerySnapshot snapshot = await timelineRef.get(); 
    print(snapshot.docs.length); 
    List<PostWidget> posts = 
        snapshot.docs.map((doc) => PostWidget.fromDocument(doc)).toList(); 
    setState(() { 
      this.posts = posts; 
    }); 
 
    
  } 
 
  buildTimeline() { 
    if (posts == null) { 
      return circularProgress(); 
    } else if (posts.isEmpty) { 
      return Text("No posts"); 
    } else { 
      return ListView(children: posts); 
    } 
  } 
 
   Future<bool> _requestPop() { 
    if (widget.function != null) { 
      widget.function!(); 
    } else { 
      Navigator.of(context).pop(); 
    } 
 
    return new Future.value(true); 
  } 
 
  @override 
  Widget build(context) { 
  return Scaffold( 
          backgroundColor: Color.fromARGB(255, 186, 166, 202), 
         appBar: header(context, isAppTitle: true), 
         body: RefreshIndicator( 
            onRefresh: () => getTimeline(), child: buildTimeline(),)); 
  } 
}