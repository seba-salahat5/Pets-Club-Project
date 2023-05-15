import 'package:flutter/material.dart';
import 'package:marahsebaproject/productscreen/shoppage2.dart';

class CartAppBar extends StatelessWidget {
  const CartAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xF2F2F2F2),
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShopScreen()),
              );
              //Navigator.pop(context);
            },
            //child: Image.asset("assets/icons/backk.png"),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 30,
              color: Color(0xF2F2F2F2),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "             My Cart",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(214, 28, 78, 1.000),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
