import 'package:flutter/material.dart';

import 'dart:io';

import 'package:flutter/services.dart';

import 'PrefData.dart';

// Colors
const kTextColor = Color(0xFF535353);
const kTextLightColor = Color(0xffd61c4e);
const blackt = Color(0xff000000);

//const kPrimaryColor = Color(0xFFFF7643);
const kDefaultPaddin = 20.0;
////
const kBackgroundColor = Color(0xF2F2F2F2);
const kPrimaryColor = Color(0xFFD61C4E);
const kSecondaryColor = Color(0xFFFAC213);
const KTextColor = Color(0xFF181818);
var kWhiteColor = Color(0xffffffff);
var kOrangeColor = Color(0xffffccb3);
var kBlueColor = Color(0xff4B7FFB);
var kYellowColor = Color(0xffb3ffae);
var kTitleTextColor = Color(0xfffac213);
var kSearchBackgroundColor = Color(0xffF2F2F2);
var kSearchTextColor = Color(0xffC0C0C0);
var kCategoryTextColor = Color(0xff292685);
var kpink = Color(0xffd61c4e);
var koo = Color(0xfff77e21);
var kg = Color(0xff455a64);

var kb = Color(0xff000000);

Color borderColor = "#455A64".toColor();
Color primaryColor = "#7A6DB7".toColor();
Color alphaColor = "#F9F8FF".toColor();
// Color primaryColor = "#7F3C8A".toColor();
Color lightCellColor = "#EBEFF5".toColor();

Color darkBackgroundColor = "#14181E".toColor();
Color darkCellColor = "#2B2B2B".toColor();
Color themePrimaryColor = "#E4E6ED".toColor();
Color themeBackgroundColor = "#7F3C8A".toColor();
Color themeCellColor = "#7F3C8A".toColor();
Color textColor = Colors.black87;
Color subTextColor = "#455A64".toColor();
Color backgroundColor = Color.fromRGBO(254, 249, 167, 1.000);
Color cellColor = "#F9F9FC".toColor();
// Color cellColor = "#E2E7F1".toColor();
Color accentColor = "#7F3C8A".toColor();
Color iconColor = "#7F3C8A".toColor();
Color defBgColor = "#F4F4F4".toColor();
String fontFamily = "SansSerif";
String customFontFamily = "Gilroy";
String assetsPath = "assets/img/";

const double avatarRadius = 40;
const double padding = 20;

setThemePosition({BuildContext? context = null}) async {
  bool isNightMode = await PrefData.getNightTheme();

  if (context != null) {
    ThemeData themeData = Theme.of(context);

    primaryColor = themeData.primaryColor;
    backgroundColor = themeData.backgroundColor;
    accentColor = themeData.primaryColor;
  }

  if (isNightMode) {
    textColor = Colors.white;
    subTextColor = Colors.white70;
    iconColor = Colors.grey.shade500;
    defBgColor = Colors.black87;
  } else {
    textColor = Colors.black;
    subTextColor = '#79757F'.toColor();
    iconColor = "#C4CDDE".toColor();
    defBgColor = "#F4F4F4".toColor();
  }
}

extension ColorExtension on String {
  toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}

void exitApp() {
  if (Platform.isIOS) {
    exit(0);
  } else {
    SystemNavigator.pop();
  }
}

String baseUrl = 'http://192.168.1.3:3005';

final String tableCartProduct = 'CartProduct';
final String columnName = 'name';
final String columnImage = 'image';
final String columnQuantity = 'quantity';
final String columnPrice = 'price';
final String columnProductId = 'productId';

final String tableFavourite = 'Favourite';
final String columnFavName = 'name';
final String columnFavImage = 'image';
final String columnFavPrice = 'price';
final String columnFavProductId = 'productId';

const CACHED_USER_DATA = 'CACHED_USER_DATA';

const kTileHeight = 50.0;
const inProgressColor = Colors.black87;
const todoColor = Color(0xffd1d2d7);
