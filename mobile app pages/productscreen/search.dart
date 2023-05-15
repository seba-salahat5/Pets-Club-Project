// import 'package:flutter/material.dart';
// import 'package:marahsebaproject/productscreen/bulding_class.dart';

// class SearchList extends StatefulWidget {
//   SearchList({Key? key}) : super(key: key);
//   @override
//   _SearchListState createState() => _SearchListState();
// }

// class _SearchListState extends State<SearchList> {
//   Widget appBarTitle = Text(
//     "My Properties",
//     style: TextStyle(color: Colors.white),
//   );
//   Icon actionIcon = Icon(
//     Icons.search,
//     color: Colors.orange,
//   );
//   final key = GlobalKey<ScaffoldState>();
//   final TextEditingController _searchQuery = TextEditingController();
//   List<Building>? _list;
//   List<Building> _searchList = [];

//   bool? _IsSearching;
//   String _searchText = "";

//   // _SearchListState() {
//   //   _searchQuery.addListener(() {
//   //     if (_searchQuery.text.isEmpty) {
//   //       setState(() {
//   //         _IsSearching = false;
//   //         _searchText = "";
//   //         _buildSearchList();
//   //       });
//   //     } else {
//   //       setState(() {
//   //         _IsSearching = true;
//   //         _searchText = _searchQuery.text;
//   //         _buildSearchList();
//   //       });
//   //     }
//   //   });
//   // }
//   @override
//   void initState() {
//     super.initState();
//     _IsSearching = false;
//     init();
//   }

//   void init() {
//     _list = [];
//     _list?.add(
//       Building(id:"1", name: "A 1", ),
//     );
//     _list?.add(
//       Building(id:"2", name: "A 2",),
//     );
//     _list?.add(
//       Building(id:"3",name: "B 3",),
//     );
//     _list?.add(
//       Building(id:"4",name: "B 4", ),
//     );
//     _list?.add(
//       Building(id:"5",name: "C 5",),
//     );
//     _searchList = _list!;
//   }

//   @override
//   Widget build(BuildContext context) {
//     //SizeConfig().init(context);
//     return Scaffold(
//         key: key,
      
//         body: GridView.builder(
//             itemCount: _searchList.length,
//             itemBuilder: (context, index) {
//               return Uiitem(_searchList[index]);
//             },
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3,
//             )


//             ));
//   }

//   List<Building>? _buildList() {
//     return _list; //_list.map((contact) =>  Uiitem(contact)).toList();
//   }

//   List<Building> _buildSearchList() {
//     if (_searchText.isEmpty) {
//       return _searchList =
//           _list!; //_list.map((contact) =>  Uiitem(contact)).toList();
//     } else {
//       /*for (int i = 0; i < _list.length; i++) {
//         String name = _list.elementAt(i);
//         if (name.toLowerCase().contains(_searchText.toLowerCase())) {
//           _searchList.add(name);
//         }
//       }*/

//       _searchList = _list!
//           .where((element) =>
//               element.name!.toLowerCase().contains(_searchText.toLowerCase()) ||
//               element.place.toLowerCase().contains(_searchText.toLowerCase()))
//           .toList();
//       print('${_searchList.length}');
//       return _searchList; //_searchList.map((contact) =>  Uiitem(contact)).toList();
//     }
//   }

//   Widget buildBar(BuildContext context) {
//     return AppBar(
//         centerTitle: true,
//         title: appBarTitle,
//         iconTheme: IconThemeData(color: Colors.orange),
//         backgroundColor: Colors.black,
//         actions: <Widget>[
//           IconButton(
//             icon: actionIcon,
//             onPressed: () {
//               setState(() {
//                 if (this.actionIcon.icon == Icons.search) {
//                   this.actionIcon = Icon(
//                     Icons.close,
//                     color: Colors.orange,
//                   );
//                   this.appBarTitle = TextField(
//                     controller: _searchQuery,
//                     style: TextStyle(
//                       color: Colors.orange,
//                     ),
//                     decoration: InputDecoration(
//                         hintText: "Search here..",
//                         hintStyle: TextStyle(color: Colors.white)),
//                   );
//                   _handleSearchStart();
//                 } else {
//                   _handleSearchEnd();
//                 }
//               });
//             },
//           ),
//         ]);
//   }

//   void _handleSearchStart() {
//     setState(() {
//       _IsSearching = true;
//     });
//   }

//   void _handleSearchEnd() {
//     setState(() {
//       this.actionIcon = Icon(
//         Icons.search,
//         color: Colors.orange,
//       );
//       this.appBarTitle = Text(
//         "My Properties",
//         style: TextStyle(color: Colors.white),
//       );
//       _IsSearching = false;
//       _searchQuery.clear();
//     });
//   }
// }

// class Uiitem extends StatelessWidget {
//   final Building building;
//   Uiitem(this.building);

//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.fromLTRB(5, 5, 5, 7),
//       elevation: 10.0,
//       child: InkWell(
//         splashColor: Colors.orange,
//         onTap: () {
//           print(building.id);
//         },
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             AspectRatio(
//               aspectRatio: 18.0 / 11.0,
//               child: Image.asset(
//                 'assets/images/build.jpeg',
//                 fit: BoxFit.scaleDown,
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.fromLTRB(10.0, 15.0, 0.0, 0.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     this.building.name!,
//                     style: TextStyle(
//                         fontFamily: 'Raleway',
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14.0),
//                     maxLines: 1,
//                   ),
//                   SizedBox(height: 0.0),
                 
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:marahsebaproject/models/Product.dart';
import 'package:marahsebaproject/productscreen/test.dart';
import 'package:marahsebaproject/utils/constants.dart';

//import 'Api_service.dart';


class Searchp extends SearchDelegate {
  List<dynamic> listproduct = [];
  List<dynamic> listproductbycategore = [];
  List<dynamic> listcategore = [];
  String valcategory = "";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
     return Container(
      child: FutureBuilder(
              future: ProductModel.getCategorySearch(query: query),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                      ),
                   
                      const SizedBox(
                        height: 20,
                      ),
                      //Categories(),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                          child: GridView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: snapshot.data.length,
                              scrollDirection: Axis.vertical,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: kDefaultPaddin,
                                crossAxisSpacing: kDefaultPaddin,
                                childAspectRatio: 0.75,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                ProductModel productModel =
                                    snapshot.data[index];

                                listproductbycategore =
                                    listproduct.where((products) {
                                  return listproduct[index]['category']['name']
                                      .toLowerCase()
                                      .contains((valcategory.toLowerCase()));
                                }).toList();

                                return GestureDetector(
                                    onTap: (() {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailsPage(),
                                          settings: RouteSettings(
                                            arguments: productModel,
                                          ),
                                        ),
                                      );
                                    }),
                                    child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 212, 162, 255),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Column(children: [
                                          const SizedBox(height: 10),
                                          Expanded(
                                            flex: 5,
                                            child: Image.network(
                                                '$baseUrl/uploads/${productModel.productImage}'),
                                          ),
                                          const SizedBox(height: 10),
                                          Expanded(
                                              flex: 1,
                                              child: Text(
                                                  productModel.name.toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                      color:
                                                          Color(0xFF4F3268)))),
                                          const SizedBox(height: 10),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  child: Text(
                                                      productModel.price
                                                              .toString() +
                                                          ' \$',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                          color: Colors.black)),
                                                ),
                                                                                               Container(

                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  color: Color(0Xff4f3268),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Icon(
                                Icons.add,
                                color: Color(0xF2F2F2F2),
                                size: 25,
                                
                              ),
                            ),
                                             
                                              ],
                                            ),
                                          ),
                                        ])));
                              }),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
     );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Search Product'),
    );
  }
}


