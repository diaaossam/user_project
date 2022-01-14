import 'package:intl/intl.dart';
import 'package:user_project/screens/login_check/cubit/login_check_cubit.dart';
import 'package:user_project/screens/login_check/cubit/login_check_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_project/shared/constants/constants.dart';

import 'components/body.dart';

class LoginStatuesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCheckCubit()..getUserInfo(),
      child: BlocConsumer<LoginCheckCubit, LoginCheckStates>(
        listener: (context, state) {},
        builder: (context, state) {
          LoginCheckCubit cubit = LoginCheckCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              leading: SizedBox(),
              title: Text("Login Check"),
            ),
            body: cubit.userModel != null
                ? Body(cubit.userModel!.isActive ?? '' , cubit)
                : CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
