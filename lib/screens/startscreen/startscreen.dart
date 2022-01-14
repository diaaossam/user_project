import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_project/screens/complete_profile/complete_profile_screen.dart';
import 'package:user_project/screens/login_check/login_check_screen.dart';
import 'package:user_project/screens/sign_in/sign_in_screen.dart';
import 'package:user_project/screens/splash/splash_screen.dart';
import 'package:user_project/shared/constants/constants.dart';
import 'package:user_project/shared/database/local/cache_helper.dart';
import 'package:user_project/style/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return checkIsOnBoarding();
  }
}

Widget checkIsOnBoarding() {
  bool isOnBoardingDone = CachedHelper.getBooleon(key: ON_BOARDING) ?? false;
  if (isOnBoardingDone) {
    return checkIsLogin();
  } else {
    return SplashScreen();
  }
}

Widget checkIsLogin() {
  String userUid = CachedHelper.getString(key: USER_UID) ?? 'start';
  if (userUid != 'start') {
    return LandingPage(userUid);
  } else {
    return SignInScreen();
  }
}

class LandingPage extends StatelessWidget {
  String userId;

  LandingPage(this.userId);

  Future<QuerySnapshot> getData() async {
    return await FirebaseFirestore.instance
        .collection(USERS)
        .where("uid", isEqualTo: userId)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<QuerySnapshot>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final querySnaphost = snapshot.data; // Get query snapsh
            if (querySnaphost!.docs.isNotEmpty) {

              return LoginStatuesScreen(); // Get the data
            } else {
              return CompleteProfileScreen();
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
