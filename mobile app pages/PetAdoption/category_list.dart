import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marahsebaproject/PetAdoption/data.dart';
import 'package:marahsebaproject/PetAdoption/pet_widget.dart';

class CategoryList extends StatelessWidget {
  final Category category;

  CategoryList({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(254, 249, 167, 1.000),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          (category == Category.DOG
                  ? "Dog"
                  : category == Category.CAT
                      ? "Cat"
                      : category == Category
                          ? ""
                          : "Dog") +
              " Category",
          style: TextStyle(
            color: Colors.grey[800],
          ),
        ),
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
        actions: [], systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
          /*Container(
            height: 280,
            child: GridView(
              physics: BouncingScrollPhysics(),
              //scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 10),
              children:
                  getPetList().where((i) => i.category == category).map((item) {
                return PetWidget(
                  pet: item,
                  index: 0,
                );
              }).toList(),
            ),
          ),*/
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2),
              child: GridView.count(
                physics: BouncingScrollPhysics(),
                childAspectRatio: 0.8,
                crossAxisCount: 2,
                crossAxisSpacing: 3,
                mainAxisSpacing: 10,
                children: getPetList()
                    .where((i) => i.category == category)
                    .map((item) {
                  return PetWidget(
                    pet: item,
                    index: 0,
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
