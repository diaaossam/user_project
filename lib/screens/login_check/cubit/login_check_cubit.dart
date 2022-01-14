import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:user_project/models/request_model.dart';
import 'package:user_project/models/token_model.dart';
import 'package:user_project/models/user_model.dart';
import 'package:user_project/screens/login_check/cubit/login_check_states.dart';
import 'package:user_project/shared/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_project/shared/database/services/dio_helper.dart';

class LoginCheckCubit extends Cubit<LoginCheckStates> {
  UserModel? userModel;
  final User? _user = FirebaseAuth.instance.currentUser;
  String? uid;

  LoginCheckCubit() : super(InitialState());

  static LoginCheckCubit get(context) => BlocProvider.of(context);

  void getUserInfo() {
    uid = _user!.uid;
    FirebaseFirestore.instance
        .collection(USERS)
        .where("uid", isEqualTo: uid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        userModel = UserModel.fromJson(element.data());
      });
      emit(GetInfoSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetInfoFailed());
    });
  }


  //notification
  Future sendRequest(String date) async {
    getUserInfo();
    await FirebaseFirestore.instance
        .collection('Token')
        .where('isAdmin', isEqualTo: true)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        TokenModel tokenModel = TokenModel.fromJson(element.data());
        print(tokenModel.token);
        final data = {
          "to": "${tokenModel.token}",
          "notification": {
            "body":
                "'${userModel!.firstName} ${userModel!.lastName}' want to Access App ",
            "title": "Request From User",
            "sound": "default"
          },
          "android": {
            "priority": "HIGH",
            "notification": {
              "notification_priority": "PRIORITY_HIGH",
              "sound": "default",
              "default_sound": true,
              "default_vibrate_timings": true,
              "default_light_settings": true,
            },
          },
          "data": {
            "type": "order",
            "id": "87",
            "click_action": "FLUTTER_NOTIFICATION_CLICK",
          }
        };
        DioHelper().postData(path: 'fcm/send', data: data).then((value) {
          if (value.statusCode == 200) {
            _setUpRequests(date);
          }
        }).catchError((error) {
          print(error.toString());
        });
      });
    });
  }

  void _setUpRequests(String date) {
    RequestModel requestModel = RequestModel(
        date: date,
        reason: 'Permission',
        response: WAITING,
        isRest: false,
        uid: _user!.uid,
        userName: '${userModel!.firstName} ${userModel!.lastName}');

    //send To Admin
    FirebaseFirestore.instance
        .collection(REQUEST)
        .doc(_user!.uid)
        .set(requestModel.toMap());

  }
}
