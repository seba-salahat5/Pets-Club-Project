import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marahsebaproject/models/grommers.dart';
import 'package:marahsebaproject/gromming/mbooking/presentation/booking_screen.dart';
import 'package:marahsebaproject/utils/constants.dart';
import 'package:marahsebaproject/veterinarydoctorbooking/doctor_detail/presentation/widget/dr_info_widget.dart';

// ignore: camel_case_types
class grommDetails extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  grommDetails({
    super.key,
     required this.gmodel
  });
  final grommersModel gmodel;
  @override
  State<grommDetails> createState() => _grommDetailsState();
}

// ignore: camel_case_types
class _grommDetailsState extends State<grommDetails> {
  grommersModel? gmodel;

  int? adoptionId;

  @override
  Widget build(BuildContext context) {
    grommersModel gmodel =
        ModalRoute.of(context)!.settings.arguments as grommersModel;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 180, 216, 253),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          title:  Text(
            'Grooming Details',
            style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color.fromARGB(255, 180, 216, 253),
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
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              '$baseUrl/uploads/${gmodel.image}'),
                          fit: BoxFit.contain,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                         topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                    ),
                    SizedBox(width: 30),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // drInfoWidget(
                        //   iconData: Icons.article,
                        //   title: "Exp",
                        //   value: doctorsModel.exp.toString(),
                        // ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            drInfoWidget(
                              iconData: Icons.stars_rounded,
                              title: "Rating",
                              value: gmodel.rating.toString(),
                            ),
                            // Icon(Icons.star)
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'Groomer Name : ',
                      style: TextStyle(
                          color: Color.fromRGBO(79,35,104,1.000),
                          fontSize: 27,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      gmodel.name!,
                      style: TextStyle(
                          color: Color.fromARGB(255, 243, 72, 112),
                          fontSize: 27,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Divider(
                  height: 30,
                  color: Color.fromRGBO(79,35,104,1.000),
                ),
                Text(
                  "Description",
                  style: TextStyle(
                      color: Color.fromRGBO(79,35,104,1.000),
                      fontSize: 27,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  gmodel.description!,
                  style: TextStyle(
                      color: Color.fromARGB(255, 243, 72, 112), fontSize: 20),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => gBookingScreen(
                  gmodel: gmodel,  
                ),
                settings: RouteSettings(
                  arguments: gmodel,
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(79,35,104,1.000),
              borderRadius: BorderRadius.circular(50),
            ),
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            child: Text(
              "Booking Now",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
