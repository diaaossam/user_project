import 'package:user_project/screens/profile_edit/profile_edit.dart';
import 'package:user_project/screens/profile_screen/components/body.dart';
import 'package:user_project/screens/profile_screen/cubit/profile_screen_states.dart';
import 'package:user_project/shared/methods.dart';
import 'package:user_project/style/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/profile_screen_cubit.dart';

class ProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileScreenCubit()..getUserInfo(),
      child:BlocConsumer<ProfileScreenCubit, ProfileScreenState>(
        listener: (context, state) {},
        builder: (context, state) {
          ProfileScreenCubit cubit = ProfileScreenCubit.get(context);
          return cubit.userModel !=null ? Scaffold(
            appBar: AppBar(
              actions: [
                TextButton(
                    onPressed: () {
                      navigateTo(context,
                          EditProfileScreen(cubit.userModel!));
                    },
                    child: Text('Edit')),
                SizedBox(
                  width: getProportionateScreenWidth(10),
                )
              ],
            ),
            body: cubit.userModel != null
                ? Body(cubit.userModel!, ProfileScreenCubit.get(context))
                : Center(
              child: CircularProgressIndicator(),
            ),
          ) : Scaffold(
            body: Center(child: CircularProgressIndicator(),),
          );
        },
      ),

    );
  }
}
