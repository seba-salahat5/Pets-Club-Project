import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marahsebaproject/MainPage.dart';
import 'package:marahsebaproject/PetAdoption/adoptionAddForm.dart';
import 'package:marahsebaproject/PetAdoption/data.dart';
import 'package:marahsebaproject/PetAdoption/pet_detail.dart';
import 'package:marahsebaproject/PetAdoption/pet_widget.dart';
import 'package:marahsebaproject/PetAdoption/category_list.dart';
import 'package:marahsebaproject/models/Adoption.dart';
import 'package:marahsebaproject/utils/constants.dart';

class AllPets extends StatefulWidget {
  @override
  _AllPetsState createState() => _AllPetsState();
}

class _AllPetsState extends State<AllPets> {
  List<Pet> pets = getPetList();
  @override
  Widget build(BuildContext context) {
    setState(() {
      AdoptionModel.getAdoptions();
    });

    return Scaffold(
        backgroundColor: Color(0xF2F2F2F2),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(0, 185, 106, 106),
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
            future: AdoptionModel.getAdoptions(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Find Your",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AddAdoption()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  color: Color(0Xff9fc9f3),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Icon(
                                Icons.add,
                                color: Color(0xF2F2F2F2),
                                size: 35,
                                
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                      child: Text(
                        "Lovely pet in anywhere",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: kDefaultPaddin,
                            crossAxisSpacing: kDefaultPaddin,
                            childAspectRatio: 0.75,
                          ),
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            AdoptionModel adoptionModel = snapshot.data[index];

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PetDetail(
                                      adoptionModel: adoptionModel,
                                    ),
                                    settings: RouteSettings(
                                      arguments: adoptionModel,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                  width: 150,
                                  height: 120,
                                  padding: EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 255, 160, 191),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(children: [
                                    const SizedBox(height: 10),
                                    Expanded(
                                      flex: 4,
                                      child: Image.network(
                                        '$baseUrl/uploads/${adoptionModel.petImage}',
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                            adoptionModel.name.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Colors.black
                                                    ))),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Row(
                                              children: [
                                                Icon(Icons.location_pin,
                                                    //color: Color(0Xff9fc9f3),
                                                  color:Colors.white,
                                                  //size: 4,
                                                    ),
                                                Text(
                                                    adoptionModel.location
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                        color: Color.fromARGB(
                                                            255,
                                                            111,
                                                            180,
                                                            248))),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(),
                                                color: Color(0Xff9fc9f3),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Icon(
                                              Icons.add,
                                              color: Color(0xF2F2F2F2),
                                              size: 25,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ])),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              }
            }));
  }

  Widget buildPetCategory(Category category, String total, Color color) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryList(category: category)),
          );
        },
        child: Container(
          height: 80,
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Row(
            children: [
              Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(0.5),
                ),
                child: Center(
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: Image.asset(
                      "assets/img/" +
                          (category == Category.CAT ? "cat_1" : "dog") +
                          ".png",
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    category == Category.CAT ? "Cats" : "Dogs",
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildNewestPet() {
    List<Widget> list = [];
    for (var i = 0; i < pets.length; i++) {
      if (pets[i].newest) {
        list.add(PetWidget(pet: pets[i], index: i));
      }
    }
    return list;
  }
}
