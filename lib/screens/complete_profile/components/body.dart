import 'package:user_project/style/size_config.dart';
import 'package:flutter/material.dart';
import 'complete_profile_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.bodyHeight * 0.03),
              Text("Complete Profile",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                  ),
              ),
              Text(
                "Complete your details or continue  \nwith social media",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: SizeConfig.bodyHeight * 0.06),
              CompleteProfileForm(),
              SizedBox(height: getProportionateScreenHeight(30)),
              Text(
                "By continuing your confirm that you agree \nwith our Term and Condition",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
