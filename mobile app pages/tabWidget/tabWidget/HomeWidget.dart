import 'package:carousel_slider/carousel_slider.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:marahsebaproject/MainPage.dart';
import 'package:marahsebaproject/PetAdoption/AllPet.dart';
import 'package:marahsebaproject/PetAdoption/data.dart';
import 'package:marahsebaproject/PetAdoption/pet_widget.dart';
import 'package:marahsebaproject/findlostpet/activity_feed.dart';
import 'package:marahsebaproject/findlostpet/timeline.dart';
import 'package:marahsebaproject/hotelpet/hotel.dart';
import 'package:marahsebaproject/productscreen/shoppage2.dart';
import 'package:marahsebaproject/gromming/home/presentation/homegrom.dart';
import 'package:marahsebaproject/hotelpet/bookhotel.dart';
import 'package:marahsebaproject/utils/CustomWidget.dart';
import 'package:marahsebaproject/utils/constants.dart';
import 'package:marahsebaproject/veterinarydoctorbooking/home/presentation/home_screen.dart';

class HomeWidget extends StatefulWidget {
  final Function function;
  final Function? functionViewAll;
  final Function? functionAdoptionAll;

  HomeWidget(this.function, {this.functionViewAll, this.functionAdoptionAll});

  @override
  _HomeWidget createState() {
    return _HomeWidget();
  }
}

class _HomeWidget extends State<HomeWidget> {
  double defMargin = 0;
  double padding = 0;
  double height = 0;

  FocusNode myFocusNode = FocusNode();
  bool isAutoFocus = false;
  List<Pet> pets = getPetList();

  @override
  Widget build(BuildContext context) {
    defMargin = getHorizontalSpace(context);
    padding = getScreenPercentSize(context, 2);
    height = getScreenPercentSize(context, 5.7);
    double btnHeight = getScreenPercentSize(context, 13);

    return Container(
      color: Color(0xF2F2F2F2),
      padding: EdgeInsets.only(top: getScreenPercentSize(context, 2)),
      child: GestureDetector(
        onTap: () {
          setState(() {
            myFocusNode.canRequestFocus = false;
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getAppBar(),
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: defMargin,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: defMargin,
                      ),
                      SizedBox(
                        width: (defMargin),
                      ),
                    ],
                  ),
                  getSlider(),
                  SizedBox(height: getScreenPercentSize(context, 3)),
                  getTitle('Our Picks for you',
                      function: widget.functionAdoptionAll!),
                  //SizedBox(
                  //  height: getScreenPercentSize(context, 3),
                  //),    
                  gridList(),
                
                  SizedBox(
                    height: getScreenPercentSize(context, 5),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                                Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Timeline(currentUser: currentUserFirebase,),
                                ));
                          },
                          child: getSubMaterialCell(
                            context,
                            widget: Container(
                              height: 120,
                              margin: EdgeInsets.only(
                                  left: defMargin, right: (defMargin / 2)),
                              decoration: getDecorationWithRadius(
                                  20, Color.fromARGB(255, 252, 169, 197)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    assetsPath + "pet-love.png",
                                    height: getPercentSize(btnHeight, 60),
                                  ),
                                  getTextWithFontFamilyWidget(
                                      'Go To The Club',
                                      textColor,
                                      getPercentSize(btnHeight, 15),
                                      FontWeight.w700,
                                      TextAlign.start)
                                ],
                              ),
                            ),
                          ),
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HotelWidget(),
                                ));
                          },
                          child: getSubMaterialCell(
                            context,
                            widget: Container(
                              height: 120,
                              margin: EdgeInsets.only(
                                  left: defMargin, right: (defMargin / 2)),
                              decoration: getDecorationWithRadius(
                                  20, Color.fromARGB(255, 169, 252, 224)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    assetsPath + "pet-hotel.png",
                                    height: getPercentSize(btnHeight, 60),
                                  ),
                                  getTextWithFontFamilyWidget(
                                      'Book In Pets Hotel',
                                      textColor,
                                      getPercentSize(btnHeight, 15),
                                      FontWeight.w700,
                                      TextAlign.start)
                                ],
                              ),
                            ),
                          ),
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                  SizedBox(height: 10,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  gridList() {
    return Container(
      height: 250,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: //buildNewestPet(),
        [
          Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
        ),
        margin: EdgeInsets.only(
            right: 18 ,
            left: 16,
            bottom: 16
            ),
        width: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/img/cat1.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Hack",
                    style: TextStyle(
                      color: Color(0xFF4F3268),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Image.asset("assets/img/location.png"),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "Nablus, ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
        ),
        margin: EdgeInsets.only(
            right: 18 ,
            left: 16,
            bottom: 16
            ),
        width: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/img/dog1.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Lala",
                    style: TextStyle(
                      color: Color(0xFF4F3268),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Image.asset("assets/img/location.png"),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "Nablus, ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    
    
    
        ]
      ),
    );
  }

  /*List<Widget> buildNewestPet() {
    List<Widget> list = [];
    for (var i = 0; i < pets.length; i++) {
      if (pets[i].newest) {
        list.add(PetWidget(pet: pets[i], index: i));
      }
    }
    return list;
  }*/

  RangeValues _currentRangeValues = const RangeValues(100, 1000);

  filterDialog1() {
    double height = getScreenPercentSize(context, 45);
    double radius = getScreenPercentSize(context, 3);
    double margin = getScreenPercentSize(context, 2);

    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius),
                topRight: Radius.circular(radius))),
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return FractionallySizedBox(
                heightFactor: 0.6,
                child: Container(
                  child: ListView(
                    children: <Widget>[
                      SizedBox(
                        height: margin,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: margin),
                        child: Row(
                          children: [
                            Expanded(
                              child: getTextWithFontFamilyWidget(
                                  'Filter',
                                  textColor,
                                  getPercentSize(height, 5),
                                  FontWeight.w500,
                                  TextAlign.start),
                              flex: 1,
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Icon(
                                  Icons.close,
                                  size: getPercentSize(height, 6),
                                  color: textColor,
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getPercentSize(height, 1),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: margin),
                        child: getTextWidget(
                            'Filter products with more specific types',
                            subTextColor,
                            getPercentSize(height, 3.5),
                            FontWeight.w400,
                            TextAlign.start),
                      ),
                      SizedBox(
                        height: getPercentSize(height, 4),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: margin),
                        child: getTextWithFontFamilyWidget(
                            'Price',
                            textColor,
                            getPercentSize(height, 4),
                            FontWeight.w500,
                            TextAlign.start),
                      ),
                      SizedBox(
                        height: getPercentSize(height, 2),
                      ),
                      RangeSlider(
                        values: _currentRangeValues,
                        min: 10,
                        max: 1000,
                        activeColor: primaryColor,
                        inactiveColor: primaryColor.withOpacity(0.5),
                        onChanged: (RangeValues values) {
                          setState(() {
                            _currentRangeValues = values;
                          });
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: margin),
                        child: Row(
                          children: [
                            Expanded(
                              child: getTextWidget(
                                  "\$50",
                                  primaryColor,
                                  getScreenPercentSize(context, 2),
                                  FontWeight.w600,
                                  TextAlign.start),
                            ),
                            getTextWidget(
                                "\$250",
                                primaryColor,
                                getScreenPercentSize(context, 2),
                                FontWeight.w600,
                                TextAlign.start),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getScreenPercentSize(context, 3),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: margin),
                        child: getTextWithFontFamilyWidget(
                            'Brand',
                            textColor,
                            getPercentSize(height, 4),
                            FontWeight.w500,
                            TextAlign.start),
                      ),
                      SizedBox(
                        height: getPercentSize(height, 2),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: margin),
                      ),
                      SizedBox(
                        height: getPercentSize(height, 10),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: margin),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: getMaterialCell(context,
                                    widget: Container(
                                      margin: EdgeInsets.only(
                                          right:
                                              getWidthPercentSize(context, 3)),
                                      height: getScreenPercentSize(context, 7),
                                      decoration: ShapeDecoration(
                                        color: alphaColor,
                                        shape: SmoothRectangleBorder(
                                          side: BorderSide(
                                              color: primaryColor, width: 2),
                                          borderRadius: SmoothBorderRadius(
                                            cornerRadius: getScreenPercentSize(
                                                context, 1.8),
                                            cornerSmoothing: 0.8,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                        child: getTextWidget(
                                            'Reset',
                                            textColor,
                                            getScreenPercentSize(context, 2),
                                            FontWeight.bold,
                                            TextAlign.center),
                                      ),
                                    )),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: getMaterialCell(context,
                                    widget: Container(
                                      margin: EdgeInsets.only(
                                          left:
                                              getWidthPercentSize(context, 3)),
                                      height: getScreenPercentSize(context, 7),
                                      decoration: ShapeDecoration(
                                        color: primaryColor,
                                        shape: SmoothRectangleBorder(
                                          borderRadius: SmoothBorderRadius(
                                            cornerRadius: getScreenPercentSize(
                                                context, 1.8),
                                            cornerSmoothing: 0.8,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                        child: getTextWidget(
                                            'Apply',
                                            Colors.white,
                                            getScreenPercentSize(context, 2),
                                            FontWeight.bold,
                                            TextAlign.center),
                                      ),
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getPercentSize(height, 10),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  getTitle(String s, {Function? function}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defMargin),
      child: Row(
        children: [
          Expanded(
            child: getTextWithFontFamilyWidget(
                s,
                textColor,
                getScreenPercentSize(context, 2),
                FontWeight.w500,
                TextAlign.start),
          ),
          InkWell(
           onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllPets(),
                  ));
            },
            child: getTextWidget(
                'View All',
                primaryColor,
                getScreenPercentSize(context, 1.6),
                FontWeight.w500,
                TextAlign.start),
          )
        ],
      ),
    );
  }

  getAppBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: defMargin),
      child: Row(
        children: [
          Expanded(
            child: Image.asset(
              assetsPath + "logo3.png",
              height: getScreenPercentSize(context, 7),
              alignment: Alignment.centerLeft,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ActivityFeed(),
                  ));
            },
            child: Image.asset(
              assetsPath + "bell.png",
              height: getScreenPercentSize(context, 2.5),
              
            ),
          ),
        ],
      ),
    );
  }

  getSlider() {
    double sliderHeight = getScreenPercentSize(context, 20);
    return Container(
      width: double.infinity,
      height: sliderHeight,
      child: CarouselSlider.builder(
        itemCount: 5,
        options:
            CarouselOptions(autoPlay: true, onPageChanged: (index, reason) {}),
        itemBuilder: (context, index, realIndex) {
          Color color = Color(0xFFD61C4E);

          if (index == 0) {
            color = Color(0xFF9D78BE);
            return getBanner(sliderHeight, 'Veterinary-amico.png', color,
                "Search For\nVeterinary Center", HomeScreen());
          } else if (index == 2) {
            color = Color.fromARGB(255, 252, 169, 197);
            return getBanner(sliderHeight, 'Cat and dog-pana.png', color,
                "for Grooming", HomegScreen());
          } else if (index == 3) {
            color = Color.fromARGB(255, 169, 252, 224);
            return getBanner(sliderHeight, 'Cat and dog-amico.png', color,
                "Food And \nAccessories Sotre", ShopScreen());
          } else if (index == 4) {
            color = Color(0xFFF9CA99);
            return getBanner(sliderHeight, 'Animal shelter-bro.png', color,
                "Adopt A Friend", AllPets());
          } else {
            return getBanner(sliderHeight, 'pet_6.png', color,
                "Welcome To Pets CLub", MainPage());
          }
        },
      ),
    );
  }

  getBanner(
      double height, String img, Color color, String text, Widget nextPage) {
    double width = double.infinity;

    double radius = getPercentSize(height, 7);

    return GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => nextPage,
              ));
        },
        child: new Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomRight,
              colors: [color, color.withOpacity(0.9), color.withOpacity(0.2)],
            ),
          ),
          margin: EdgeInsets.symmetric(
              vertical: defMargin, horizontal: (padding / 2)),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: EdgeInsets.all(getPercentSize(height, 2)),
                  child: Image.asset(
                    assetsPath + img,
                    width: getWidthPercentSize(context, 42),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: padding),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      getCustomTextWithFontFamilyWidget(
                          text,
                          Colors.white,
                          getPercentSize(height, 11),
                          FontWeight.w500,
                          TextAlign.start,
                          2),
                      /*OutlinedButton(
                    child: Text(
                      "Visit Page",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShopPage(),
                          ));
                    },
                  ),*/
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
