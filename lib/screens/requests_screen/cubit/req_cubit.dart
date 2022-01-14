import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:user_project/models/request_model.dart';
import 'package:user_project/models/token_model.dart';
import 'package:user_project/models/user_model.dart';
import 'package:user_project/screens/requests_screen/cubit/req_states.dart';
import 'package:user_project/shared/constants/constants.dart';
import 'package:user_project/shared/database/services/dio_helper.dart';

class RequestsCubit extends Cubit<RequestStatesFinal> {
  final User? _user = FirebaseAuth.instance.currentUser;
  RequestModel? requestModel;
  List<RequestModel> list = [];
  UserModel? _userModel;

  RequestsCubit() : super(InitialStateFinalReq());

  static RequestsCubit get(BuildContext context) => BlocProvider.of(context);

  //notification
  Future sendRequest(String date, String reason) async {
    await FirebaseFirestore.instance
        .collection('Token')
        .where('isAdmin', isEqualTo: true)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        TokenModel tokenModel = TokenModel.fromJson(element.data());
        final data = {
          "to": "${tokenModel.token}",
          "notification": {
            "body": "'${_userModel!.firstName} ${_userModel!.lastName}' want to have rest on ${date} ",
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
            _setUpRequests(date, reason);
          }
        }).catchError((error) {
          print(error.toString());
        });
      });
    });
  }

  void _setUpRequests(String date, String reason) {
    RequestModel requestModel = RequestModel(
        uid: _user!.uid,
        response: WAITING,
        isRest: true,
        reason: reason,
        date: date,
        userName: '${_userModel!.firstName} ${_userModel!.lastName}');

    //set Old Request User
    FirebaseFirestore.instance
        .collection(_user!.uid)
        .doc(DateFormat.yMMMEd().format(DateTime.now()))
        .set(requestModel.toMap())
        .then((value) {
      getOldRequest();
    });

    //add to Rest Page
    FirebaseFirestore.instance
        .collection('rest')
        .doc(_user!.uid)
        .set(requestModel.toMap());

    //send To Admin
    FirebaseFirestore.instance
        .collection(REQUEST)
        .doc(_user!.uid)
        .set(requestModel.toMap());
  }

  //getALlRequest
  void getOldRequest() {
    list.clear();
    FirebaseFirestore.instance.collection(_user!.uid).get().then((value) {
      value.docs.forEach((element) {
        list.add(RequestModel.fromMap(element.data()));
        emit(GetAllOldRequests());
      });
    });
  }

  //getUserInfo
  void getUserInfo() {
    FirebaseFirestore.instance
        .collection(USERS)
        .where("uid", isEqualTo: _user!.uid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        _userModel = UserModel.fromJson(element.data());
      });
      emit((GetUserInfoSuccess()));
    }).catchError((error) {
      print(error.toString());
      emit((GetUserInfoSuccess()));
    });
  }
}
