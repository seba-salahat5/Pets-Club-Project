import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:intl/intl.dart';
import 'package:marahsebaproject/models/currentUser.dart';
import 'package:marahsebaproject/hotelpet/bookModel.dart';

class BookHotel extends StatefulWidget {
  const BookHotel({super.key});

  @override
  State<BookHotel> createState() => _BookHotelState();
}

class _BookHotelState extends State<BookHotel> {
  TextEditingController firstdateController = TextEditingController();
  TextEditingController lastdateController = TextEditingController();

  var dio = Dio();
  BookHotelModel? bookHotelModel;

  @override
  void initState() {
    super.initState();
    firstdateController.text = "";
    lastdateController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0Xff4f3268) ,
        title: const Text("Reservation Pets in Our Hotel ",
       // style: Tex,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
                controller: firstdateController,
                decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today,color: Color(0Xff4f3268),), labelText: "First Date"),
                readOnly: true, // when true user cannot edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101));
                      ((context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                background: Color(0xffffccb3),

                primary: Color(0xFFD61C4E), // <-- SEE HERE
                onPrimary: Color(0xFFFEF9A7), // <-- SEE HERE
                onSurface: Color(0xFFD61C4E),
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(foregroundColor: Color(0xFFD61C4E)),
              ),
            ),
            child: child!,
          );
        });
                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('MM-dd-yyyy').format(pickedDate);
                    setState(() {
                      firstdateController.text = formattedDate;
                      lastdateController.text = firstdateController.text;
                    });
                  } else {
                    print("First Date is not selected");
                  }
                }),
            const SizedBox(height: 10),
            TextField(
                controller: lastdateController,
                decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today,color: Color(0Xff4f3268),), labelText: "Last Date"),
                readOnly: true, // when true user cannot edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101));
                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('MM-dd-yyyy').format(pickedDate);
                    setState(() {
                      lastdateController.text = formattedDate;
                    });
                  } else {
                    print("Last Date is not selected");
                  }
                }),
            const SizedBox(height:50),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Color(0Xff4f3268),
              ),
              child: MaterialButton(
                onPressed: () {
                  book(firstdateController.text, lastdateController.text);
                  firstdateController.text = "";
                  lastdateController.text = "";

showDialog(context: context, builder: (BuildContext context){
     return AlertDialog(
  backgroundColor:Color.fromARGB(255, 255, 210, 225),
                                              icon: Icon(FontAwesomeIcons.cat,color: Color(0xFF4F3268),),
                                              title:
                                                  Text('Welcome Your Pet In Hotel',
                                                  textAlign: TextAlign.center,
             style: TextStyle(
                  fontSize: 22.0, fontWeight: FontWeight.w600),
                                                  
                                                  ),
  //content: Text("Save successfully"),
);
    });
             
                 











                },
                
                child: const Text(
                  'Book',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  book(firstdate, lastdate) async {
    try {
      return await dio.post(
        ('http://192.168.1.3:3005/bookhotel/add'),
        data: {
          "user":CurrentUser.userId,
          "firstdate": firstdateController.text,
          "lastdate": lastdateController.text
        },
      );
    } on DioError catch (e) {
      print(e);
      return;
    }
  }
}
