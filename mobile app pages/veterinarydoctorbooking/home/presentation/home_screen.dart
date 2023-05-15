import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marahsebaproject/MainPage.dart';
import 'package:marahsebaproject/models/doctors.dart';
import 'package:marahsebaproject/utils/Constants.dart';
import 'package:marahsebaproject/veterinarydoctorbooking/doctor_detail/presentation/dr_detail_screen.dart';
import 'package:marahsebaproject/veterinarydoctorbooking/home/presentation/widget/banner_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    setState(() {
      DoctorsModel.getDoctors();
    });

    return Scaffold(
      backgroundColor: Color(0Xfff2f2f2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainPage()),
            );
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 30,
            color: Colors.black,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: FutureBuilder(
          future: DoctorsModel.getDoctors(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                  ),
                  const SizedBox(height: 1),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Center(
                      child: Text(
                        "Pet Veterinary",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 29),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: BannerWidget(),
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      "",
                      style: TextStyle(
                          color: Color.fromRGBO(214, 28, 78, 1.000),
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          DoctorsModel doctorsModel = snapshot.data[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DoctorDetails(doctorsModel: doctorsModel,),
                                  settings: RouteSettings(
                                    arguments: doctorsModel,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                                width: 180,
                                height: 130,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(children: [
                                  Expanded(
                                    flex: 4,
                                    child: Image.network(
                                      '$baseUrl/uploads/${doctorsModel.image}',
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                         child: Row(
                                          children: [  Text(
                                              doctorsModel.clinicName
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: Colors.black)),
                                                  SizedBox(width: 15),
                                                   Image.asset(
                                                      "assets/img/right-arrow.png"),
                                                
                                                  ],
                                         ),
                                                  
                                        ),
                                        
                                      ],
                                    ),
                                  ),
                                ])),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(
                          width: 10,
                        ),
                        // children: buildNewestPet(),
                      ),
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }
}
