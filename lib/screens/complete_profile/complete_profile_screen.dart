
import 'package:user_project/style/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'complete_profile_cubit/complete_profile_cubit.dart';
import 'components/body.dart';

class CompleteProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (BuildContext context)=>CompleteProfileCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Complete your Register'),
        ),
        body: Body(),
      ),
    );
  }


}
