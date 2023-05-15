import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marahsebaproject/models/doctors.dart';
import 'package:marahsebaproject/utils/Constants.dart';
import 'package:marahsebaproject/veterinarydoctorbooking/doctor_detail/presentation/widget/dr_info_widget.dart';
import 'package:marahsebaproject/veterinarydoctorbooking/mbooking/presentation/booking_screen.dart';

class DoctorDetails extends StatefulWidget {
  DoctorDetails({
    super.key,
    required this.doctorsModel,
  });
  final DoctorsModel doctorsModel;
  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  DoctorsModel? doctorsModel;

  int? adoptionId;

  @override
  Widget build(BuildContext context) {
    DoctorsModel doctorsModel =
        ModalRoute.of(context)!.settings.arguments as DoctorsModel;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 180, 216, 253),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Doctor details',
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
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
                              '$baseUrl/uploads/${doctorsModel.image}'),
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
                        drInfoWidget(
                          iconData: Icons.article,
                          title: "Exp",
                          value: doctorsModel.exp.toString(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            drInfoWidget(
                              iconData: Icons.stars_rounded,
                              title: "Rating",
                              value: doctorsModel.rating.toString(),
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
                      'Doctor Name : ',
                      style: TextStyle(
                          color: Color.fromRGBO(79, 35, 104, 1.000),
                          fontSize: 27,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      doctorsModel.name!,
                      style: TextStyle(
                          color: Color.fromARGB(255, 247, 113, 144),
                          fontSize: 27,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Divider(
                  height: 30,
                  color: Color.fromRGBO(79, 35, 104, 1.000),
                ),
                Text(
                  "Description",
                  style: TextStyle(
                      color: Color.fromRGBO(79, 35, 104, 1.000),
                      fontSize: 27,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  doctorsModel.description!,
                  style: TextStyle(
                      color: Color.fromARGB(255, 247, 113, 144), fontSize: 20),
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
                builder: (context) => MovieBookingScreen(
                  doctorsModel: doctorsModel,
                ),
                settings: RouteSettings(
                  arguments: doctorsModel,
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(79, 35, 104, 1.000),
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
