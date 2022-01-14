import 'package:bloc/bloc.dart';
import 'package:user_project/screens/splash/cubit/splash_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashStates> {
  bool isLast = false;

  SplashCubit() : super(InitialStates());

  static SplashCubit get(BuildContext context)=>BlocProvider.of(context);

  void changePageViewState(bool from){
    isLast=from;
    emit(LastPageView());
  }
}
