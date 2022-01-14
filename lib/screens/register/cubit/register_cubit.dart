import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_project/models/user_model.dart';
import 'package:user_project/screens/register/cubit/register_states.dart';
import 'package:user_project/shared/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(InitialRegisterStates());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void regiterNewUser(
      {required context,
      required String email,
      required String password}) async {
    emit(RegisterLoadingSignInState());
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
          Navigator.pop(context);
    }).catchError((error) {
      emit(RegisterFailureSignInState(error));
    });
  }


}
