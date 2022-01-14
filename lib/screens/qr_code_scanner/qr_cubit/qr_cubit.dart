import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_project/models/attend_model.dart';
import 'package:user_project/models/user_model.dart';
import 'package:user_project/screens/qr_code_scanner/qr_cubit/qr_states.dart';
import 'package:user_project/shared/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class QrScannerCubit extends Cubit<QrScannerStates> {
  User? _user = FirebaseAuth.instance.currentUser;
  UserModel ? userModel;

  QrScannerCubit() : super(InitialState());

  static QrScannerCubit get(context) => BlocProvider.of(context);


  void getUserInfo() {
    FirebaseFirestore.instance
        .collection(USERS)
        .where("uid", isEqualTo: _user!.uid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        userModel = UserModel.fromJson(element.data());
      });
      emit(GetUserQrInfo());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserQrInfoFailed());
    });
  }

  void setUpAttendance(String result) {
    String monthDay = DateFormat.MMMd().format(DateTime.now());
    String year = DateFormat.y().format(DateTime.now());
    String currentTime = DateFormat.jm().format(DateTime.now());

    if (result.contains(CHECK_IN)) {
      if (result.contains(monthDay)) {
        AttendanceModel attendanceModel = AttendanceModel(
            isAttend: true,
            attendTime: currentTime,
            leaveTime: 'Still In Work',
            monthDay: "${monthDay}",
            year: "${year}");

        FirebaseFirestore.instance
            .collection(ATTENDANCE)
            .doc(_user!.uid)
            .collection(year)
            .doc(monthDay)
            .set(attendanceModel.toMap())
            .then((value) {
          FirebaseFirestore.instance.collection(monthDay).doc(_user!.uid).set({
            'date': DateFormat.MMMd().format(DateTime.now()),
            'isAttend': true,
            'isRest': false,
            'userName': '${userModel!.firstName} ${userModel!.lastName}',
          });
        });
      }
    } else if (result.contains(CHECK_OUT)) {
      FirebaseFirestore.instance
          .collection(ATTENDANCE)
          .doc(_user!.uid)
          .collection(year)
          .doc(monthDay)
          .update({"leaveTime": "${currentTime}"});
    }
  }
}
