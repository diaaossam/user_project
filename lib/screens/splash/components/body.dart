import 'package:user_project/screens/splash/components/splash_content.dart';
import 'package:user_project/screens/splash/cubit/splash_cubit.dart';
import 'package:user_project/screens/splash/cubit/splash_states.dart';
import 'package:user_project/shared/components/default_button.dart';
import 'package:user_project/style/colors.dart';
import 'package:user_project/style/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../splash_screen.dart';
// This is the best practice

class Body extends StatelessWidget {
  int currentPage = 0;
  var boardController = PageController();

  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to Diaa Hr Manger! Test 1 ",
      "image": "assets/images/splash_1.png"
    },
    {
      "text":
      "This The Project For Hr Manger ,, Diaa Test 2  , Lets Enjoy ",
      "image": "assets/images/splash_2.png"
    },
    {
      "text": "This The Project For Hr Manger ,, Diaa Test  3  , Lets Enjoy",
      "image": "assets/images/splash_3.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashCubit, SplashStates>(
      listener: (context, states) {},
      builder: (context, states) {
        SplashCubit cubit = SplashCubit.get(context);
        return Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (index) {
                  if (index == splashData.length - 1)
                    cubit.changePageViewState(true);
                  else
                    cubit.changePageViewState(false);
                },
                itemCount: splashData.length,
                physics: BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context, index) =>
                    SplashContent(
                      image: splashData[index]["image"],
                      text: splashData[index]['text'],
                    ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    SmoothPageIndicator(
                      controller: boardController,
                      count: splashData.length,
                      effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: kPrimaryColor,
                        dotHeight: 10,
                        expansionFactor: 4,
                        dotWidth: 10,
                        spacing: 5.0,
                      ),
                    ),
                    Spacer(flex: 3),
                    DefaultButton(
                      text: "Continue",
                      press: () {
                        if (cubit.isLast) {
                          SplashScreen.submit(context);
                        } else {
                          boardController.nextPage(
                              duration: const Duration(
                                milliseconds: 750,
                              ),
                              curve: Curves.fastLinearToSlowEaseIn);
                        }
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
