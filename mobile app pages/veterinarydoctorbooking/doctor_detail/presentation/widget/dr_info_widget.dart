import 'package:flutter/material.dart';

class drInfoWidget extends StatelessWidget {
  const drInfoWidget({
    super.key,
    required this.iconData,
    required this.title,
    required this.value,
  });

  final IconData iconData;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Color.fromRGBO(214, 28, 78, 1.000),
      width: MediaQuery.of(context).size.width * 0.2,
      decoration: BoxDecoration(
        color: Color.fromRGBO(79,35,104,1.000),
        border:
            Border.all(color: Color.fromARGB(255, 247, 113, 144), width: 2.5),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(iconData, color: Colors.white),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 17),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ],
      ),
    );
  }
}
