// ignore_for_file: unused_element, unused_local_variable
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:marahsebaproject/MainPage.dart';
import 'package:marahsebaproject/models/currentUser.dart';
import 'package:marahsebaproject/models/doctors.dart';
import 'package:marahsebaproject/core/utils/date_time_extension.dart';
import 'package:marahsebaproject/veterinarydoctorbooking/mbooking/presentation/widget/date_widget.dart';
import 'package:marahsebaproject/veterinarydoctorbooking/mbooking/presentation/widget/time_widget.dart';
import 'package:http/http.dart' as http;

class MovieBookingScreen extends StatefulWidget {
  const MovieBookingScreen({super.key, required this.doctorsModel});
  final DoctorsModel doctorsModel;
  @override
  State<MovieBookingScreen> createState() => _MovieBookingScreenState();
}

class _MovieBookingScreenState extends State<MovieBookingScreen> {
  final selectedSeat = ValueNotifier<List<String>>([]);
  final selectedDate = ValueNotifier<DateTime>(DateTime.now());
  final selectedTime = ValueNotifier<TimeOfDay?>(null);

  @override
  Widget build(BuildContext context) {
    docBooking(String date, String id, String time) async {
      var url = "http://192.168.1.3:3005/doctor/boking";
      var data = {
        "dateTime": selectedDate.value.simpleDate + time,
        "docId": id.toString(),
        "userId": CurrentUser.userId.toString()
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

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Color.fromARGB(255, 255, 198, 217),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
             Icons.arrow_back_ios,
              size: 30,
              color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color.fromARGB(255, 255, 198, 217),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder<List<String>>(
            valueListenable: selectedSeat,
            builder: (context, value, _) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        " Make a Reservation",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                  ],
                ),
              );
            },
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(48),
                ),
                color: Colors.white,
              ),
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select the appropriate day",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(159,201,243,1.000),
                      fontSize: 26,
                    ),
                  ),
                  ValueListenableBuilder<DateTime>(
                    valueListenable: selectedDate,
                    builder: (context, value, _) {
                      return SizedBox(
                        height: 96,
                        width: MediaQuery.of(context).size.width,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                            14,
                            (index) {
                              final date = DateTime.now().add(
                                Duration(days: index),
                              );
                              return InkWell(
                                onTap: () {
                                  selectedDate.value = date;
                                  print(date.simpleDate.toString());
                                },
                                child: DateWidget(
                                  date: date,
                                  isSelected:
                                      value.simpleDate == date.simpleDate,
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  const Text(
                    "Select the appropriate time",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(159,201,243,1.000),
                      fontSize: 26,
                    ),
                  ),
                  ValueListenableBuilder<TimeOfDay?>(
                    valueListenable: selectedTime,
                    builder: (context, value, _) {
                      return SizedBox(
                        height: 48,
                        width: MediaQuery.of(context).size.width,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                            8,
                            (index) {
                              final time = TimeOfDay(
                                hour: 10 + (index * 2),
                                minute: 0,
                              );
                              return InkWell(
                                onTap: () {
                                  selectedTime.value = time;
                                  print(time);
                                },
                                child: TimeWidget(
                                  time: time,
                                  isSelected: value == time.toString(),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      
                      Expanded(

                        child: Container(
              //              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
              //             decoration: BoxDecoration(
                            
              //               color: Color.fromRGBO(79,35,104,1.000),
              // borderRadius: BorderRadius.circular(50),
              //             ),
                          padding: const EdgeInsets.all(14),
                          alignment: Alignment.center,
                          
                          child: ElevatedButton(
                               style: ElevatedButton.styleFrom( foregroundColor: Colors.white, backgroundColor: Color.fromRGBO(79,35,104,1.000),
    padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
    ),),
                            onPressed: () {
                              docBooking(
                                  selectedDate.value.simpleDate,
                                  widget.doctorsModel.id.toString(),
                                  selectedTime.toString());
                            },
                            child: Text("Submit" ,style: TextStyle(
                  color: Colors.white,
                  fontSize:20,
                  fontWeight: FontWeight.bold),),
                            
                 
           
                          ),
                        
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
