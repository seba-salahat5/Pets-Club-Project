import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marahsebaproject/PetAdoption/adoptionAddForm.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({Key? key}) : super(key: key);

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? selectedImage;
  String base64Image = "";

  Future<void> chooseImage(type) async {
    // ignore: prefer_typing_uninitialized_variables
    var image;
    if (type == "camera") {
      image = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
    } else {
      image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
    }
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
        base64Image = base64Encode(selectedImage!.readAsBytesSync());
        // won't have any error now
      });
    }
  }

   AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        "Choose Image For Your Pet",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.white,
      elevation: 0,
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
              MaterialPageRoute(builder: (context) => AddAdoption()),
            );
                },
                child: Stack(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.done,
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
    return Scaffold(
        appBar:buildAppBar(context),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              CircleAvatar(
                backgroundColor: Color.fromARGB(255, 186, 166, 202),
                radius: 60,
                child: Padding(
                  padding: const EdgeInsets.all(10), // Border radius
                  child: ClipOval(
                    
                      child: selectedImage != null
                          ? Image.file(
                            
                              selectedImage!,
                              fit: BoxFit.cover,
                              height: 100,
                              width: 100,
                            )
                          : Image.asset(
                              'assets/img/no-pictures.png',
                              fit: BoxFit.cover,
                              height: 100,
                              width: 100,
                            )),
                ),
              ),
             
              
              ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF4F3268),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                      ),
                onPressed: () {
                  chooseImage("Gallery");
                },
                child: const Text("Image From Gallery"),
              ),
            ],
          ),
        ));
  }
}
