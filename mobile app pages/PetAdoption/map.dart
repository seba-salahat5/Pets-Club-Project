
// import 'dart:async';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geocoding/geocoding.dart';


// class map2 extends StatefulWidget {
//   const map2({Key? key}) : super(key: key);

//   @override
//   State<map2> createState() => map2State();
// }

// class map2State extends State<map2> {
//    late Position c1;
//    var lat;
//    var long;
//     late CameraPosition _kGooglePlex;

//   Future getper()async{
//     bool services ;
//     LocationPermission per;

//     services=await Geolocator.isLocationServiceEnabled();
//     if(services==false){
//       AwesomeDialog(
//         title: 'services',
//         body: Text('services not enabelled'), context: context,
//       )
//       ..show();
//     }
//     per= await Geolocator.checkPermission();
//     if(per== LocationPermission.denied){
//     per= await Geolocator.requestPermission();
//     Navigator.pushNamed(context, 'backmap');

//     }
//     print("+++++++++++++++++++++++");
//     print(per);
//     print("+++++++++++++++++++++++");
//     return per;
//     }

//     Future<void>getLatAndLong()async{
//     c1= await Geolocator.getCurrentPosition().then((value) => value);
//     lat=c1.latitude;
//     long=c1.longitude;
//     _kGooglePlex = CameraPosition(
//       target: LatLng(lat,long),
//       zoom: 14.4746,
//     );

//     setState(() {

//     });//عشان ياخد القيم بعد التحديثات
//     }
//     @override
//     void initState() {
//     getper();
//     getLatAndLong();
//     // TODO: implement initState
//     super.initState();
//   }

//    late GoogleMapController gmc;
//   late Set<Marker> mymarker ={
//     Marker(markerId: MarkerId('3'),infoWindow:InfoWindow(title: "current location"),
//         position: LatLng(lat,long)),
//     Marker(markerId: MarkerId('1'),infoWindow:InfoWindow(title: "فرع 1"),
//         position: LatLng(32.239075, 35.245778)),
//     Marker(markerId: MarkerId('2'),infoWindow: InfoWindow(title: "فرع2"),
//         position: LatLng(32.225163, 35.241482)),

//   };


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   elevation: 0,
//       //   backgroundColor: AppColors.white,
//       //   leading: IconButton(
//       //       onPressed: () {},
//       //       icon: Icon(Icons.menu, color: AppColors.red)),
//       //   actions: [
//       //   ],
//       // ),
//       body: Column(
//         children: [
//           _kGooglePlex == null ? CircularProgressIndicator() :
//           Container(
//             height: 500,width: 400,
//             child: GoogleMap(
//               markers: mymarker,
//               mapType: MapType.normal,
//               myLocationEnabled: true,
//               initialCameraPosition: _kGooglePlex,
//               onMapCreated: (GoogleMapController controller) {
//                         gmc=controller;
//               },
         
//             ),

//           ),
//           ElevatedButton(onPressed: () async {
//             LatLng latLng=LatLng(32.239075, 35.245778);
//             gmc.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: latLng,zoom:17)));


//             // c1=await getLatAndLong();
//             // print("Lat ${c1.latitude}");
//             // print("Long ${c1.longitude}");
//             // List<Placemark>placemarkes=
//             //     await placemarkFromCoordinates(c1.latitude, c1.longitude);
//             // print(placemarkes[0]);
//           }, child: Text("Go To pets ")
//           )
//         ],
//       ),);
//   }}

//   //AIzaSyC6T7p0pE5r8uRbS0CPWnr1mSCbZc2ZHqE