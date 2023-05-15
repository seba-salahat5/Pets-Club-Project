import 'package:flutter/material.dart';
import 'package:marahsebaproject/MainPage.dart';
import 'package:marahsebaproject/hotelpet/bookhotel.dart';
import 'package:marahsebaproject/utils/CustomWidget.dart';
import 'package:marahsebaproject/utils/constants.dart';

class HotelWidget extends StatefulWidget {
  final Function? function;

  HotelWidget({this.function});
  @override
  _HotelWidgetState createState() => _HotelWidgetState();
}

class _HotelWidgetState extends State<HotelWidget> {
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(2022, 11, 5),
    end: DateTime(2022, 12, 24),
  );

  String startText = "Starting Date";
  String endText = "Ending Date";

  Future<bool> _requestPop() {
    if (widget.function != null) {
      widget.function!();
    } else {
      Navigator.of(context).pop();
    }

    return new Future.value(true);
  }

  void doNothing(BuildContext context) {}
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            backgroundColor: Color(0xFFF2F2F2),
            body: Container(
                padding: EdgeInsets.only(left: 10, right: 10, top: 35),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    getAppBar(context, "Pets Hotel", isBack: true,
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
                          child: getSubMaterialCell(
                            context,
                          ),
                        )),
                    Image.asset(assetsPath + "back4.png"),
                    //SizedBox(height: 200),
                    const SizedBox(height: 30),
                    Text(
                      'Choose the days you want the pet to stay at the hotel.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff9d78be)),
                    ),
                    const SizedBox(height: 140),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            child: Text(
                              'Calender',
                              style:
                                  TextStyle(fontSize: 22, color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookHotel(),
                                ));
                             
                            },
                            style: ElevatedButton.styleFrom(
                             // padding: const EdgeInsets.symmetric(vertical: 14), backgroundColor: Color(0Xff4f3268),
                            //  shape: const StadiumBorder(),
                            backgroundColor: Color.fromRGBO(79,35,104,1.000),
                            //  elevation: 8,
                              padding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 20),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
    ),
                              shadowColor: Color(0Xff4f3268),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Container(
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(12),
                    //       color: Colors.white,
                    //       boxShadow: [
                    //         // BoxShadow(
                    //         //   color: Colors.grey.withOpacity(0.5),
                    //         //   spreadRadius: 5,
                    //         //   blurRadius: 7,
                    //         //   offset: Offset(0, 3),
                    //         // ),
                    //       ],
                    //     ),
                    //     // child: Container(
                    //     //   decoration: const BoxDecoration(
                    //     //       color: Color(0xFFD61C4E),
                    //     //       borderRadius: BorderRadius.only(
                    //     //         topRight: Radius.circular(12),
                    //     //         topLeft: Radius.circular(12),
                    //     //       )),
                    //     //   child: Column(
                    //     //     children: [
                    //     //       Container(
                    //     //         child: Text(
                    //     //           "We Welcome Your Pet",
                    //     //           style: TextStyle(
                    //     //               fontSize: 17,
                    //     //               color: Colors.white,
                    //     //               fontWeight: FontWeight.bold),
                    //     //           textAlign: TextAlign.center,
                    //     //         ),
                    //     //         padding: const EdgeInsets.all(12),
                    //     //         width: MediaQuery.of(context).size.width,
                    //     //         height:
                    //     //             MediaQuery.of(context).size.height - 710,
                    //     //       ),
                    //     //       Container(
                    //     //         decoration: const BoxDecoration(
                    //     //             color: Color(0xffffccb3),
                    //     //             borderRadius: BorderRadius.only(
                    //     //               topRight: Radius.circular(12),
                    //     //               topLeft: Radius.circular(12),
                    //     //             )),
                    //     //         child: Text(
                    //     //           'From ' +
                    //     //               '${start.year}/${start.month}/${start.day}' +
                    //     //               ' To ' +
                    //     //               '${end.year}/${end.month}/${end.day}',
                    //     //           textAlign: TextAlign.center,
                    //     //           style: TextStyle(
                    //     //               fontSize: 17,
                    //     //               color: Color.fromARGB(255, 133, 8, 41),
                    //     //               fontWeight: FontWeight.bold),
                    //     //         ),
                    //     //         padding: const EdgeInsets.all(12),
                    //     //         width: MediaQuery.of(context).size.width,
                    //     //         height:
                    //     //             MediaQuery.of(context).size.height - 700,
                    //     //       ),
                    //     //     ],
                    //     //   ),
                    //     // )
                    //     )
                  ],
                ))),
        onWillPop: _requestPop);
  }


}
