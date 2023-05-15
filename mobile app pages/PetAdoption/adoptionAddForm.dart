// ignore_for_file: unnecessary_new, deprecated_member_use
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:marahsebaproject/MainPage.dart';
import 'package:http/http.dart' as http;
import 'package:marahsebaproject/PetAdoption/AllPet.dart';
import 'package:marahsebaproject/PetAdoption/img.dart';

class AddAdoption extends StatefulWidget {
  @override
  AddAdoptionState createState() => AddAdoptionState();
}

class AddAdoptionState extends State<AddAdoption>
    with SingleTickerProviderStateMixin {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController weightCtrl = TextEditingController();
  TextEditingController ageCtrl = TextEditingController();
  TextEditingController colorCtrl = TextEditingController();
  TextEditingController locationCtrl = TextEditingController();
  TextEditingController storyCtrl = TextEditingController();
  bool status = true;

  final FocusNode myFocusNode = FocusNode();
  double cellHeight = 0;
  String genderRadioPosition = '0'; //0 ==> Male, 1 ==> Female
  String petTypeRadioPosition = '0'; //0 ==> Male, 1 ==> Female

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  double getScreenPercentSize(BuildContext context, double percent) {
    return (MediaQuery.of(context).size.height * percent) / 100;
  }

  double getPercentSize(double total, double percent) {
    return (total * percent) / 100;
  }

  double getWidthPercentSize(BuildContext context, double percent) {
    return (MediaQuery.of(context).size.width * percent) / 100;
  }

  Widget getTextWithFontFamilyWidget(String string, Color color, double size,
      FontWeight fontWeight, TextAlign align) {
    return Text(string,
        textAlign: align,
        style: TextStyle(
            fontWeight: fontWeight,
            fontSize: size,
            decoration: TextDecoration.none,
            fontFamily: "Gilroy",
            color: color));
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
    locationCtrl.text = formattedAddress;
  }

  addAdoption(String name, String weight, String age, String color,
      String location, String story, String gender, String type) async {
    var url = "http://192.168.1.3:3005/adoption/create";
    var data = {
      "name": name.toString(),
      "weight": weight.toString(),
      "age": age.toString(),
      "color": color.toString(),
      "location": location.toString(),
      "petStory": story.toString(),
      "gender": gender,
      "type": type,
    };
    try {
      var res = await http.post(Uri.parse(url), body: data);
      print(res.body);
      var resbody;
      if (res.body.isNotEmpty) {
        resbody = json.decode(res.body);
        if (resbody['status'] == 200) {
          Fluttertoast.showToast(
              msg: resbody['message'], toastLength: Toast.LENGTH_SHORT);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MainPage(),
          ));
        } else {
          Fluttertoast.showToast(
              msg: resbody['message'], toastLength: Toast.LENGTH_SHORT);
        }
      }
    } catch (e) {
      print(e);
    }
  }
    AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        "    Add New Friend",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 22,
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      leading: GestureDetector(
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 30,
            color: Color(0xFF4F3268),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AllPets()),
            );
          },
        ),
      ),
      actions: <Widget>[
    
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: new Container(
              height: 150.0,
              width: 30.0,
              child: new GestureDetector(
                onTap: () {
                   Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ImagePickerScreen()),
            );
                },
                child: Stack(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.image,
                        color: Color(0xFF4F3268),
                        size: 30,
                      ),
                      onPressed: null,
                    ),
                  ],
                ),
              )),
        )
     
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    cellHeight = getScreenPercentSize(context, 6.5);
    return Scaffold(
        appBar: buildAppBar(context),
        body: Container(
      color: Color(0xF2F2F2F2),
      child: ListView(
        children: <Widget>[
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 25.0, top: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width - 24,
                        height: cellHeight,
                        alignment: Alignment.centerLeft,
                        decoration: ShapeDecoration(
                          color: Color.fromRGBO(255, 255, 255, 1.000),
                          shape: SmoothRectangleBorder(
                            side: BorderSide(
                                color: Color.fromARGB(255, 255, 160, 191),
                                width: 4),
                            borderRadius: SmoothBorderRadius(
                              cornerRadius: getPercentSize(cellHeight, 20),
                              cornerSmoothing: 0.8,
                            ),
                          ),
                        ),
                        child: TextFormField(
                          controller: nameCtrl,
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              hintText: "Pet Name",
                              suffixIcon: Icon(
                                FontAwesomeIcons.fill,
                                color: Colors.black87,
                              ),
                              isDense: true,
                              hintStyle: TextStyle(
                                  fontFamily: "Gilroy",
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width - 24,
                        height: cellHeight,
                        alignment: Alignment.centerLeft,
                        decoration: ShapeDecoration(
                          color: Color.fromRGBO(255, 255, 255, 1.000),
                          shape: SmoothRectangleBorder(
                            side: BorderSide(
                                 color: Color.fromARGB(255, 255, 160, 191),
                                width: 4),
                            borderRadius: SmoothBorderRadius(
                              cornerRadius: getPercentSize(cellHeight, 20),
                              cornerSmoothing: 0.8,
                            ),
                          ),
                        ),
                        child: TextFormField(
                          controller: weightCtrl,
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              hintText: "Pet Weight",
                              suffixIcon: Icon(
                                FontAwesomeIcons.weightScale,
                                color: Colors.black87,
                              ),
                              isDense: true,
                              hintStyle: TextStyle(
                                  fontFamily: "Gilroy",
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width - 24,
                        height: cellHeight,
                        alignment: Alignment.centerLeft,
                        decoration: ShapeDecoration(
                          color: Color.fromRGBO(255, 255, 255, 1.000),
                          shape: SmoothRectangleBorder(
                            side: BorderSide(
                                color: Color.fromARGB(255, 255, 160, 191),
                                width: 4),
                            borderRadius: SmoothBorderRadius(
                              cornerRadius: getPercentSize(cellHeight, 20),
                              cornerSmoothing: 0.8,
                            ),
                          ),
                        ),
                        child: TextFormField(
                          controller: ageCtrl,
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "Pet Age",
                              suffixIcon: Icon(
                                FontAwesomeIcons.listNumeric,
                                color: Colors.black87,
                              ),
                              isDense: true,
                              hintStyle: TextStyle(
                                  fontFamily: "Gilroy",
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width - 24,
                        height: cellHeight,
                        alignment: Alignment.centerLeft,
                        decoration: ShapeDecoration(
                          color: Color.fromRGBO(255, 255, 255, 1.000),
                          shape: SmoothRectangleBorder(
                            side: BorderSide(
                                color:   Color.fromARGB(255, 255, 160, 191),
                                width: 4),
                            borderRadius: SmoothBorderRadius(
                              cornerRadius: getPercentSize(cellHeight, 20),
                              cornerSmoothing: 0.8,
                            ),
                          ),
                        ),
                        child: TextFormField(
                          controller: colorCtrl,
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              hintText: "Pet Color",
                              suffixIcon: Icon(
                                Icons.colorize,
                                color: Colors.black87,
                              ),
                              isDense: true,
                              hintStyle: TextStyle(
                                  fontFamily: "Gilroy",
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width - 24,
                        height: cellHeight,
                        alignment: Alignment.centerLeft,
                        decoration: ShapeDecoration(
                          color: Color.fromRGBO(255, 255, 255, 1.000),
                          shape: SmoothRectangleBorder(
                            side: BorderSide(
                                color: Color.fromARGB(255, 255, 160, 191),
                                width: 4),
                            borderRadius: SmoothBorderRadius(
                              cornerRadius: getPercentSize(cellHeight, 20),
                              cornerSmoothing: 0.8,
                            ),
                          ),
                        ),
                        child: TextFormField(
                          controller: locationCtrl,
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.center,
                          onTap: getUserLocation,
                          decoration: InputDecoration(
                              hintText: "Pet Location",
                              suffixIcon: Icon(
                                FontAwesomeIcons.mapLocation,
                                color: Colors.black87,
                              ),
                              
                              isDense: true,
                              hintStyle: TextStyle(
                                  fontFamily: "Gilroy",
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width - 24,
                        height: 100,
                        alignment: Alignment.centerLeft,
                        decoration: ShapeDecoration(
                          color: Color.fromRGBO(255, 255, 255, 1.000),
                          shape: SmoothRectangleBorder(
                            side: BorderSide(
                                 color: Color.fromARGB(255, 255, 160, 191),
                                width: 4),
                            borderRadius: SmoothBorderRadius(
                              cornerRadius: getPercentSize(cellHeight, 20),
                              cornerSmoothing: 0.8,
                            ),
                          ),
                        ),
                        child: TextFormField(
                          controller: storyCtrl,
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              hintText: "Pet Story",
                              suffixIcon: Icon(
                                FontAwesomeIcons.cat,
                                color: Colors.black87,
                              ),
                              isDense: true,
                              hintStyle: TextStyle(
                                  fontFamily: "Gilroy",
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16)),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              getPetRadioButton(context, "Dog", '0'),
                              SizedBox(
                                width: (getWidthPercentSize(context, 4)),
                              ),
                              getPetRadioButton(context, "Cat", '1'),
                            ], // ببعتلك 0 او 1 بس
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              getRadioButton(context, "Male", '0'),
                              SizedBox(
                                width: (getWidthPercentSize(context, 4)),
                              ),
                              getRadioButton(context, "Female", '1'),
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 120, top: 20),
                        child: Container(
                          // decoration: BoxDecoration(
                          //     border: Border.all(color: Colors.black)),
                          // width: 160,
                          // height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              print(genderRadioPosition);
                              print(petTypeRadioPosition);
                              addAdoption(
                                  nameCtrl.text.toString(),
                                  weightCtrl.text.toString(),
                                  ageCtrl.text.toString(),
                                  colorCtrl.text.toString(),
                                  locationCtrl.text.toString(),
                                  storyCtrl.text.toString(),
                                  genderRadioPosition,
                                  petTypeRadioPosition);
                            },
                            child: Text(
                              'Add',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),
                            ),
                            style: ElevatedButton.styleFrom(
                             primary:   Color(0xFF4F3268),
    onPrimary: Colors.white,
    padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
    ),
                                
                                
                                
                                
                                
                                
                                ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget getRadioButton(BuildContext context, String s, String position) {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () {
          setState(() {
            genderRadioPosition = position.toString();
          });
        },
        child: Container(
          height: cellHeight,
          width: double.infinity,
          margin: EdgeInsets.symmetric(
              vertical: getScreenPercentSize(context, 1.2)),
          padding:
              EdgeInsets.symmetric(horizontal: getWidthPercentSize(context, 2)),
          alignment: Alignment.centerLeft,
          decoration: ShapeDecoration(
            color: Color.fromRGBO(255, 255, 255, 1.000),
            shape: SmoothRectangleBorder(
              side: BorderSide(
                   color: Color.fromARGB(255, 255, 160, 191),
                  width: 2),
              borderRadius: SmoothBorderRadius(
                cornerRadius: getPercentSize(cellHeight, 20),
                cornerSmoothing: 0.8,
              ),
            ),
          ),
          child: Row(
            children: [
              Icon(
                (genderRadioPosition == position)
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                size: (16 * 1.8),
                color: (genderRadioPosition == position)
                    ? Color(0xFF4F3268)
                    : Colors.black,
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                  child: Text(s,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          color: Colors.black)))
            ],
          ),
        ),
      ),
    );
  }

  Widget getPetRadioButton(BuildContext context, String s, String position) {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () {
          setState(() {
            petTypeRadioPosition = position.toString();
          });
        },
        child: Container(
          height: cellHeight,
          width: double.infinity,
          margin: EdgeInsets.symmetric(
              vertical: getScreenPercentSize(context, 1.2)),
          padding:
              EdgeInsets.symmetric(horizontal: getWidthPercentSize(context, 2)),
          alignment: Alignment.centerLeft,
          decoration: ShapeDecoration(
            color: Color.fromRGBO(255, 255, 255, 1.000),
            shape: SmoothRectangleBorder(
              side: BorderSide(
                  color: Color.fromARGB(255, 255, 160, 191),
                  width: 2),
              borderRadius: SmoothBorderRadius(
                cornerRadius: getPercentSize(cellHeight, 20),
                cornerSmoothing: 0.8,
              ),
            ),
          ),
          child: Row(
            children: [
              Icon(
                (petTypeRadioPosition == position)
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                size: (16 * 1.8),
                color: (petTypeRadioPosition == position)
                    ? Color(0xFF4F3268)
                    : Colors.black,
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                  child: Text(s,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          color: Colors.black)))
            ],
          ),
        ),
      ),
    );
  }
}
