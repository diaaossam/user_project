import 'package:user_project/models/user_model.dart';
import 'package:user_project/screens/profile_edit/profile_edit.dart';
import 'package:user_project/screens/profile_screen/profile_screen.dart';
import 'package:user_project/shared/components/bottom_nav_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:user_project/shared/constants/constants.dart';
import 'package:user_project/shared/methods.dart';
import 'package:user_project/style/size_config.dart';
import 'cubit/MainLayoutCubit.dart';
import 'cubit/MainLayoutStates.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MainLayoutCubit()
          ..getUserInfo()
          ..getToken(),
        child: BlocConsumer<MainLayoutCubit, MainLayoutStates>(
          listener: (context, state) {},
          builder: (context, state) {
            MainLayoutCubit cubit = MainLayoutCubit.get(context);
            UserModel? userModel = MainLayoutCubit.get(context).userModel;
            return userModel == null
                ? Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  )
                : Scaffold(
                    bottomNavigationBar: BottomNavigationBar(
                      items: cubit.bottomNavList,
                      onTap: (index) {
                        cubit.changeBottomNavIndex(index);
                      },
                      type: BottomNavigationBarType.fixed,
                      currentIndex: cubit.currentIndex,
                    ),
                    body: cubit.screens[cubit.currentIndex],
                  );
          },
        ));
  }
}
