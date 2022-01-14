import 'package:user_project/screens/sign_in/sign_in_screen.dart';
import 'package:user_project/screens/splash/components/body.dart';
import 'package:user_project/screens/splash/cubit/splash_cubit.dart';
import 'package:user_project/shared/constants/constants.dart';
import 'package:user_project/shared/database/local/cache_helper.dart';
import 'package:user_project/shared/methods.dart';
import 'package:user_project/style/colors.dart';
import 'package:user_project/style/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen

    return BlocProvider(
      create: (BuildContext context)=>SplashCubit(),
      child: Scaffold(
        body: Body(),
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () {
                submit(context);
              },
              child: Padding(
                padding: const EdgeInsetsDirectional.only(
                  end: 20.0
                ),
                child: Text(
                  'Skip',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(
                      color: kPrimaryColor,
                      fontSize:getProportionateScreenWidth(18)
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void submit(BuildContext context) {
    CachedHelper.saveData(key: ON_BOARDING, value: true).then((value) {
      if (value) {
        print(value);
        navigateToAndFinish(context, SignInScreen());
      }
    });
  }

}
