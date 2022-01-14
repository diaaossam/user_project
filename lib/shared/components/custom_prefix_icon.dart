import 'package:user_project/style/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomPrefixIcon extends StatelessWidget {

  final Icon icon ;
  final onPressed;


  CustomPrefixIcon({required this.icon , this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(

      padding: EdgeInsets.fromLTRB(
        0,
        0,
        getProportionateScreenWidth(10),
        0,
      ),
      /*child: Icon(icon),*/
      child: IconButton(
          onPressed: onPressed,
          icon: icon),
    );
  }


}
