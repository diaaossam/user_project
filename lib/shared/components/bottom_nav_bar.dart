import 'package:user_project/main_layout/cubit/MainLayoutCubit.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  MainLayoutCubit cubit;

  BottomNavBar(this.cubit);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.qr_code),
          label: 'Qr Genrator',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.request_page),
          label: 'Request',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.supervised_user_circle_sharp),
          label: 'Profile',
        ),

      ],
      onTap: (index) {
        cubit.changeBottomNavIndex(index);
      },
      currentIndex: cubit.currentIndex,
      type: BottomNavigationBarType.fixed,

    );
  }
}
