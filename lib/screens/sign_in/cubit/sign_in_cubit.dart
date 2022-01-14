import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_project/screens/complete_profile/complete_profile_screen.dart';
import 'package:user_project/screens/login_check/login_check_screen.dart';
import 'package:user_project/screens/sign_in/cubit/sign_in_states.dart';
import 'package:user_project/shared/constants/constants.dart';
import 'package:user_project/shared/database/local/cache_helper.dart';
import 'package:user_project/shared/methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInCubit extends Cubit<SignInStates> {
  SignInCubit() : super(InitialState());

  static SignInCubit get(context) => BlocProvider.of(context);

  bool isPasswordVisibleSignIn = true;
  bool isRemeber = false;

  void changePasswordVisibaltySignIn() {
    isPasswordVisibleSignIn = !isPasswordVisibleSignIn;
    emit(ChangePasswordVisibiltySignIn());
  }

  void checkBoxState(bool from) {
    isRemeber = from;
    emit(RememberMeCheckBoxState());
  }

  void signInWithGoogle(context) async {
    emit(LoginLoadingGoogleState());
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      CachedHelper.saveData(key: USER_UID, value: value.user!.uid);
      checkFirestoreInfo(context, value.user!.uid);
      emit(LoginSuccessGoogleState());
    }).catchError((error) {
      print(error.toString());
      emit(LoginFailureGoogleState(error.toString()));
    });
  }

  Future signInWithEmailAndPassword({
    required String email,
    required String password,
    required context,
  }) async {
    emit(LoginLoadingSignInState());
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      CachedHelper.saveData(key: USER_UID, value: value.user!.uid);
      checkFirestoreInfo(context, value.user!.uid);

      emit(LoginSuccessSignInState());
    }).catchError((error) {
      print(error.toString());
      emit(LoginFailureSignInState(error.toString()));
    });
  }

  void checkFirestoreInfo(BuildContext context, String uid) {
    FirebaseFirestore.instance.collection(USERS).doc().get().then((value) {
      if (value.exists) {
        navigateToAndFinish(context, LoginStatuesScreen());
      } else {
        navigateToAndFinish(context, CompleteProfileScreen());
      }
    }).catchError((error) {
      print(error.toString());
    });
  }


  


}
