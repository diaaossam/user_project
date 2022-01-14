import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Color darkThemeColor = HexColor('333739');
const kPrimaryColor = Color(0xFFFF7643);
//const kPrimaryColor = Color(0xFF94DBFC);
const kPrimaryLightColor = Color(0xFFFFECDF);
final inActiveIconColor = Color(0xFFB6B6B6);

const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);
const kAnimationDuration = Duration(milliseconds: 200);