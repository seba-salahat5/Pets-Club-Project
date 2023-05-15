import 'package:flutter/material.dart';
import 'package:marahsebaproject/findlostpet/upload.dart';
import 'package:marahsebaproject/utils/CustomWidget.dart';
import 'package:marahsebaproject/utils/constants.dart';

AppBar header(context,
    {bool isAppTitle = false, String? titleText, removeBackButton = false}) {
      double height = getScreenPercentSize(context, 3);
  return AppBar(
    foregroundColor: Colors.black,
    automaticallyImplyLeading: removeBackButton ? false : true,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
                getTextWithFontFamilyWidget(
                  isAppTitle ? "Timeline" : titleText!,
                  textColor,
                  getScreenPercentSize(context, 3),
                  FontWeight.w500,
                  TextAlign.center),
                SizedBox(width: 100),
                InkWell(
              
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Upload(),
                            ));
                      },
                          
                          child: getSubMaterialCell(
                            context,
                            widget: Container(
                              alignment: Alignment.topRight,
                              height: height,
                              width: height,
                              decoration: getDecorationWithColor(
                                  getPercentSize(height, 25),
                                  Color(0xFF4F3268)),
                              child: Center(
                                child: Icon(Icons.add,
                                    color: Color(0xF2F2F2F2),
                                    size: getPercentSize(height, 70)),
                              ),
                            ),
                          ),
                        )

                        ]),
                        centerTitle: true,
                        backgroundColor: Color(0xF2F2F2F2),
                        
                      );
}