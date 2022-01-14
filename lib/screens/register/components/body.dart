import 'package:user_project/style/size_config.dart';
import 'package:flutter/material.dart';

import 'register_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.bodyHeight * 0.04), // 4%
                Text("Register Account",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: getProportionateScreenWidth(28),
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                        )),
                Text(
                  "Complete your details or continue \nwith social media",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(height: SizeConfig.bodyHeight * 0.08),
                SignUpForm(),
                SizedBox(height: SizeConfig.bodyHeight * 0.08),
                SizedBox(height: getProportionateScreenHeight(20)),
                Text(
                  'By continuing your confirm that you agree \nwith our Term and Condition',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
