import 'package:user_project/screens/attend_history/components/custom_card.dart';
import 'package:user_project/screens/attend_history/history_cubit/history_cubit.dart';
import 'package:user_project/screens/attend_history/history_cubit/history_state.dart';
import 'package:user_project/style/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryCubit()..getHistoryData(),
      child: BlocConsumer<HistoryCubit, HistoryStates>(
        listener: (context, state) {},
        builder: (context, state) {
          HistoryCubit cubit = HistoryCubit.get(context);
          return Padding(
            padding: EdgeInsets.all(getProportionateScreenHeight(20.0)),
            child: ListView.separated(
                itemBuilder: (context, index) => CardHistoryItem(
                    cubit.listAttendance[index].isAttend,
                    cubit.listAttendance[index].attendTime,
                    cubit.listAttendance[index].leaveTime,
                    '${cubit.listAttendance[index].monthDay} ${cubit.listAttendance[index].year}'
                ),
                separatorBuilder: (context, index) => Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey,
                    ),
                itemCount: cubit.listAttendance.length),
          );
        },
      ),
    );
  }
}
