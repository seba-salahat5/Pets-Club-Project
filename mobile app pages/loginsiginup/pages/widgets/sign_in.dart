import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:marahsebaproject/MainPage.dart';
import 'package:marahsebaproject/models/currentUser.dart';
import 'package:marahsebaproject/loginsiginup/pages/theme.dart';
import 'package:http/http.dart' as http;

final usersRef = FirebaseFirestore.instance.collection('users');
final postsRef = FirebaseFirestore.instance.collection('posts');
final timelineRef = FirebaseFirestore.instance.collection('timeline');
final commentsRef = FirebaseFirestore.instance.collection('comments');
final activityFeedRef = FirebaseFirestore.instance.collection('feed');

//final StorageReference storageRef =  FirebaseStorage.instance.ref();
final Reference storageRef = FirebaseStorage.instance.ref();

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodePassword = FocusNode();
  var dio = Dio();
  List<dynamic> listproduct = [];
  var logEmail, logPassword, logname;
  bool _obscureTextPassword = true;

  bool processing = false;

  userSignIn(String logEmail, String logPassword) async {
    CurrentUser.clearUser();
    setState(() {
      processing = true;
    });
    var url = "http://192.168.1.3:3005/user/login";
    var data = {
      "email": logEmail,
      "password": logPassword,
    };
    try {
      print(logEmail);
      print(logPassword);
      var res = await http.post(Uri.parse(url), body: data);
      print(res.body);
      var resbody;
      if (res.body.isNotEmpty) {
        resbody = json.decode(res.body);
        CurrentUser.fromJson(resbody);
        print(resbody);
        if (resbody['status'] == 200) {
          Fluttertoast.showToast(
              msg: "you are sign in", toastLength: Toast.LENGTH_SHORT);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MainPage(),
          ));

          setState(() {
            processing = false;
          });
        } else {
          Fluttertoast.showToast(
              msg: resbody['message'], toastLength: Toast.LENGTH_SHORT);
        }
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: "incorrect email or password", toastLength: Toast.LENGTH_SHORT);
    }
  }

  @override
  void dispose() {
    focusNodeEmail.dispose();
    focusNodePassword.dispose();
    super.dispose();
  }

Future<User?> loginFire(String email, String password) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      User? user = (await _auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      DocumentSnapshot doc = await usersRef.doc(user!.email).get();
      if (user != null) {
        //print("Login Sucessfull Firebase");
        return user;
      } else {
        print("Login Failed Firebase");
        return user;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future logOut() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.signOut();
    } catch (e) {
      print("error!!");
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 190.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextFormField(
                            validator: RequiredValidator(
                                errorText: 'Please Enter Your Email'),
                            focusNode: focusNodeEmail,
                            controller: loginEmailController,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(
                                fontFamily: 'WorkSansSemiBold',
                                fontSize: 16.0,
                                color: Colors.black),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesomeIcons.envelope,
                                color: Colors.black,
                                size: 22.0,
                              ),
                              hintText: 'Email Address',
                              hintStyle: TextStyle(
                                  fontFamily: 'WorkSansSemiBold',
                                  fontSize: 17.0),
                            ),
                            // onSubmitted: (_) {
                            //   focusNodePassword.requestFocus();
                            // },
                            onChanged: (value) {
                              logEmail = value;
                            }),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextFormField(
                            focusNode: focusNodePassword,
                            controller: loginPasswordController,
                            obscureText: _obscureTextPassword,
                            style: const TextStyle(
                                fontFamily: 'WorkSansSemiBold',
                                fontSize: 16.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: const Icon(
                                FontAwesomeIcons.lock,
                                size: 22.0,
                                color: Colors.black,
                              ),
                              hintText: 'Password',
                              hintStyle: const TextStyle(
                                  fontFamily: 'WorkSansSemiBold',
                                  fontSize: 17.0),
                              suffixIcon: GestureDetector(
                                onTap: _toggleLogin,
                                child: Icon(
                                  _obscureTextPassword
                                      ? FontAwesomeIcons.eye
                                      : FontAwesomeIcons.eyeSlash,
                                  size: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            // onSubmitted: (_) {
                            //   _toggleSignInButton();
                            // },
                            validator: RequiredValidator(
                                errorText: 'Please Enter Your Password'),
                            textInputAction: TextInputAction.go,
                            onChanged: (Value) {
                              logPassword = Value;
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 170.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: CustomTheme.loginGradientStart,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                    BoxShadow(
                      color: CustomTheme.loginGradientEnd,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                  ],
                  gradient: LinearGradient(
                      colors: <Color>[
                        CustomTheme.loginGradientEnd,
                        CustomTheme.loginGradientStart
                      ],
                      begin: FractionalOffset(0.2, 0.2),
                      end: FractionalOffset(1.0, 1.0),
                      stops: <double>[0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: MaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: CustomTheme.loginGradientEnd,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontFamily: 'WorkSansBold'),
                      ),
                    ),
                    onPressed: () {
                      if (loginEmailController.value.text.isNotEmpty &&
                          loginPasswordController.value.text.isNotEmpty) {
                            loginFire(logEmail, logPassword).then((user) async {
              if (user != null) {
                final QuerySnapshot snapshot =
                    await usersRef.where("email", isEqualTo: logEmail).get();
                snapshot.docs.forEach((DocumentSnapshot doc) {
                  //print(doc.get("name"));
                  //username = doc.get("name");
                  //print("username from login: " + username);
                });
                print("Login Successfull Firebase");
                setState(() {
                  processing = false;
                });
              } else {
                print("Login Failed Firebase");
              }
            });




















                        userSignIn(logEmail, logPassword);
                      } 
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      else {
                        Fluttertoast.showToast(msg: "Please Enter Your Data");
                      }
                    }),
              )
            ],
          ),
         
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: <Color>[
                          Colors.white10,
                          Colors.white,
                        ],
                        begin: FractionalOffset(0.0, 0.0),
                        end: FractionalOffset(1.0, 1.0),
                        stops: <double>[0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  width: 100.0,
                  height: 1.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }
}
