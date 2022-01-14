import 'package:intl/intl.dart';
import 'package:user_project/main_layout/main_layout.dart';
import 'package:user_project/screens/login_check/cubit/login_check_cubit.dart';
import 'package:user_project/shared/components/default_button.dart';
import 'package:user_project/shared/methods.dart';
import 'package:user_project/style/size_config.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  String userStatue;
  LoginCheckCubit cubit;


  Body(this.userStatue, this.cubit);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.bodyHeight * 0.04),
        Center(child: setImage(context)),
        SizedBox(height: SizeConfig.bodyHeight * 0.08),
        buildText(),
        Spacer(),
        userStatue ==
            'active' ?
        SizedBox(
          width: SizeConfig.screenWidth * 0.6,
          child: DefaultButton(
            text: "Back to Main",
            press: () {
              navigateToAndFinish(context, MainLayout());
            },
          ),
        ) :
        SizedBox(
          width: SizeConfig.screenWidth * 0.6,
          child: DefaultButton(
            text: "Ask Access",
            press: () {
              cubit.sendRequest(DateFormat.yMMMEd().format(DateTime.now()));
            },
          ),
        ),
        Spacer(),
      ],
    );
  }

  Widget setImage(context) {
    if (userStatue == 'active') {
      SnackBar(
        content: Text('Login Success'),
      );
      return Image.asset(
        "assets/images/success.png",
        height: SizeConfig.bodyHeight * 0.4, //40%
      );
    } else if (userStatue == 'waiting') {
      return Image.asset(
        "assets/images/waiting.png",
        height: SizeConfig.bodyHeight * 0.4, //40%
      );
    } else {
      return Image.asset(
        "assets/images/error.png",
        height: SizeConfig.bodyHeight * 0.4, //40%
      );
    }
  }

  Widget buildText() {
    if (userStatue == 'active') {
      return Text(
        "Login Success",
        style: TextStyle(
          fontSize: getProportionateScreenWidth(30),
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      );
    } else if (userStatue == 'waiting') {
      return Text(
        "User Pending",
        style: TextStyle(
          fontSize: getProportionateScreenWidth(30),
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      );
    } else {
      return Text(
        "You Are Fired !",
        style: TextStyle(
          fontSize: getProportionateScreenWidth(30),
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      );
    }
  }
}
