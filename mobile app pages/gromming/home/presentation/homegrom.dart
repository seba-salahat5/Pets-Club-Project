import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marahsebaproject/MainPage.dart';
import 'package:marahsebaproject/gromming/home/presentation/widget/bb.dart';
import 'package:marahsebaproject/models/doctors.dart';
import 'package:marahsebaproject/models/grommers.dart';
import 'package:marahsebaproject/gromming/grom_detail/presentation/gdetail_screen.dart';
import 'package:marahsebaproject/utils/constants.dart';


class HomegScreen extends StatefulWidget {
  const HomegScreen({super.key});

  @override
  State<HomegScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomegScreen> {
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
          future: grommersModel.getgrommer(),
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
                        "Pet Grooming",
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
                    
                    child: BannergWidget(),
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
                          grommersModel gmodel = snapshot.data[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => grommDetails(gmodel:gmodel),
                                  settings: RouteSettings(
                                    arguments: gmodel,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                                width: 180,
                                height: 130,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color:Color(0Xff9fc9f3) ,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(children: [
                                  Expanded(
                                    flex: 4,
                                    child: Image.network(
                                      '$baseUrl/uploads/${gmodel.image}',
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
                                              gmodel.clinicgromName
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Color(0xFF4F3268))),
                                                  SizedBox(width: 15),
                                                   Image.asset(
                                                      "assets/img/turn-right-.png"),
                                                
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
