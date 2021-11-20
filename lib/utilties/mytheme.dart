// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class Mytheme{
  static final ThemeData light=ThemeData(
    iconTheme: IconThemeData(
      color: Colors.white,

    ),
    primaryColor: MyColors.primaryc,
    backgroundColor: MyColors.backgroundc,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: MyColors.primaryc),
    fontFamily: GoogleFonts.lato().fontFamily,
  );
}

class MyColors{
  static final primaryc=HexColor("#e52165");
  static final backgroundc=HexColor("#0d1137");

}