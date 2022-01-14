import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:user_project/screens/requests_screen/custom_card_request.dart';
import 'package:user_project/style/size_config.dart';

import 'cubit/req_cubit.dart';
import 'cubit/req_states.dart';

class RequestsScreen extends StatelessWidget {
  var rest = TextEditingController();
  var date = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RequestsCubit()..getOldRequest()..getUserInfo(),
      child: BlocConsumer<RequestsCubit, RequestStatesFinal>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                RequestsCubit.get(context).list.length == 0
                    ? Expanded(
                        child: SingleChildScrollView(),
                      )
                    : Expanded(
                        child: ListView.builder(
                            itemBuilder: (context, index) => CustomRequestCard(
                                RequestsCubit.get(context).list[index]),
                            itemCount: RequestsCubit.get(context).list.length),
                      ),
                Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: FloatingActionButton(
                      child: Icon(Icons.add),
                      onPressed: () {
                        showDialog(context, RequestsCubit.get(context));
                      }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  TextFormField buildBirthDateFormField(context) {
    return TextFormField(
      keyboardType: TextInputType.datetime,
      controller: date,
      onTap: () {
        showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2025, 12, 20))
            .then((value) {
          date.text = DateFormat.yMMMEd().format(value!);
        });
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "Rest date is required";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Rest Date",
        border: OutlineInputBorder(),
        hintText: "Enter your Rest date",
        hintStyle: Theme.of(context).textTheme.bodyText1,
        labelStyle: Theme.of(context).textTheme.bodyText1,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.date_range),
      ),
    );
  }

  TextFormField buildRestReason(context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: rest,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Rest Reason is required';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Rest Reason",
        border: OutlineInputBorder(),
        hintText: "Enter your Rest Reason",
        hintStyle: Theme.of(context).textTheme.bodyText1,
        labelStyle: Theme.of(context).textTheme.bodyText1,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.text_fields),
      ),
    );
  }

  AwesomeDialog showDialog(context, RequestsCubit cubit) {
    return AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.INFO,
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              buildBirthDateFormField(context),
              SizedBox(
                height: getProportionateScreenHeight(15.0),
              ),
              buildRestReason(context)
            ],
          ),
        ),
      ),
      btnOkOnPress: () {
        cubit.sendRequest(date.text, rest.text);
      },
    )..show();
  }
}
