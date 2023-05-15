// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marahsebaproject/MainPage.dart';
import 'package:marahsebaproject/models/Adoption.dart';
import 'package:marahsebaproject/utils/constants.dart';
class PetDetail extends StatefulWidget {
  static const routeName = '/product-details-screen ';

  PetDetail({
    super.key,
    required this.adoptionModel,
  });
  final AdoptionModel adoptionModel;

  @override
  State<PetDetail> createState() => _PetDetailState();
}

class _PetDetailState extends State<PetDetail> {
  AdoptionModel? adoptionModel;

  int? adoptionId;

  @override
  Widget build(BuildContext context) {
    AdoptionModel adoptionModel =
        ModalRoute.of(context)!.settings.arguments as AdoptionModel;

    statusUpdate(String status, String id) async {
      var url = "http://192.168.1.3:3005/adoption/update";
      var data = {
        "status": adoptionModel.status.toString(),
        "id": id.toString()
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
            // Navigator.of(context).push(MaterialPageRoute(
            //   builder: (context) => MainPage(),
            // ));
          } else {
            Fluttertoast.showToast(
                msg: resbody['message'], toastLength: Toast.LENGTH_SHORT);
          }
        }
      } catch (e) {
        print(e);
      }
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0Xff9fc9f3),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Pet details',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: const Color(0xF2F2F2F2),
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: 30,
              color: Colors.black,
            ),
          ),
          actions: [],
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          '$baseUrl/uploads/${adoptionModel.petImage}'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                ),
                Container(
                  color: Color(0Xff9fc9f3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  adoptionModel.name
                                      .toString(), //name ftom data.dart
                                  style: TextStyle(
                                    color: Color(0xFF4F3268),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Image.asset("assets/img/location.png"),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      adoptionModel.location.toString(),
                                      style: TextStyle(
                                        color: Color(0xFF4F3268),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            adoptionModel.gender == 0
                                ? Container(
                                    height: 50,
                                    width: 50,
                                    child: IconButton(
                                      icon: Icon(Icons.male_outlined,
                                          color: Color(0xFF4F3268),size:20),
                                      /*Image.asset(
                                        "assets/img/male.png",
                                      ),*/
                                      onPressed: () {},
                                    ),
                                  )
                                : Container(
                                    height: 50,
                                    width: 75,
                                    child: IconButton(
                                      icon: Icon(Icons.female_outlined,
                                          color: Color(0xFF4F3268)),
                                      onPressed: () {},
                                    ),
                                  )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            buildPetFeature(
                                adoptionModel.age.toString(), "Age"),
                            buildPetFeature(
                                adoptionModel.color.toString(), "Color"),
                            buildPetFeature(
                                adoptionModel.weight.toString(), "Weight"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Pet Story :",
                          style: TextStyle(
                            color: Color(0xFF4F3268),
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          adoptionModel.petStory.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: 16, left: 16, top: 16, bottom: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 12,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 4,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            adoptionModel.status == '0'
                                ? Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 14, horizontal: 20),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF4F3268),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                      ),
                                      onPressed: null,
                                      child: Text(
                                        "Adopted Before".toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 14, horizontal: 20),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF4F3268),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                      ),
                                      onPressed: () {
                                        // setState(() {
                                        //   statusUpdate(
                                        //     adoptionModel.status = '0',
                                        //     widget.adoptionModel.id.toString(),
                                        //   );
                                        // });
                                        showDialog<void>(
                                          context: context,
                                          barrierDismissible:
                                              false, // user must tap button!
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                backgroundColor:Color.fromARGB(255, 255, 210, 225),
                                              icon: Icon(FontAwesomeIcons.cat,color: Color(0xFF4F3268),),
                                              title:
                                                  Text('Adoption Approvel',
                                                  textAlign: TextAlign.center,
             style: TextStyle(
                  fontSize: 22.0, fontWeight: FontWeight.w600),
                                                  
                                                  ),
                                              content: SingleChildScrollView(
                                                
                                                child: ListBody(
                                                
                                                  children: const <Widget>[
                                                    
                                                    Text(
                                                        'Would you like to Adopte this Pet?',
                                                         textAlign: TextAlign.center,
                                                        ),
                                                  ],
                                                ),
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text('Cancel',textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    
                  fontSize: 22.0, fontWeight: FontWeight.w600,color:Color(0xFF4F3268) ),
                                                  
                                                  
                                                  ),
                                                  onPressed: () {
                                                     setState(() {
                                                      statusUpdate(
                                                        adoptionModel.status =
                                                            '1',
                                                        widget.adoptionModel.id
                                                            .toString(),
                                                      );
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: const Text('Approve'
                                                  ,
                                                   style: TextStyle(
                  fontSize: 22.0, fontWeight: FontWeight.w600,color:Color(0xFF4F3268) )
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      statusUpdate(
                                                        adoptionModel.status =
                                                            '0',
                                                        widget.adoptionModel.id
                                                            .toString(),
                                                      );
                                                    });
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                MainPage()));
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Text(
                                        "Adopt me".toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildPetFeature(String value, String feature) {
    return Expanded(
      child: Container(
        height: 70,
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 198, 217),
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                color: Color(0xFF4F3268),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              feature,
              style: TextStyle(
                color: Color(0xFF4F3268),
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
