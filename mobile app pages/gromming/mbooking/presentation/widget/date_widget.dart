import 'package:flutter/material.dart';
import 'package:marahsebaproject/core/utils/date_time_extension.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({
    super.key,
    required this.date,
    this.isSelected = false,
  });

  final DateTime date;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      decoration: BoxDecoration(
        color: isSelected ? Color.fromRGBO(159,201,243,1.000) : Color.fromARGB(255, 255, 177, 203).withOpacity(0.5),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            date.monthName,
            // style: Theme.of(context).textTheme.bodyMedium,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ?Color.fromRGBO(159,201,243,1.000) : Color.fromRGBO(79,35,104,1.000),
            ),
            padding: const EdgeInsets.all(8),
            child: Text(
              date.day.toString(),
              style: TextStyle(fontSize: 19, color: isSelected? Colors.black:Colors.white)
              // Theme.of(context)
              //     .textTheme
              //     .bodyMedium
              //     ?.copyWith(color: isSelected ? AppColor.black : null)
              ,
            ),
          ),
        ],
      ),
    );
  }
}
