import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:user_project/screens/sign_in/cubit/sign_in_cubit.dart';
import 'package:user_project/screens/sign_in/cubit/sign_in_states.dart';
import 'package:user_project/shared/components/social_card.dart';
import 'package:user_project/style/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'no_account_text.dart';
import 'sign_form.dart';

class Body extends StatelessWidget {
  var phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit,SignInStates>(
        listener: (context,states){},
        builder: (context,states){
          SignInCubit cubit = SignInCubit.get(context);
          return Padding(
            padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.bodyHeight * 0.04),
                  Text(
                    "Welcome Back",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: getProportionateScreenWidth(28),
                        fontWeight: FontWeight.bold
                    )
                  ),
                  SizedBox(height: SizeConfig.bodyHeight * 0.01),
                  Text(
                    "Sign in with your email and password  \nor continue with social media",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1!,
                  ),
                  SizedBox(height: SizeConfig.bodyHeight * 0.08),
                  SignForm(),
                  SizedBox(height: SizeConfig.bodyHeight * 0.08),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialCard(
                        icon: "assets/icons/google-icon.svg",
                        press: () {
                          SignInCubit.get(context).signInWithGoogle(context);
                        },
                      ),
                      SocialCard(
                        icon: "assets/icons/facebook-2.svg",
                        press: () {
                          
                        },
                      ),
                      SocialCard(
                        icon: "assets/icons/Phone.svg",
                        press: () {
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  NoAccountText(),
                ],
              ),
            ),
          );
        },
    );
  }
}
