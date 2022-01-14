import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/body.dart';
import 'cubit/register_cubit.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>RegisterCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sign Up"),
        ),
        body: Body(),
      ),
    );
  }
}
