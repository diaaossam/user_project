import 'package:user_project/screens/register/register_screen.dart';
import 'package:user_project/shared/methods.dart';
import 'package:user_project/style/colors.dart';
import 'package:user_project/style/size_config.dart';
import 'package:flutter/material.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don’t have an account? ",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: getProportionateScreenWidth(16)
          ),
        ),
        GestureDetector(
          onTap: () {
            navigateTo(context, RegisterScreen());
          },
          child: Text(
            "Sign Up",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
