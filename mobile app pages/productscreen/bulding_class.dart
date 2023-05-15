
// class Building {
//   String? id;
//   String? name;
 

//   Building({this.id, this.name,});
// }


// RaisedButton(
//     color: Colors.purple[300],
//     child: Text(
//       "Network Giffy",
//       style: TextStyle(
//         color: Colors.white,
//       ),
//     ),
//     onPressed: () {
//       showDialog(
//           context: context,
//           builder: (_) => NetworkGiffyDialog(
//             image: Image.network(
//               "https://i.pinimg.com/originals/3d/36/c3/3d36c36a6bd147d3b65e4de86087f9f1.gif",
//               fit: BoxFit.cover,
//             ),
//             entryAnimation: EntryAnimation.BOTTOM_RIGHT,
//             title: Text(
//               'Team Work',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   fontSize: 22.0, fontWeight: FontWeight.w600),
//             ),
//             description: Text(
//               'Teamwork is the collaborative effort of a group to achieve a common goal or '
//                   'to complete a task in the most effective and efficient way. '
//                   'This library helps you easily create fancy giffy dialog.',
//               textAlign: TextAlign.center,
//             ),
//             buttonCancelColor:Colors.purple[300],
//             buttonOkColor:Colors.purple[300],
//             onOkButtonPressed: () {
//               Navigator.pop(context);
//             },
//           ));
//     }),