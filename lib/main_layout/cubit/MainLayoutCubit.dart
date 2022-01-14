import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_project/models/token_model.dart';
import 'package:user_project/models/user_model.dart';
import 'package:user_project/screens/attend_history/history_screen.dart';
import 'package:user_project/screens/profile_screen/profile_screen.dart';
import 'package:user_project/screens/qr_code_scanner/qr_code.dart';
import 'package:user_project/screens/requests_screen/request_screen.dart';
import 'package:user_project/screens/screen/test.dart';
import 'package:user_project/shared/constants/constants.dart';
import 'package:user_project/shared/database/local/cache_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'MainLayoutStates.dart';

class MainLayoutCubit extends Cubit<MainLayoutStates> {
  int currentIndex = 0;
  final User? _user = FirebaseAuth.instance.currentUser;
  UserModel? userModel;

  MainLayoutCubit() : super(InitialState());
  static MainLayoutCubit get(BuildContext context) => BlocProvider.of(context);


  List<String> title = ['QrCodeGenrator', 'Request Page', 'Attend History' , 'Profile'];

  List<BottomNavigationBarItem> bottomNavList = [
    BottomNavigationBarItem(
      icon: Icon(Icons.qr_code),
      label: 'Qr Scanner',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.report),
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
  ];

  List<Widget> screens = [
    QrCodeScanner(),
    RequestsScreen(),
    HistoryScreen(),
    ProfileScreen(),
  ];


  void changeBottomNavIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomNavIndex());
  }

  void getToken() {
    String uid = _user!.uid;
    FirebaseMessaging.instance.getToken().then((value) {
      TokenModel tokenModel =
          TokenModel(uid: uid, isAdmin: false, token: value.toString());

      FirebaseFirestore.instance
          .collection('Token')
          .doc(uid)
          .set(tokenModel.toMap());
    });
  }

  void getUserInfo() {
    FirebaseFirestore.instance
        .collection(USERS)
        .doc(_user!.uid)
        .get()
        .then((value) {
      print(value.data());
      userModel = UserModel.fromJson(value.data()!);
      emit(GetUserInfoMainSuccess());
    }).catchError((error) {
      emit(GetUserInfoMainFailed());
    });
  }
}
