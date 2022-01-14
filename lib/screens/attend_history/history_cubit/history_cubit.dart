import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_project/models/attend_model.dart';
import 'package:user_project/shared/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'history_state.dart';

class HistoryCubit extends Cubit<HistoryStates> {
  List<AttendanceModel> listAttendance = [];

  HistoryCubit() : super(InitialState());

  static HistoryCubit get(context) => BlocProvider.of(context);

  void getHistoryData() {
    FirebaseFirestore.instance
        .collection(ATTENDANCE)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(DateFormat.y().format(DateTime.now()))
        .get()
        .then((value) {
      value.docs.forEach((element) {
        listAttendance.add(AttendanceModel.fromMap(element.data()));
        emit(OnGetHistorySuccess());
      });
    }).catchError((error){
      print(error.toString());
      emit(OnGetHistoryError());
    });
  }
}
