import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:user_project/models/user_model.dart';
import 'package:user_project/shared/constants/constants.dart';
import 'package:user_project/shared/database/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'complete_profile_states.dart';

class CompleteProfileCubit extends Cubit<CompleteProfileStates> {
  CompleteProfileCubit() : super(InitialState());

  static CompleteProfileCubit get(context) => BlocProvider.of(context);

  Future setUserInfo({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String address,
    required String birthdate,
  }) async {
    String userUid = CachedHelper.getString(key: USER_UID) ?? '';
    UserModel userModel = UserModel(
      firstName: firstName,
      lastName: lastName,
      address: address,
      uid: userUid,
      phoneNumber: phoneNumber,
      dateOfBirth: birthdate,
      isActive: 'waiting',
      image: DEFUlt,
      department: DEFUlt,
      cover: DEFUlt,
      increment: DEFUlt,
      jobDesc: DEFUlt,
      militryService: DEFUlt,
      sallary: DEFUlt,
      sallaryThen: DEFUlt,
      hire: DateFormat.MMMEd().format(DateTime.now()),
    );
    FirebaseFirestore.instance
        .collection(USERS)
        .doc(userUid)
        .set(userModel.toMap())
        .then((value) {
      emit(UploadDataCompleteProfileSuccess());
    }).catchError((error) {
      print(error.toString());
    });
  }

}
