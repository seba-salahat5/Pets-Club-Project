import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:marahsebaproject/MainPage.dart';
import 'package:marahsebaproject/findlostpet/progress.dart';
import 'package:marahsebaproject/findlostpet/storage_services.dart';
import 'package:marahsebaproject/loginsiginup/pages/widgets/sign_in.dart';
import 'package:marahsebaproject/utils/CustomWidget.dart';
import 'package:marahsebaproject/utils/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Im;
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

final _firestore = FirebaseFirestore.instance;

class Upload extends StatefulWidget {
  final Function? function;

  Upload({this.function});
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  final _auth = FirebaseAuth.instance;
  TextEditingController locationController = TextEditingController();
  TextEditingController captionController = TextEditingController();
  final Storage storage = Storage();
  bool imageFlag = false;

  bool isUploading = false;
  String postId = Uuid().v4();

  @override
  void initState() {
    super.initState();
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

  createPostInFirestore(
      {String? mediaUrl, String? location, String? description}) {
    postsRef.doc(postId).set({
      "postId": postId,
      "ownerid": currentUserFirebase.userId,
      "username": currentUserFirebase.name,
      "mediaUrl": mediaUrl,
      "description": description,
      "location": location,
      "likes": {},
      "comments": {},
    });

    timelineRef.doc(postId).set({
      "postId": postId,
      "ownerid": currentUserFirebase.userId,
      "username": currentUserFirebase.name,
      "mediaUrl": mediaUrl,
      "description": description,
      "location": location,
      "likes": {},
      "comments": {},
    });
    /*postsRef.doc(currentUser.id).collection("userPosts").doc(postId).set({
      "postId": postId,
      "ownerid": currentUser.id,
      "username": currentUser.name,
      "mediaUrl": mediaUrl,
      "description": description,
      "location": location,
      "likes": {},
      "comments": {},
    });*/
  }

  updatePostCount() async {
    final docRef = usersRef.doc(signedDocIdFirebase);
    try {
      await docRef.update({"postsCount": currentUserFirebase.postsCount! + 1});
    } catch (e) {
      print(e);
    }
  }

  handleSubmit() {
    setState(() {
      isUploading = true;
    });
    createPostInFirestore(
      mediaUrl: 'img_$postId.jpg',
      location: locationController.text,
      description: captionController.text,
    );
    updatePostCount();
    captionController.clear();
    locationController.clear();
    
    setState(() {
      //image = null;
      isUploading = false;
      postId = Uuid().v4();
    });
  }
  getAppBar(BuildContext context, String s,
    {bool? isBack, Function? function, Widget? widget}) {
  return Material(
    elevation: getScreenPercentSize(context, 1.5),
    shadowColor: primaryColor.withOpacity(0.1),
    child: Container(
      color: Color(0xFFF2F2F2),
      height: getScreenPercentSize(context, 7),
      width: double.infinity,
      child: Stack(
        children: [
          Center(
            child: getTextWithFontFamilyWidget(
                s,
                textColor,
                getScreenPercentSize(context, 2),
                
                FontWeight.w500,
                TextAlign.center),
          ),
          //
          Visibility(
            visible: (isBack != null),
            child: Positioned.fill(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: getHorizontalSpace(context)),
                    child: InkWell(
                        onTap: () {
                          if (function != null) {
                            function();
                          }
                        },
                        child: Image.asset(
                          assetsPath + "back.png",
                          height: getScreenPercentSize(context, 2.5),
                          color: textColor,
                        ))),
              ),
            ),
          ),

          Visibility(
            visible: (widget != null),
            child: Positioned.fill(
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: getHorizontalSpace(context)),
                    child: widget),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
  Widget buildUploadForm() {
    double height = getScreenPercentSize(context, 3);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 183, 205),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 35),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getAppBar(
                      context,
                      "Caption Your Post",
                      
                      isBack: true,
                      function: () {
                        _requestPop();
                      },
                      widget: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Upload(),
                              ));
                        },
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            //shape: const StadiumBorder(),
                            primary: Color.fromARGB(255, 255, 160, 191),
                            elevation: 8,
                            shadowColor: Colors.black87,
                          ),
                          child: Text("Post",
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0)),
                          onPressed: isUploading ? null : () => handleSubmit(),
                        ),
                      ),
                    )
                  ]))),
      body: ListView(
        children: <Widget>[
          isUploading ? linearProgress() : Text(""),
           Container(
            height: 220.0,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(storage.file!),
                    ),
                  ),
                ),
              ),
            ),
          ),
          /*Container(
            height: 220.0,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: FutureBuilder(
                    future: storage.listFiles(),
                    builder: (BuildContext context,
                        AsyncSnapshot<firebase_storage.ListResult> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          height: 360,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.items.length,
                              itemBuilder: (BuildContext context, int index) {
                                return FutureBuilder(
                                    future: storage.downloadUrl(
                                        snapshot.data!.items[index].name),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<String> snapshot) {
                                      if (snapshot.connectionState ==
                                              ConnectionState.done &&
                                          snapshot.hasData) {
                                        return Container(
                                          width: 360,
                                          height: 360,
                                          child: Image.network(snapshot.data!,
                                              fit: BoxFit.cover),
                                        );
                                      }
                                      if (snapshot.connectionState ==
                                              ConnectionState.waiting ||
                                          !snapshot.hasData) {
                                        return CircularProgressIndicator();
                                      }
                                      return Container();
                                    });
                              }),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting ||
                          !snapshot.hasData) {
                        return CircularProgressIndicator();
                      }
                      return Container();
                    }),
              ),
            ),
          ),*/
          Padding(
            padding: EdgeInsets.only(top: 10.0),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(assetsPath + "user.png"),
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                controller: captionController,
                decoration: InputDecoration(
                    hintText: "Write a caption...", border: InputBorder.none),
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.pin_drop, color: Color.fromARGB(255, 255, 160, 191), size: 35.0),
            title: Container(
              width: 250.0,
              child: TextField(
                controller: locationController,
                decoration: InputDecoration(
                  hintText: "Where was this photo taken?",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(
            width: 200.0,
            height: 100.0,
            alignment: Alignment.center,
            child: ElevatedButton.icon(
              label: Text("Use Current Location",
                  style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                backgroundColor: Color(0xFFD61C4E),
              ),
              onPressed: getUserLocation,
              icon: Icon(
                Icons.my_location,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  getUserLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks[0];
    String completeAddress =
        '${placemark.subThoroughfare} ${placemark.thoroughfare}, ${placemark.subLocality} ${placemark.locality}, ${placemark.subAdministrativeArea}, ${placemark.administrativeArea} ${placemark.postalCode}, ${placemark.country}';
    print(completeAddress);
    String formattedAddress = "${placemark.locality}, ${placemark.country}";
    locationController.text = formattedAddress;
  }

  Scaffold buildSplashScreen() {
    double height = getScreenPercentSize(context, 3);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 185, 208),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getAppBar(context, "New Post", isBack: true, function: () {
                  _requestPop();
                }, widget: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainPage(),
                        ));
                  },
                ))
              ],
            )),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(assetsPath + "upload.png", height: 260.0),
          Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 35),
              child: ElevatedButton(
                onPressed: () async {
                  final results = await FilePicker.platform.pickFiles(
                    allowMultiple: false,
                    type: FileType.custom,
                    allowedExtensions: ['png', 'jpg'],
                  );

                  if (results == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("No File Selected")),
                    );
                    imageFlag = false;
                    return null;
                  }
                  final path = results.files.single.path;
                  final filename = results.files.single.name;

                  storage.UploadFile(path!, filename, postId)
                      .then((value) => print("Done"));

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => buildUploadForm(),
                      ));
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: const StadiumBorder(),
                  primary: Color(0xffd61c4e),
                  elevation: 8,
                  shadowColor: Colors.black87,
                ),
                child: Text(
                  "   Upload Image   ",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildSplashScreen();
  }
}
