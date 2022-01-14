import 'package:bloc/bloc.dart';
import 'package:user_project/main_layout/cubit/MainLayoutCubit.dart';
import 'package:user_project/screens/profile_screen/cubit/profile_screen_cubit.dart';
import 'package:user_project/screens/qr_code_scanner/qr_cubit/qr_cubit.dart';
import 'package:user_project/screens/requests_screen/cubit/req_cubit.dart';
import 'package:user_project/screens/startscreen/startscreen.dart';
import 'package:user_project/shared/app_cubit/cubit_observer.dart';
import 'package:user_project/shared/database/local/cache_helper.dart';
import 'package:user_project/shared/database/services/dio_helper.dart';
import 'package:user_project/style/styles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await CachedHelper.init();
      await Firebase.initializeApp();
      DioHelper.init();
      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>QrScannerCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        home: StartScreen(),
      ),
    );
  }
}
