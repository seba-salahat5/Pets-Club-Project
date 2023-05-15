import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marahsebaproject/Animations/CustomAnimatedBottomBar.dart';
import 'package:marahsebaproject/PetAdoption/AllPet.dart';
import 'package:marahsebaproject/findlostpet/timeline.dart';
import 'package:marahsebaproject/loginsiginup/pages/widgets/sign_in.dart';
import 'package:marahsebaproject/models/user.dart';
import 'package:marahsebaproject/mycart/cartpage.dart';
import 'package:marahsebaproject/tabWidget/tabWidget/HomeWidget.dart';
import 'package:marahsebaproject/tabWidget/tabWidget/ProfileWidget.dart';
import 'package:marahsebaproject/utils/Constants.dart';
import 'package:marahsebaproject/utils/CustomWidget.dart';


import 'main.dart';

final _firestore = FirebaseFirestore.instance;
late User sighnedInUserFirebase;
UserModel currentUserFirebase = UserModel();
late String signedDocIdFirebase;

class MainPage extends StatefulWidget {
  final int? tabPosition;
  //final String? username;
  MainPage({
    this.tabPosition,
    /*this.username*/
  });

  @override
  _MainPage createState() {
    return _MainPage();
  }
}

class _MainPage extends State<MainPage> {
  int _currentIndex = 0;
  //String? _username = "";
  final _auth = FirebaseAuth.instance;

  Future<bool> _requestPop() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex = 0;
      });
    } else {
      exitApp();
    }
    return new Future.value(false);
  }

  @override
  void initState() {
    super.initState();

    if (widget.tabPosition != null) {
      setState(() {
        _currentIndex = widget.tabPosition!;
      });
    }
    getCurrentUser();
    Future.delayed(Duration(seconds: 0), () {
      setThemePosition(context: context);
      setState(() {});
    });
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        sighnedInUserFirebase = user;
        print("Hello Main");
        print(sighnedInUserFirebase.email);

        final QuerySnapshot snapshot =
            await usersRef.where("email", isEqualTo: sighnedInUserFirebase.email).get();
        snapshot.docs.forEach((DocumentSnapshot doc) {
          print(doc.data());
          signedDocIdFirebase = doc.id;

          String? data = doc.data().toString();
          final splitted = data.split(',');
          // ignore: unnecessary_new
          currentUserFirebase = new UserModel(
            userId: splitted[3].split(':')[1].toString(),
            email: splitted[4].split(':')[1].toString(),
            name: splitted[2].split(':')[1].toString(),
            password: splitted[0].split(':')[1].toString(),
            postsCount: int.parse(splitted[1].split(':')[1]),
          );

          print(currentUserFirebase.userId);

          //print();
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Widget getBody() {
    List<Widget> pages = [
       HomeWidget(() {
        setState(() {
          _currentIndex = 3;
        });
      }, functionViewAll: () {
        setState(() {
          _currentIndex = 1;
        });
      }, functionAdoptionAll: () {
        setState(() {
          _currentIndex = 3;
        });
      }),
      Timeline(currentUser: currentUserFirebase),
      CartPage(),
      AllPets(),
      ProfileWidget(profileId: currentUserFirebase.userId,)/*() {
        myTheme.switchTheme();
        Future.delayed(Duration(seconds: 1), () {
          setThemePosition(context: context);
          setState(() {});
        });
      }),*/
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }

  @override
  Widget build(BuildContext context) {
    //print("from Main Page");
    //print(_username);
    return WillPopScope(
        // ignore: sort_child_properties_last
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 0,
            backgroundColor: Color(0xF2F2F2F2), //kBackgroundColor
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Color(0xF2F2F2F2), //kBackgroundColor
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
          ),
          resizeToAvoidBottomInset: true,
          backgroundColor: Color(0xF2F2F2F2), //kBackgroundColor
          bottomNavigationBar: _buildBottomBar(),
          body: SafeArea(
            child: Container(child: getBody()),
          ),
        ),
        onWillPop: _requestPop);
  }

  Widget _buildBottomBar() {
   final _inactiveColor = iconColor;

    double height = getScreenPercentSize(context, 7.5);
    double iconHeight = getPercentSize(height, 30);
    return CustomAnimatedBottomBar(
      containerHeight: height,
      backgroundColor: Color(0xFF9D78BE), //kSecondaryColor
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          title: 'Home',
          activeColor: Color(0xFF4F3268),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
          iconSize: iconHeight,
          imageName: "home.png",
        ),
        BottomNavyBarItem(
          title: 'Favorate',
          activeColor: Color(0xFF4F3268),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
          iconSize: iconHeight,
          imageName: "write.png",
        ),
        BottomNavyBarItem(
          title: 'Cart',
          activeColor: Color(0xFF4F3268),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
          iconSize: iconHeight,
          imageName: "orders.png",
        ),
        BottomNavyBarItem(
          title: 'All Pets',
          activeColor: Color(0xFF4F3268),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
          iconSize: iconHeight,
          imageName: "pet.png",
        ),
        BottomNavyBarItem(
            iconSize: iconHeight,
            title: 'Profile',
            activeColor: Color(0xFF4F3268),
            imageName: "profile.png",
            inactiveColor: _inactiveColor,
            textAlign: TextAlign.center),
      ],
    );
  }
}
